#!/usr/bin/python3
# -*- coding: utf-8 -*-
"""
Read ranking files and produce challenge rankings
"""

__appname__ = "HIPE"
__author__ = "simon.clematide@uzh.ch"
__version__ = "0.0pre0"
__license__ = "GNU GPL 3.0 or later"

import csv
import logging
import collections
import re

log = logging.getLogger(__name__)
from typing import Dict, Tuple, List


def ranking2points(rank: int) -> int:
    """Return points for a given zero-indexed ranking

    See HIPE 2022 Guidelines page 16

    0 => 50
    1 => 40
    2 => 30
    3 => 20
    4 => 10
    5- => 0

    """
    return max(0, 50 - rank * 10)


class ChallengeEvaluation(object):
    """Class capsulating all functionality for the HIPE challenge evaluation protocoll"""

    def __init__(self, args):
        self.args = args
        self.challenge = self.args.challenge.upper()
        self.teams = set(self.args.teams) if self.args.teams else set()
        self.datasets = set()
        self.languages = set()
        self.valid_bundles = set(self.args.bundles) if self.args.bundles else set()
        self.relevant_rankings = collections.defaultdict(
            list
        )  # Dict[Tuple[str, str],List[List[str]]]
        self.dataset_subchallenge_results = []  # List[Dict[str,str]

    def run(self) -> None:
        log.warning(self.args)

        if self.args.aggregate_subchallenge_results:
            for f in self.args.infiles:
                self.read_dataset_team_ranking(f)
            self.output_challenge_team_rankings()
        else:
            for f in self.args.infiles:
                self.read_ranking_file(f)
            log.debug(self.relevant_rankings)
            self.output_subchallenge_tsv()
            self.output_subchallenge_team_rankings()

    def read_dataset_team_ranking(self,filename:str) -> None:
        """Read dataset team ranking files

        e.g.
        CHALLENGE	RANK	POINTS	TEAM	DATASET	LANGUAGE	F1	System
MCC:NERC-Coarse	1	50	team2	ajmc	de	0.952	team2_bundle3_ajmc_de_2
MCC:NERC-Coarse	2	40	team1	ajmc	de	0.945	team1_bundle4_ajmc_de_2
MCC:NERC-Coarse	1	50	team1	ajmc	en	0.910	team1_bundle4_ajmc_en_2
MCC:NERC-Coarse	2	40	team2	ajmc	en	0.894	team2_bundle1_ajmc_en_1
MCC:NERC-Coarse	1	50	team1	ajmc	fr	0.888	team1_bundle4_ajmc_fr_1
MCC:NERC-Coarse	2	40	team2	ajmc	fr	0.872	team2_bundle3_ajmc_fr_2


        """
        with open(filename, "r") as f:

            reader = csv.DictReader(
                f, delimiter="\t", quotechar="", quoting=csv.QUOTE_NONE
            )
            logging.info(f"Reading results from {filename}")
            for r in reader:
                self.dataset_subchallenge_results.append(r)
        log.info(f"Team subchallenge dataset rankings read in {len(self.dataset_subchallenge_results)}")
        log.debug(f"Dataset results {self.dataset_subchallenge_results}")

    def output_challenge_team_rankings(self):
        """Output the challenge team rankings"""

        outstream = (
            open(self.args.outfile_challenge_team_ranking, "w")
            if self.args.outfile_challenge_team_ranking
            else None
        )
        team2points = collections.Counter()


        last_points = 10000000
        last_rank = 0
        current_ties = 0

        fieldnames = ["CHALLENGE", "RANK", "POINTS", "TEAM"]
        print("\t".join(fieldnames), file=outstream)

        # Accumulate the points
        for r in self.dataset_subchallenge_results:
            team2points[r["TEAM"]] += int(r["POINTS"])

        for rank, (team, points) in enumerate(team2points.most_common(), 1):
            if points == last_points:
                logging.debug(f"Tie at {points} point by {team}: last rank {last_rank} last points {last_points} ")
                rank = last_rank
                current_ties += 1
            else:
                current_ties = 0
                last_rank = rank
                last_points = points

            print(self.challenge, rank, points, team, sep="\t", file=outstream)

        if outstream:
            outstream.close()

    def read_ranking_file(self, filename: str) -> None:
        """Read files like this and filter out
                - irrelevant teams
                - irrelevant runs by the same team
                - irrelevant counts (keep only ALL)

                Assume the ranking files to be sorted by F1 score.

        System	Evaluation	Label	P	R	F1	TP	FP	FN
        team4_bundle4_sonar_de_2	NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL	ALL	0.655	0.741	0.695	349	184	122
        team4_bundle4_sonar_de_1	NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL	ALL	0.671	0.718	0.693	338	166	133
        neurbsl_bundle3_sonar_de_1	NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL	ALL	0.41	0.554	0.471	261	376	210
        team4_bundle4_sonar_de_1	NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL	LOC	0.783	0.836	0.809	148	41	29


        """

        seen_teams = set()
        rank = 0
        with open(filename, "r") as f:
            reader = csv.DictReader(
                f, delimiter="\t", quotechar="", quoting=csv.QUOTE_NONE
            )
            if self.args.avg_ne_fine_nested_lit:
                reader = self.get_avg_ne_fine_nested_results(reader)
            for row in reader:
                if row["Label"] != "ALL":
                    continue

                split_system_value = row["System"].split("_")
                if len(split_system_value) != 5:
                    log.warning(f"{split_system_value}")
                team, bundle, dataset, language, run = row["System"].split("_")
                if bundle not in self.valid_bundles:
                    continue
                if team not in self.teams:
                    log.info(f"Ignoring team {team}")
                    continue
                if team in seen_teams:
                    continue
                else:
                    seen_teams.add(team)
                    row["CHALLENGE"] = self.challenge
                    row["RANK"] = rank + 1
                    row["TEAM"] = team
                    row["DATASET"] = dataset
                    self.datasets.add(dataset)
                    row["LANGUAGE"] = language
                    self.languages.add(language)
                    row["RUNID"] = run
                    row["RANK"] = rank + 1
                    row["POINTS"] = ranking2points(rank)
                    row["F1"] = f"{float(row['F1']):.03f}"
                    self.relevant_rankings[(dataset, language)].append(row)
                    rank += 1

    def get_avg_ne_fine_nested_results(self, reader):
        """Return modified list of dicts where the F1 Scores of corresponding fine and nested have been averages
                 - the list is then sorted again by the averaged F1 scores in descending order

        ```
        System	Evaluation	Label	P	R	F1	TP	FP	FN
        team2_bundle1_hipe2020_fr_1	NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL	ALL	0.702	0.782	0.74	1251	531	349
        team2_bundle1_hipe2020_fr_2	NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL	ALL	0.697	0.779	0.736	1246	541	354
        team2_bundle3_hipe2020_fr_1	NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL	ALL	0.679	0.767	0.72	1227	581	373
        neurbsl_bundle3_hipe2020_fr_1	NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL	ALL	0.685	0.733	0.708	1172	538	428
        team2_bundle1_hipe2020_fr_2	NE-NESTED-micro-strict-TIME-ALL-LED-ALL	ALL	0.39	0.366	0.377	30	47	52
        team2_bundle1_hipe2020_fr_1	NE-NESTED-micro-strict-TIME-ALL-LED-ALL	ALL	0.394	0.341	0.366	28	43	54
        team2_bundle3_hipe2020_fr_1	NE-NESTED-micro-strict-TIME-ALL-LED-ALL	ALL	0.301	0.341	0.32	28	65	54

         =>

        team2_bundle1_hipe2020_fr_1	NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL	ALL	0.702
        + team2_bundle1_hipe2020_fr_1	NE-NESTED-micro-strict-TIME-ALL-LED-ALL	ALL	0.394

        =
        team2_bundle1_hipe2020_fr_1	NE-FINE-LIT-NE-NESTED-AVG-micro-strict-TIME-ALL-LED-ALL	ALL	0.548
        ```
        """

        systemrun2rows = {}  # mapping of System row to full record
        for r in reader:
            if r["Label"] != "ALL":
                continue
            r["F1"] = float(r["F1"])
            log.debug(f"Raw record for NE-FINE-LIT-NE-NESTED  {r}")
            if r["System"] in systemrun2rows:
                first_run_data = systemrun2rows[r["System"]]
                first_run_data["F1"] += r["F1"]
                first_run_data["F1"] /= 2
                first_run_data["Evaluation"] = re.sub(
                    r"-FINE-LIT-|-NESTED-",
                    "-FINE-LIT-NE-NESTED-AVG-",
                    first_run_data["Evaluation"],
                )
            else:
                systemrun2rows[r["System"]] = r
        sorted_runs = sorted(
            (systemrun2rows[k] for k in systemrun2rows),
            reverse=True,
            key=lambda x: x["F1"],
        )
        log.debug(f"Sorted NE-FINE-LIT-NE-NESTED SORTED {sorted_runs}")
        return sorted_runs

    def output_subchallenge_tsv(self) -> None:
        """Output the detailed challenge results"""
        fieldnames = [
            "CHALLENGE",
            "RANK",
            "POINTS",
            "TEAM",
            "DATASET",
            "LANGUAGE",
            "F1",
            "System",
        ]
        outstream = (
            open(self.args.outfile_dataset_team_ranking, "w")
            if self.args.outfile_dataset_team_ranking
            else None
        )
        print("\t".join(fieldnames), file=outstream)
        for dataset in sorted(self.datasets):
            for language in sorted(self.languages):
                for r in self.relevant_rankings[(dataset, language)]:
                    print(*(r[f] for f in fieldnames), sep="\t", file=outstream)
        if outstream:
            outstream.close()

    def output_subchallenge_team_rankings(self) -> None:
        """Output Team Rankings"""
        outstream = (
            open(self.args.outfile_challenge_team_ranking, "w")
            if self.args.outfile_challenge_team_ranking
            else None
        )
        fieldnames = ["CHALLENGE", "RANK", "POINTS", "TEAM"]
        print("\t".join(fieldnames), file=outstream)
        team2points = collections.Counter()
        for team in sorted(self.teams):
            for dataset in sorted(self.datasets):
                for language in sorted(self.languages):
                    for r in self.relevant_rankings[(dataset, language)]:
                        if r["TEAM"] == team:
                            team2points[team] += r["POINTS"]

        for rank, (team, points) in enumerate(team2points.most_common(), 1):
            print(self.challenge, rank, points, team, sep="\t", file=outstream)
        if outstream:
            outstream.close()


