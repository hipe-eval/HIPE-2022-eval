"""
Script to produce the official ranking summary tables for the HIPE shared task.

Usage:
    lib/format_rankings_summary.py --input-dir=<id> --output-dir=<od> --submissions-dir=<sd> [--log-file=<log>]
"""  # noqa


from fileinput import filename
import logging
import os
import datetime
import pandas as pd
from docopt import docopt
from tabulate import tabulate

GH_SYS_RANKING_URL = "https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings"
GH_CHALLENGE_RANKING_URL = "https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings"
date_of_creation = datetime.datetime.today().strftime('%d.%m.%Y')
SCORER_VERSION = "[v2.0](https://github.com/hipe-eval/HIPE-scorer/releases/tag/2.0)"
DATA_VERSION = "[v2.1-test-all-unmasked](https://github.com/hipe-eval/HIPE-2022-data/releases/tag/v2.1-test-all-unmasked)"

PROLOGUE = f"""
We provide a complete overview of the results of the HIPE-2022 evaluation campaign.         

For more information about the tasks and challenges, see this [schema](https://github.com/hipe-eval/HIPE-2022-data#hipe-2022-evaluation) and  the [participation guidelines](https://doi.org/10.5281/zenodo.6045662) pages 13-18.

**Team keys (in numerical order)**

| Team key | Team name   | Team affiliation                                             |
| -------- | ----------- | ------------------------------------------------------------ |
| team1     | HISTeria    | Ludwig-Maximilians-Universität and Bayerische Staatsbibliothek München, Munich, Germany |
| team2    | L3i         | La Rochelle University, La Rochelle, France                  |
| team3    | WLV    | University of Wolverhampton, Wolverhampton, UK |
| team4   | aauzh         | Machine Learning MA class, Zurich University, Switzerland  |
| team5   | SBB         | Berlin State Library, Berlin, Germany    |


## Track Evaluation results

We provide an **overview table** of the **preliminary** results of the runs submitted by the teams.     
It also includes a neural baseline created by the organizers. A non-neural CRF-based baseline will be added soon for NERC.

- Date: {date_of_creation}.
- Bundles: 1 to 5
- HIPE-2022 data version: {DATA_VERSION}
- HIPE scorer version: {SCORER_VERSION}
- The current results for NEL can still change as we may extend the list of equivalent wikidata IDs. 
- Detailed results for all systems can be found in the corresponding .tsv file (link provided below each table).
- Detailed results for each team's runs are sent privately.
- System name composition is: `teamID_bundle_dataset_lang_run`.
- F1 scores of 0.0 are excluded from the table.
- Results are ordered by F1 scores.

### About the evaluation (reminder)

- NERC and Entity Linking (EL) are evaluated in terms of macro and micro Precision, Recall, F1-measure. Here only micro is reported.

- NERC evaluation includes **strict** (exact boundary matching) and **fuzzy** (boundary overlap) scenarios.

- For **EL**, the definition of strict and fuzzy regimes differs. In terms of boundaries, EL is always evaluated according to overlapping boundaries (what is of interest is the capacity to provide the correct link rather
than the correct boundaries). EL **strict regime** considers only the system's top link prediction (NIL or QID), while the **fuzzy/relaxed regime** expands system predictions
with a set of historically related entity QIDs. We additionally report F@1/3/5 in the .tsv files.    


"""


def read_ranking(ranking_name: str, rankings_dir: str) -> pd.DataFrame:
    relevant_tsv_files = [
        os.path.join(rankings_dir, file)
        for file in os.listdir(rankings_dir)
        if ranking_name in file
    ][0]
    logging.info(f"Trying to open {relevant_tsv_files}")
    df = pd.read_csv(relevant_tsv_files, delimiter="\t")

    selected_cols = [
        "Evaluation",
        "Label",
        "F1",
        "P",
        "R",
        "TP",
        "FP",
        "FN",
        "System",
    ]
    # print something
    df = df[~(df.F1 == 0.0)]
    # return df.reset_index()[selected_cols]
    return df[selected_cols]


def read_ranking_challenge(ranking_file_path) -> pd.DataFrame:

    logging.info(f"Trying to open {ranking_file_path}")

    if "dataset" in ranking_file_path:
        selected_cols = [
            "CHALLENGE",
            "RANK",
            "POINTS",
            "TEAM",
            "DATASET",
            "LANGUAGE",
            "F1",
            "System"
        ]
    else:
        selected_cols = [
            "CHALLENGE",
            "RANK",
            "POINTS",
            "TEAM"
        ]

    try:
        df = pd.read_csv(ranking_file_path, delimiter="\t")
        return df[selected_cols]
    except FileNotFoundError:
        logging.error("File not found.")
    except pd.errors.EmptyDataError:
        logging.error("No data")
    except pd.errors.ParserError:
        logging.error("Parse error")
    except Exception:
        logging.error("Some other exception")


