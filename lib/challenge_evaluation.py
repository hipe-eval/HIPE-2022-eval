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

log = logging.getLogger(__name__)


def ranking2points(rank):
    """
    1 => 50
    2 => 40
    3 => 30



    :param rank:
    :return:
    """
    return max(0, 50 - rank * 10)


class ChallengeEvaluation(object):
    def __init__(self, args):
        self.args = args
        self.teams = set(self.args.teams)
        self.datasets = set()
        self.languages = set()
        self.relevant_rankings = collections.defaultdict(
            list
        )  # Dict[Tuple[str, str],List[List[str]]]

    def read_ranking_file(self, filename):
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


                :return:
        """
        seen_teams = set()
        rank = 0
        with open(filename, "r") as f:
            reader = csv.DictReader(
                f, delimiter="\t", quotechar="", quoting=csv.QUOTE_NONE
            )
            for row in reader:
                if row["Label"] != "ALL":
                    continue
                split_system_value = row["System"].split("_")
                if len(split_system_value) != 5:
                    log.warning(f"{split_system_value}")
                team, bundle, dataset, language, run = row["System"].split("_")
                if team not in self.teams:
                    log.info(f"Ignoring team {team}")
                    continue
                if team in seen_teams:
                    continue
                else:
                    seen_teams.add(team)
                    row["TEAM"] = team
                    row["DATASET"] = dataset
                    self.datasets.add(dataset)
                    row["LANGUAGE"] = language
                    self.languages.add(language)
                    row["RUNID"] = run
                    row["RANK"] = rank
                    row["POINTS"] = ranking2points(rank)
                    self.relevant_rankings[(dataset, language)].append(row)
                    rank += 1

    def output_challenge_tsv(self):
        for dataset in sorted(self.datasets):
            for language in sorted(self.languages):
                for r in self.relevant_rankings[(dataset,language)]:
                    print(r['DATASET'],r['LANGUAGE'],r['TEAM'], f"{float(r['F1']):.03f}",r['POINTS'],r['System'], sep="\t")


    def output_team_points(self):
        team2points = collections.Counter()
        for team in sorted(self.teams):
            for dataset in sorted(self.datasets):
                for language in sorted(self.languages):
                    for r in self.relevant_rankings[(dataset, language)]:
                        if r["TEAM"] == team:
                            team2points[team] += r["POINTS"]


        for team,points in team2points.most_common():
            print(team,points,sep="\t")

    def run(self):
        log.warning(self.args)
        for f in self.args.infiles:
            self.read_ranking_file(f)
        log.debug(self.relevant_rankings)
        self.output_challenge_tsv()
        self.output_team_points()

if __name__ == "__main__":
    import argparse

    description = ""
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