if __name__ == "__main__":
    import argparse

    description = "Create challenge "
    epilog = ""
    parser = argparse.ArgumentParser(description=description, epilog=epilog)
    parser.add_argument(
        "-l", "--logfile", dest="logfile", help="write log to FILE", metavar="FILE"
    )
    parser.add_argument(
        "-v",
        "--verbose",
        dest="verbose",
        default=2,
        type=int,
        metavar="LEVEL",
        help="set verbosity level: 0=CRITICAL, 1=ERROR, 2=WARNING, 3=INFO 4=DEBUG (default %(default)s)",
    )
    parser.add_argument(
        "--infiles",
        nargs="+",
        help="Ranking input file ",
    )
    parser.add_argument(
        "--teams",
        nargs="+",
        help="teams running in the challenge",
    )
    parser.add_argument(
        "--bundles",
        nargs="+",
        help="valid bundle ids ",
    )
    parser.add_argument(
        "--outfile-challenge-team-ranking",
        metavar="CHALLENGE_TEAM_RANKING.tsv",
        help="file path for the (sub-)challenge team ranking table (default stdout)",
    )
    parser.add_argument(
        "--outfile-dataset-team-ranking",
        metavar="DATASET_TEAM_RANKING.tsv",
        help="file path for the per dataset team ranking table (default stdout)",
    )
    parser.add_argument(
        "--avg-ne-fine-nested-lit",
        action="store_true",
        help="Average the F1 scores of NE-NESTED-micro- and NE-FINE-LIT per run, rerank and evaluate on this average",
    )
    parser.add_argument(
        "--challenge",
        choices=[c+":"+e for c in ["mnc", "mcc", "gac"] for e in ["NERC-Coarse","NERC-Fine+Nested","EL","EL-Only" ]]+["mnc","mcc","gac", "UNSPECIFIED"],
        default="UNSPECIFIED",
        help=(
            "the challenge acronym used for labelling the result table: "
            "MNC= Multilingual Newspaper Challenge; MCC=multilingual Classical Commentary Challenge; GAC=Global Adaptation Challenge. "
            "Note that no automatic matching between files and challenges happens. The caller of this script must provide correct input files for the correct challenge!"
        )
    )
    parser.add_argument(
        "--aggregate-subchallenge-results",
        action= "store_true",
        help="Aggregate the points per subchallenge; Note that no automatic matching between files and challenges happens. The caller of this script must provide correct input files for the correct challenge!",
    )


    arguments = parser.parse_args()

    log_levels = [
        logging.CRITICAL,
        logging.ERROR,
        logging.WARNING,
        logging.INFO,
        logging.DEBUG,
    ]
    logging.basicConfig(
        level=log_levels[arguments.verbose],
        format="%(asctime)-15s %(levelname)s: %(message)s",
    )

    # launching application ...
    ChallengeEvaluation(arguments).run()