def read_team_keys_file(team_keys_path: str):

    with open(team_keys_path) as keys_file:
        keys = keys_file.readlines()
        key_mapping_dict = {
            key.split(":")[1].strip() : key.split(":")[0]
            for key in keys
        }

    return key_mapping_dict


def format_team_keys(mapping_dict: dict) -> str:
    text = ""
    for team_key in mapping_dict:
        text += f"- `{team_key}` = `{mapping_dict[team_key]}`\n"
    return text


def filter_ranking(ranking_df: pd.DataFrame, evaluation: str) -> pd.DataFrame:
    #print(ranking_df)
    try:
        filtered = ranking_df.copy()[
            ranking_df.Evaluation.str.contains(evaluation) & (ranking_df.Label == "ALL")
            ]
    except AttributeError:
        logging.error(f"Missing Attributes: \n{ranking_df}")
        raise AttributeError
    return filtered


def compile_rankings_summary(rankings_dir: str, submissions_dir: str) -> str:

    # take only micro scores

    summary = ""

    languages = [
        ("de", "German"),
        ("en", "English"),
        ("fr", "French"),
        ("sv", "Swedish"),
        ("fi", "Finnish"),
    ]

    team_keys_file_path = os.path.join(submissions_dir, "TEAM_KEYS.txt")
    team_keys_mapping = read_team_keys_file(team_keys_file_path)
    team_keys_section = format_team_keys(team_keys_mapping)

    h = ["Rank", "System", "F1", "Precision", "Recall", "TP", "FP", "FN"]

    datasets = ["hipe2020", "newseye", "letemps", "sonar", "topres19th", "ajmc"]

    scenarios = [
        {
            "desc": "Relevant bundles: 1-4",
            "id": "nerc-coarse",
            "label": "NERC coarse",
            "measures": [
                (
                    "strict",
                    "NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL",
                    "strict (literal sense)",
                ),
                (
                    "fuzzy",
                    "NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL",
                    "fuzzy (literal sense)",
                ),
                # (
                #     "strict",
                #     "NE-COARSE-METO-micro-strict-TIME-ALL-LED-ALL",
                #     "strict (metonymic sense)",
                # ),
                # (
                #     "fuzzy",
                #     "NE-COARSE-METO-micro-fuzzy-TIME-ALL-LED-ALL",
                #     "fuzzy (metonymic sense)",
                # ),
            ],
        },
        {
            "desc": "Relevant bundles: 1, 3",
            "id": "nerc-fine",
            "label": "NERC fine",
            "measures": [
                (
                    "strict",
                    "NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL",
                    "strict (literal sense)",
                ),
                (
                    "fuzzy",
                    "NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL",
                    "fuzzy (literal sense)",
                ),
                # (
                #     "strict",
                #     "NE-FINE-METO-micro-strict-TIME-ALL-LED-ALL",
                #     "strict (metonymic sense)",
                # ),
                # (
                #     "fuzzy",
                #     "NE-FINE-METO-micro-fuzzy-TIME-ALL-LED-ALL",
                #     "fuzzy (metonymic sense)",
                # ),
                # (
                #     "strict",
                #     "NE-COMP-micro-strict-TIME-ALL-LED-ALL",
                #     "strict NE components",
                # ),
                # (
                #     "fuzzy",
                #     "NE-COMP-micro-fuzzy-TIME-ALL-LED-ALL",
                #     "fuzzy NE components",
                # ),
                (
                    "strict",
                    "NE-NESTED-micro-strict-TIME-ALL-LED-ALL",
                    "strict, nested entities",
                ),
                (
                    "fuzzy",
                    "NE-NESTED-micro-fuzzy-TIME-ALL-LED-ALL",
                    "fuzzy, nested entities",
                ),
            ],
        },
        {
            "desc": "Relevant bundles: 1, 2",
            "id": "el",
            "label": "EL",
            "measures": [
                (
                    "strict",
                    "LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1",
                    "strict @1 (literal sense)",
                ),
                # (
                #     "strict",
                #     "METO-micro-fuzzy-TIME-ALL-LED-ALL-@1",
                #     "strict @1 (metonymic sense)",
                # ),
                (
                    "relaxed",
                    "LIT-micro-fuzzy-relaxed-TIME-ALL-LED-ALL-@1",
                    "relaxed @1 (literal sense)",
                ),
                # (
                #     "relaxed",
                #     "METO-micro-fuzzy-relaxed-TIME-ALL-LED-ALL-@1",
                #     "relaxed @1 (metonymic sense)",
                # ),
            ],
        },
        {
            "desc": "Relevant bundles: 5",
            "id": "el-only",
            "label": "EL only",
            "measures": [
                (
                    "strict",
                    "LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1",
                    "strict @1 (literal sense)",
                ),
                # (
                #     "strict",
                #     "METO-micro-fuzzy-TIME-ALL-LED-ALL-@1",
                #     "strict @1 (metonymic sense)",
                # ),
                (
                    "relaxed",
                    "LIT-micro-fuzzy-relaxed-TIME-ALL-LED-ALL-@1",
                    "relaxed @1 (literal sense)",
                ),
                # (
                #     "relaxed",
                #     "METO-micro-fuzzy-relaxed-TIME-ALL-LED-ALL-@1",
                #     "relaxed @1 (metonymic sense)",
                # ),
            ],
        },
    ]

    #summary += "# CLEF HIPE 2022 preliminary results\n"
    summary += "# HIPE 2022 evaluation results\n"
    summary += PROLOGUE
    summary += "\n\n<!--ts-->\n<!--te-->\n"
    #summary += f"## Team keys\n{team_keys_section}\n"

    for scenario in scenarios:
        desc = scenario["desc"]
        scenario_id = scenario["id"]
        label = scenario["label"]
        measures = scenario["measures"]
        summary += f"\n\n## {label}\n\n{desc}"

        for dataset in datasets:
            if dataset == "sonar" and scenario_id == "nerc-fine":
                continue
            if dataset == "newseye" and scenario_id == "nerc-fine":
                continue
            if dataset == "letemps" and scenario_id in {"el","el-only"}:
                continue
            if dataset == "topres19th" and scenario_id == "nerc-fine":
                continue

            summary += f"\n\n### {dataset}"

            for lang_id, lang_label in languages:
                if dataset == "topres19th" and lang_id != "en":
                    continue
                if dataset == "sonar" and lang_id != "de":
                    continue
                if dataset == "hipe2020" and lang_id not in {"de", "fr", "en"}:
                    continue
                if dataset == "letemps" and lang_id != "fr":
                    continue
                if dataset == "ajmc" and lang_id not in {"de", "fr", "en"}:
                    continue
                if dataset == "newseye" and lang_id == "en":
                    continue
                if dataset == "letemps" and scenario_id in { "el", "el-only"}:
                    continue

                for measure, eval_level, measure_label in measures:
                    logging.info(f"Working on {(dataset,lang_id, measure, eval_level, measure_label)}")
                    if scenario_id == "nerc-coarse":
                        try:
                            ranking_filename = f"ranking-{dataset}-{lang_id}-coarse-micro-{measure}-all.tsv"
                            ranking_df = read_ranking(ranking_filename, rankings_dir)
                        except:
                            print(f"{ranking_filename} not found")
                            ranking_df = None
                            continue

                    elif scenario_id == "nerc-fine":

                        try:
                            ranking_filename = f"ranking-{dataset}-{lang_id}-fine-micro-{measure}-all.tsv"
                            ranking_df = read_ranking(ranking_filename, rankings_dir)
                        except:
                            # print(f"{ranking_filename} not found")
                            ranking_df = None
                            continue

                    elif scenario_id == "el":
                        try:
                            if measure == "relaxed":
                                ranking_filename = f"ranking-{dataset}-{lang_id}-nel-micro-fuzzy-{measure}-all.tsv"
                            else:
                                # it's strict but no strict in the filename
                                ranking_filename = (
                                    f"ranking-{dataset}-{lang_id}-nel-micro-fuzzy-all.tsv"
                                )
                            ranking_df = read_ranking(ranking_filename, rankings_dir)
                        except:
                            logging.warning(f"{ranking_filename} not found: Could be because of missing submissions")
                            ranking_df = None
                            continue

                    elif scenario_id == "el-only":
                        try:
                            if measure == "relaxed":
                                ranking_filename = f"ranking-{dataset}-{lang_id}-nel-only-micro-fuzzy-{measure}-all.tsv"
                            else:
                                # it's strict but no strict in the filename
                                ranking_filename = f"ranking-{dataset}-{lang_id}-nel-only-micro-fuzzy-all.tsv"
                            ranking_df = read_ranking(ranking_filename, rankings_dir)
                        except:
                            logging.warning(f"{ranking_filename} not found: Could be because of missing submissions")
                            continue

                    filter_ranking_df = filter_ranking(ranking_df, eval_level)
                    filter_ranking_df["Rank"] = [
                        n + 1 for n, row in enumerate(filter_ranking_df.iterrows())
                    ]
                    filter_ranking_df = filter_ranking_df.set_index("Rank")
                    try:
                        eval_key = list(filter_ranking_df.Evaluation.unique())[0]
                    except IndexError:
                        logging.error(
                            f"### EMPTY INDEX {label} {dataset} {lang_label} {measure_label} [`{eval_key}`]"
                        )
                        continue
                    summary += f"\n\n**{label} {dataset} {lang_label} {measure_label}** [`{eval_key}`]\n\n"
                    summary += tabulate(
                        filter_ranking_df[["System", "F1", "P", "R", "TP", "FP", "FN"]],
                        headers=h,
                        tablefmt="pipe",
                        numalign="left",
                        floatfmt=".3f",
                    )
                    GH_tsv_link = os.path.join(GH_SYS_RANKING_URL, ranking_filename)
                    summary += f"\n\nSee [{ranking_filename}]({GH_tsv_link}) for full details."

    summary += "\n"
    return summary


def compile_rankings_challenges_summary(rankings_dir: str, submissions_dir: str) -> str:

    summary = ""

    challenges = {"mnc-challenge": "Multilingual Newspaper Challenge (MNC)",
                  "mcc-challenge": "Multilingual Classical Commentary Challenge (MCC)",
                  "gac-challenge": "Global Adaptation Challenge (GAC)"}

    challenges_acro = {"mnc-challenge": "MNC",
                  "mcc-challenge": "MCC",
                  "gac-challenge": "GAC"}

    tasks = ["nel-only-relaxed",
             "nel-relaxed",
             "nerc-coarse-fuzzy",
             "nerc-fine+nested-fuzzy"]

    views = {"challenge": "Ranking overview",
             "dataset": "Detailed view"}

    header_dataset = [
            "CHALLENGE",
            "RANK",
            "POINTS",
            "TEAM",
            "DATASET",
            "LANGUAGE",
            "F1",
            "System"
        ]
    header_team = [
            "CHALLENGE",
            "RANK",
            "POINTS",
            "TEAM"
        ]

    summary += "## HIPE 2022 Challenge Evaluation Results\n"
    summary += "\n\n<!--ts-->\n<!--te-->\n"

    for challenge in challenges:
        # overall challenge ranking
        summary += f"\n\n## {challenges[challenge]}\n\n"

        summary += f"\n\n### {challenges_acro[challenge]}: Overall ranking\n\n"

        overall_ranking_filename = f"{challenge}-team-ranking.tsv"
        ranking_df = read_ranking_challenge(os.path.join(rankings_dir, overall_ranking_filename))
        summary += tabulate(
            ranking_df,
            headers=header_team,
            tablefmt="pipe",
            numalign="left",
            floatfmt=".3f",
        )

        for task in tasks:
            if challenge == "mnc-challenge" and task == "nerc-fine+nested-fuzzy":
                continue
            if challenge == "mcc-challenge" and task == "nerc-fine+nested-fuzzy":
                continue
            for view in views:
                ranking_filename = f"{challenge}-{task}-{view}-team-ranking.tsv"
                ranking_df = read_ranking_challenge(os.path.join(rankings_dir, ranking_filename))

                summary += f"\n\n### {challenges_acro[challenge]}: {views[view]} for" \
                          f" {task} \n\n"

                h = header_dataset if view == "dataset" else header_team
                summary += tabulate(
                    ranking_df,
                    headers=h,
                    tablefmt="pipe",
                    numalign="left",
                    floatfmt=".3f",
                )
                GH_tsv_link = os.path.join(GH_CHALLENGE_RANKING_URL, ranking_filename)
                summary += f"\n\nSee [{ranking_filename}]({GH_tsv_link}) for full details."

    summary += "\n"
    return summary


def main(args):
    log_file = args["--log-file"]
    input_dir = args["--input-dir"]
    output_dir = args["--output-dir"]
    submissions_dir = args["--submissions-dir"]


    logging.basicConfig(
        filename=log_file,
        filemode="w",
        level=logging.DEBUG,
        format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
    )

    if "challenges" not in input_dir:
        md_summary_path = os.path.join(input_dir, "ranking_summary.md")
        md_summary = compile_rankings_summary(input_dir, submissions_dir)
    else:
        md_summary_path = os.path.join(input_dir, "ranking_challenge_summary.md")
        md_summary = compile_rankings_challenges_summary(input_dir, submissions_dir)

    with open(md_summary_path, "w") as f:
        f.write(md_summary)


if __name__ == "__main__":
    arguments = docopt(__doc__)
    main(arguments)
