# CLEF HIPE 2022 preliminary results

We provide an **overview table** of the **PRELIMINARY** anonymized results of the runs submitted by the teams. 
It also includes a neural baseline created by the organizers.

- Date: 10.05.2022.
- Bundles: 1 to 5
- The current results for NEL can still change as we may extend the list of equivalent wikidata IDs. 
- Detailed results for all systems can be found in the corresponding .tsv file (link provided below each table).
- Detailed results for each team's runs are sent privately.
- System name composition is: teamID_bundle_dataset_lang_run.
- F1 scores of 0.0 are excluded from the table.
- Results are ordered by F1 scores.

**About the evaluation (reminder)**

- NERC and Entity Linking (EL) are evaluated in terms of macro and micro Precision, Recall, F1-measure. Here only micro is reported.

- Evaluation scenarios for **NERC**
       - **Strict**: exact boundary matching.
       - **Fuzzy**: fuzzy (=overlap) boundary matching.

- Evaluation scenarios for **EL**:
In terms of boundaries, NEL is only evaluated according to fuzzy boundary matching in all scenarios. What is of interest is the capacity to provide the correct link rather than the correct boundaries (NERC task).
         - **Strict**: The system's top link prediction (NIL or QID) must be identical with the gold standard annotation.
        - **Relaxed**: The set of system's predictions is expanded with a set of historically related entities QIDs, e.g "Germany" is expended with the more specific "Confederation of the Rhine" and both are considered as valid answers. Systems are therefore evaluated more generously.  For this scenario, we additionally report F@1/3/5 in the .tsv files.



<!--ts-->
<!--te-->
## Team keys
- `team1` = `HISTeria`
- `team2` = `l3i`
- `team3` = `WLV`
- `team4` = `aauzh`
- `team5` = `SBB`



## NERC coarse

Relevant bundles: 1-4

### hipe2020

#### NERC coarse hipe2020 German strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                        | F1    | Precision   | Recall   |
|:-------|:------------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_hipe2020_de_1   | 0.794 | 0.784       | 0.805    |
| 2      | team2_bundle1_hipe2020_de_2   | 0.784 | 0.780       | 0.787    |
| 3      | team2_bundle1_hipe2020_de_1   | 0.774 | 0.757       | 0.792    |
| 4      | team4_bundle4_hipe2020_de_1   | 0.725 | 0.716       | 0.735    |
| 5      | neurbsl_bundle3_hipe2020_de_1 | 0.703 | 0.665       | 0.746    |
| 6      | team4_bundle4_hipe2020_de_2   | 0.695 | 0.677       | 0.714    |

See [ranking-hipe2020-de-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-de-coarse-micro-strict-all.tsv) for full details.

#### NERC coarse hipe2020 German fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                        | F1    | Precision   | Recall   |
|:-------|:------------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_hipe2020_de_1   | 0.876 | 0.865       | 0.888    |
| 2      | team2_bundle1_hipe2020_de_2   | 0.874 | 0.870       | 0.878    |
| 3      | team2_bundle1_hipe2020_de_1   | 0.872 | 0.853       | 0.892    |
| 4      | team4_bundle4_hipe2020_de_1   | 0.822 | 0.812       | 0.833    |
| 5      | team4_bundle4_hipe2020_de_2   | 0.804 | 0.783       | 0.826    |
| 6      | neurbsl_bundle3_hipe2020_de_1 | 0.793 | 0.750       | 0.842    |

See [ranking-hipe2020-de-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-de-coarse-micro-fuzzy-all.tsv) for full details.

#### NERC coarse hipe2020 English strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                        | F1    | Precision   | Recall   |
|:-------|:------------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_hipe2020_en_1   | 0.620 | 0.624       | 0.617    |
| 2      | team2_bundle1_hipe2020_en_2   | 0.612 | 0.604       | 0.619    |
| 3      | team4_bundle4_hipe2020_en_1   | 0.513 | 0.538       | 0.490    |
| 4      | neurbsl_bundle3_hipe2020_en_1 | 0.477 | 0.432       | 0.532    |
| 5      | team3_bundle4_hipe2020_en_1   | 0.414 | 0.400       | 0.430    |

See [ranking-hipe2020-en-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-en-coarse-micro-strict-all.tsv) for full details.

#### NERC coarse hipe2020 English fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                        | F1    | Precision   | Recall   |
|:-------|:------------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_hipe2020_en_1   | 0.788 | 0.793       | 0.784    |
| 2      | team2_bundle1_hipe2020_en_2   | 0.781 | 0.772       | 0.791    |
| 3      | team4_bundle4_hipe2020_en_1   | 0.692 | 0.726       | 0.661    |
| 4      | neurbsl_bundle3_hipe2020_en_1 | 0.623 | 0.564       | 0.695    |
| 5      | team3_bundle4_hipe2020_en_1   | 0.603 | 0.582       | 0.626    |

See [ranking-hipe2020-en-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-en-coarse-micro-fuzzy-all.tsv) for full details.

#### NERC coarse hipe2020 French strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                        | F1    | Precision   | Recall   |
|:-------|:------------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_hipe2020_fr_1   | 0.808 | 0.786       | 0.831    |
| 2      | team2_bundle1_hipe2020_fr_2   | 0.804 | 0.782       | 0.827    |
| 3      | team2_bundle3_hipe2020_fr_1   | 0.798 | 0.775       | 0.823    |
| 4      | neurbsl_bundle3_hipe2020_fr_1 | 0.757 | 0.730       | 0.785    |
| 5      | team4_bundle4_hipe2020_fr_2   | 0.696 | 0.718       | 0.675    |
| 6      | team4_bundle4_hipe2020_fr_1   | 0.678 | 0.700       | 0.657    |
| 7      | team3_bundle4_hipe2020_fr_1   | 0.674 | 0.640       | 0.712    |

See [ranking-hipe2020-fr-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-fr-coarse-micro-strict-all.tsv) for full details.

#### NERC coarse hipe2020 French fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                        | F1    | Precision   | Recall   |
|:-------|:------------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_hipe2020_fr_2   | 0.907 | 0.883       | 0.933    |
| 2      | team2_bundle1_hipe2020_fr_1   | 0.904 | 0.880       | 0.929    |
| 3      | team2_bundle3_hipe2020_fr_1   | 0.901 | 0.875       | 0.928    |
| 4      | neurbsl_bundle3_hipe2020_fr_1 | 0.866 | 0.836       | 0.899    |
| 5      | team3_bundle4_hipe2020_fr_1   | 0.808 | 0.767       | 0.853    |
| 6      | team4_bundle4_hipe2020_fr_2   | 0.800 | 0.825       | 0.776    |
| 7      | team4_bundle4_hipe2020_fr_1   | 0.798 | 0.824       | 0.773    |

See [ranking-hipe2020-fr-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-fr-coarse-micro-fuzzy-all.tsv) for full details.

### newseye

#### NERC coarse newseye German strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_newseye_de_1 | 0.477 | 0.429       | 0.537    |
| 2      | team4_bundle4_newseye_de_2   | 0.408 | 0.395       | 0.421    |
| 3      | team4_bundle4_newseye_de_1   | 0.395 | 0.396       | 0.394    |

See [ranking-newseye-de-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-de-coarse-micro-strict-all.tsv) for full details.

#### NERC coarse newseye German fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_newseye_de_1 | 0.570 | 0.512       | 0.642    |
| 2      | team4_bundle4_newseye_de_2   | 0.495 | 0.480       | 0.512    |
| 3      | team4_bundle4_newseye_de_1   | 0.479 | 0.481       | 0.478    |

See [ranking-newseye-de-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-de-coarse-micro-fuzzy-all.tsv) for full details.

#### NERC coarse newseye French strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | team4_bundle4_newseye_fr_2   | 0.656 | 0.655       | 0.657    |
| 2      | neurbsl_bundle3_newseye_fr_1 | 0.654 | 0.634       | 0.676    |
| 3      | team4_bundle4_newseye_fr_1   | 0.648 | 0.673       | 0.625    |

See [ranking-newseye-fr-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-fr-coarse-micro-strict-all.tsv) for full details.

#### NERC coarse newseye French fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | team4_bundle4_newseye_fr_2   | 0.786 | 0.785       | 0.787    |
| 2      | neurbsl_bundle3_newseye_fr_1 | 0.779 | 0.755       | 0.805    |
| 3      | team4_bundle4_newseye_fr_1   | 0.772 | 0.801       | 0.744    |

See [ranking-newseye-fr-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-fr-coarse-micro-fuzzy-all.tsv) for full details.

#### NERC coarse newseye Swedish strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_newseye_sv_1 | 0.651 | 0.588       | 0.728    |
| 2      | team4_bundle4_newseye_sv_1   | 0.643 | 0.686       | 0.604    |
| 3      | team4_bundle4_newseye_sv_2   | 0.636 | 0.673       | 0.603    |

See [ranking-newseye-sv-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-sv-coarse-micro-strict-all.tsv) for full details.

#### NERC coarse newseye Swedish fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_newseye_sv_1 | 0.747 | 0.675       | 0.836    |
| 2      | team4_bundle4_newseye_sv_1   | 0.746 | 0.797       | 0.702    |
| 3      | team4_bundle4_newseye_sv_2   | 0.742 | 0.786       | 0.704    |

See [ranking-newseye-sv-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-sv-coarse-micro-fuzzy-all.tsv) for full details.

#### NERC coarse newseye Finnish strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_newseye_fi_1 | 0.644 | 0.605       | 0.687    |
| 2      | team4_bundle4_newseye_fi_1   | 0.567 | 0.618       | 0.524    |
| 3      | team4_bundle4_newseye_fi_2   | 0.556 | 0.592       | 0.524    |

See [ranking-newseye-fi-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-fi-coarse-micro-strict-all.tsv) for full details.

#### NERC coarse newseye Finnish fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_newseye_fi_1 | 0.760 | 0.715       | 0.812    |
| 2      | team4_bundle4_newseye_fi_1   | 0.670 | 0.730       | 0.619    |
| 3      | team4_bundle4_newseye_fi_2   | 0.640 | 0.681       | 0.603    |

See [ranking-newseye-fi-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-fi-coarse-micro-fuzzy-all.tsv) for full details.

### letemps

#### NERC coarse letemps French strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_letemps_fr_1 | 0.661 | 0.595       | 0.744    |
| 2      | team4_bundle4_letemps_fr_1   | 0.644 | 0.589       | 0.710    |
| 3      | team4_bundle4_letemps_fr_2   | 0.622 | 0.557       | 0.704    |
| 4      | team3_bundle4_letemps_fr_1   | 0.618 | 0.581       | 0.659    |

See [ranking-letemps-fr-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-letemps-fr-coarse-micro-strict-all.tsv) for full details.

#### NERC coarse letemps French fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_letemps_fr_1 | 0.711 | 0.639       | 0.800    |
| 2      | team4_bundle4_letemps_fr_1   | 0.701 | 0.642       | 0.773    |
| 3      | team4_bundle4_letemps_fr_2   | 0.681 | 0.610       | 0.771    |
| 4      | team3_bundle4_letemps_fr_1   | 0.666 | 0.627       | 0.711    |

See [ranking-letemps-fr-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-letemps-fr-coarse-micro-fuzzy-all.tsv) for full details.

### sonar

#### NERC coarse sonar German strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                     | F1    | Precision   | Recall   |
|:-------|:---------------------------|:------|:------------|:---------|
| 1      | team4_bundle4_sonar_de_1   | 0.490 | 0.470       | 0.511    |
| 2      | team4_bundle4_sonar_de_2   | 0.477 | 0.447       | 0.513    |
| 3      | neurbsl_bundle3_sonar_de_1 | 0.314 | 0.272       | 0.373    |

See [ranking-sonar-de-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-sonar-de-coarse-micro-strict-all.tsv) for full details.

#### NERC coarse sonar German fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                     | F1    | Precision   | Recall   |
|:-------|:---------------------------|:------|:------------|:---------|
| 1      | team4_bundle4_sonar_de_2   | 0.668 | 0.625       | 0.718    |
| 2      | team4_bundle4_sonar_de_1   | 0.667 | 0.641       | 0.696    |
| 3      | neurbsl_bundle3_sonar_de_1 | 0.467 | 0.403       | 0.554    |

See [ranking-sonar-de-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-sonar-de-coarse-micro-fuzzy-all.tsv) for full details.

### topres19th

#### NERC coarse topres19th English strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                          | F1    | Precision   | Recall   |
|:-------|:--------------------------------|:------|:------------|:---------|
| 1      | team4_bundle4_topres19th_en_1   | 0.787 | 0.816       | 0.760    |
| 2      | team4_bundle4_topres19th_en_2   | 0.781 | 0.761       | 0.802    |
| 3      | neurbsl_bundle3_topres19th_en_1 | 0.764 | 0.747       | 0.782    |
| 4      | team3_bundle4_topres19th_en_1   | 0.740 | 0.712       | 0.771    |

See [ranking-topres19th-en-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-topres19th-en-coarse-micro-strict-all.tsv) for full details.

#### NERC coarse topres19th English fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                          | F1    | Precision   | Recall   |
|:-------|:--------------------------------|:------|:------------|:---------|
| 1      | team4_bundle4_topres19th_en_1   | 0.838 | 0.869       | 0.810    |
| 2      | team4_bundle4_topres19th_en_2   | 0.829 | 0.807       | 0.851    |
| 3      | neurbsl_bundle3_topres19th_en_1 | 0.816 | 0.798       | 0.836    |
| 4      | team3_bundle4_topres19th_en_1   | 0.796 | 0.765       | 0.829    |

See [ranking-topres19th-en-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-topres19th-en-coarse-micro-fuzzy-all.tsv) for full details.

### ajmc

#### NERC coarse ajmc German strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_ajmc_de_2   | 0.934 | 0.946       | 0.921    |
| 2      | team1_bundle4_ajmc_de_1   | 0.913 | 0.930       | 0.898    |
| 3      | team1_bundle4_ajmc_de_2   | 0.912 | 0.905       | 0.919    |
| 4      | team2_bundle3_ajmc_de_1   | 0.908 | 0.913       | 0.903    |
| 5      | neurbsl_bundle3_ajmc_de_1 | 0.818 | 0.792       | 0.846    |

See [ranking-ajmc-de-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-de-coarse-micro-strict-all.tsv) for full details.

#### NERC coarse ajmc German fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_ajmc_de_2   | 0.952 | 0.965       | 0.940    |
| 2      | team1_bundle4_ajmc_de_2   | 0.945 | 0.938       | 0.953    |
| 3      | team1_bundle4_ajmc_de_1   | 0.937 | 0.954       | 0.921    |
| 4      | team2_bundle3_ajmc_de_1   | 0.934 | 0.939       | 0.929    |
| 5      | neurbsl_bundle3_ajmc_de_1 | 0.873 | 0.846       | 0.903    |

See [ranking-ajmc-de-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-de-coarse-micro-fuzzy-all.tsv) for full details.

#### NERC coarse ajmc English strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team1_bundle4_ajmc_en_2   | 0.854 | 0.826       | 0.885    |
| 2      | team2_bundle1_ajmc_en_1   | 0.850 | 0.824       | 0.876    |
| 3      | team2_bundle1_ajmc_en_2   | 0.841 | 0.831       | 0.851    |
| 4      | team1_bundle4_ajmc_en_1   | 0.819 | 0.783       | 0.859    |
| 5      | neurbsl_bundle3_ajmc_en_1 | 0.736 | 0.680       | 0.802    |

See [ranking-ajmc-en-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-en-coarse-micro-strict-all.tsv) for full details.

#### NERC coarse ajmc English fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team1_bundle4_ajmc_en_2   | 0.910 | 0.879       | 0.943    |
| 2      | team1_bundle4_ajmc_en_1   | 0.899 | 0.859       | 0.943    |
| 3      | team2_bundle1_ajmc_en_1   | 0.894 | 0.868       | 0.922    |
| 4      | team2_bundle1_ajmc_en_2   | 0.884 | 0.874       | 0.894    |
| 5      | neurbsl_bundle3_ajmc_en_1 | 0.828 | 0.766       | 0.902    |

See [ranking-ajmc-en-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-en-coarse-micro-fuzzy-all.tsv) for full details.

#### NERC coarse ajmc French strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team1_bundle4_ajmc_fr_2   | 0.842 | 0.834       | 0.850    |
| 2      | team1_bundle4_ajmc_fr_1   | 0.833 | 0.820       | 0.847    |
| 3      | team2_bundle3_ajmc_fr_2   | 0.826 | 0.810       | 0.842    |
| 4      | team2_bundle3_ajmc_fr_1   | 0.798 | 0.780       | 0.817    |
| 5      | neurbsl_bundle3_ajmc_fr_1 | 0.741 | 0.707       | 0.778    |

See [ranking-ajmc-fr-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-fr-coarse-micro-strict-all.tsv) for full details.

#### NERC coarse ajmc French fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team1_bundle4_ajmc_fr_1   | 0.888 | 0.874       | 0.903    |
| 2      | team1_bundle4_ajmc_fr_2   | 0.880 | 0.872       | 0.889    |
| 3      | team2_bundle3_ajmc_fr_2   | 0.872 | 0.856       | 0.889    |
| 4      | team2_bundle3_ajmc_fr_1   | 0.860 | 0.841       | 0.881    |
| 5      | neurbsl_bundle3_ajmc_fr_1 | 0.825 | 0.788       | 0.867    |

See [ranking-ajmc-fr-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-fr-coarse-micro-fuzzy-all.tsv) for full details.

## NERC fine

Relevant bundles: 1, 3

### hipe2020

#### NERC fine hipe2020 German strict (literal sense) \[`NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                        | F1    | Precision   | Recall   |
|:-------|:------------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_hipe2020_de_1   | 0.718 | 0.691       | 0.747    |
| 2      | team2_bundle1_hipe2020_de_1   | 0.689 | 0.658       | 0.724    |
| 3      | team2_bundle1_hipe2020_de_2   | 0.682 | 0.657       | 0.710    |
| 4      | neurbsl_bundle3_hipe2020_de_1 | 0.625 | 0.584       | 0.673    |

See [ranking-hipe2020-de-fine-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-de-fine-micro-strict-all.tsv) for full details.

#### NERC fine hipe2020 German fuzzy (literal sense) \[`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                        | F1    | Precision   | Recall   |
|:-------|:------------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_hipe2020_de_1   | 0.807 | 0.776       | 0.840    |
| 2      | team2_bundle1_hipe2020_de_1   | 0.785 | 0.749       | 0.824    |
| 3      | team2_bundle1_hipe2020_de_2   | 0.783 | 0.754       | 0.814    |
| 4      | neurbsl_bundle3_hipe2020_de_1 | 0.706 | 0.659       | 0.759    |

See [ranking-hipe2020-de-fine-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-de-fine-micro-fuzzy-all.tsv) for full details.

#### NERC fine hipe2020 German strict, nested entities \[`NE-NESTED-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                      | F1    | Precision   | Recall   |
|:-------|:----------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_hipe2020_de_1 | 0.522 | 0.714       | 0.411    |
| 2      | team2_bundle1_hipe2020_de_2 | 0.457 | 0.750       | 0.329    |
| 3      | team2_bundle1_hipe2020_de_1 | 0.393 | 0.618       | 0.288    |

See [ranking-hipe2020-de-fine-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-de-fine-micro-strict-all.tsv) for full details.

#### NERC fine hipe2020 German fuzzy, nested entities \[`NE-NESTED-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                      | F1    | Precision   | Recall   |
|:-------|:----------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_hipe2020_de_1 | 0.539 | 0.738       | 0.425    |
| 2      | team2_bundle1_hipe2020_de_2 | 0.476 | 0.781       | 0.342    |
| 3      | team2_bundle1_hipe2020_de_1 | 0.393 | 0.618       | 0.288    |

See [ranking-hipe2020-de-fine-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-de-fine-micro-fuzzy-all.tsv) for full details.

#### NERC fine hipe2020 French strict (literal sense) \[`NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                        | F1    | Precision   | Recall   |
|:-------|:------------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_hipe2020_fr_1   | 0.740 | 0.702       | 0.782    |
| 2      | team2_bundle1_hipe2020_fr_2   | 0.736 | 0.697       | 0.779    |
| 3      | team2_bundle3_hipe2020_fr_1   | 0.720 | 0.679       | 0.767    |
| 4      | neurbsl_bundle3_hipe2020_fr_1 | 0.708 | 0.685       | 0.733    |

See [ranking-hipe2020-fr-fine-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-fr-fine-micro-strict-all.tsv) for full details.

#### NERC fine hipe2020 French fuzzy (literal sense) \[`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                        | F1    | Precision   | Recall   |
|:-------|:------------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_hipe2020_fr_1   | 0.826 | 0.784       | 0.873    |
| 2      | team2_bundle1_hipe2020_fr_2   | 0.825 | 0.782       | 0.873    |
| 3      | team2_bundle3_hipe2020_fr_1   | 0.812 | 0.765       | 0.865    |
| 4      | neurbsl_bundle3_hipe2020_fr_1 | 0.795 | 0.769       | 0.822    |

See [ranking-hipe2020-fr-fine-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-fr-fine-micro-fuzzy-all.tsv) for full details.

#### NERC fine hipe2020 French strict, nested entities \[`NE-NESTED-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                      | F1    | Precision   | Recall   |
|:-------|:----------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_hipe2020_fr_2 | 0.377 | 0.390       | 0.366    |
| 2      | team2_bundle1_hipe2020_fr_1 | 0.366 | 0.394       | 0.341    |
| 3      | team2_bundle3_hipe2020_fr_1 | 0.320 | 0.301       | 0.341    |

See [ranking-hipe2020-fr-fine-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-fr-fine-micro-strict-all.tsv) for full details.

#### NERC fine hipe2020 French fuzzy, nested entities \[`NE-NESTED-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                      | F1    | Precision   | Recall   |
|:-------|:----------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_hipe2020_fr_2 | 0.403 | 0.416       | 0.390    |
| 2      | team2_bundle1_hipe2020_fr_1 | 0.392 | 0.423       | 0.366    |
| 3      | team2_bundle3_hipe2020_fr_1 | 0.389 | 0.366       | 0.415    |

See [ranking-hipe2020-fr-fine-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-fr-fine-micro-fuzzy-all.tsv) for full details.

### newseye

#### NERC fine newseye German strict (literal sense) \[`NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_newseye_de_1 | 0.235 | 0.500       | 0.154    |

See [ranking-newseye-de-fine-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-de-fine-micro-strict-all.tsv) for full details.

#### NERC fine newseye German fuzzy (literal sense) \[`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_newseye_de_1 | 0.353 | 0.750       | 0.231    |

See [ranking-newseye-de-fine-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-de-fine-micro-fuzzy-all.tsv) for full details.

#### NERC fine newseye French strict (literal sense) \[`NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_newseye_fr_1 | 0.394 | 0.406       | 0.382    |

See [ranking-newseye-fr-fine-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-fr-fine-micro-strict-all.tsv) for full details.

#### NERC fine newseye French fuzzy (literal sense) \[`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_newseye_fr_1 | 0.485 | 0.500       | 0.471    |

See [ranking-newseye-fr-fine-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-fr-fine-micro-fuzzy-all.tsv) for full details.

#### NERC fine newseye Finnish fuzzy (literal sense) \[`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_newseye_fi_1 | 0.222 | 0.500       | 0.143    |

See [ranking-newseye-fi-fine-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-fi-fine-micro-fuzzy-all.tsv) for full details.

### letemps

#### NERC fine letemps French strict (literal sense) \[`NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_letemps_fr_1 | 0.615 | 0.564       | 0.676    |

See [ranking-letemps-fr-fine-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-letemps-fr-fine-micro-strict-all.tsv) for full details.

#### NERC fine letemps French fuzzy (literal sense) \[`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_letemps_fr_1 | 0.654 | 0.600       | 0.719    |

See [ranking-letemps-fr-fine-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-letemps-fr-fine-micro-fuzzy-all.tsv) for full details.

### sonar

### topres19th

### ajmc

#### NERC fine ajmc German strict (literal sense) \[`NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_ajmc_de_2   | 0.906 | 0.915       | 0.898    |
| 2      | team2_bundle3_ajmc_de_1   | 0.880 | 0.860       | 0.901    |
| 3      | neurbsl_bundle3_ajmc_de_1 | 0.818 | 0.819       | 0.817    |

See [ranking-ajmc-de-fine-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-de-fine-micro-strict-all.tsv) for full details.

#### NERC fine ajmc German fuzzy (literal sense) \[`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_ajmc_de_2   | 0.933 | 0.941       | 0.924    |
| 2      | team2_bundle3_ajmc_de_1   | 0.905 | 0.885       | 0.927    |
| 3      | neurbsl_bundle3_ajmc_de_1 | 0.865 | 0.866       | 0.864    |

See [ranking-ajmc-de-fine-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-de-fine-micro-fuzzy-all.tsv) for full details.

#### NERC fine ajmc English strict (literal sense) \[`NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_ajmc_en_1   | 0.798 | 0.754       | 0.848    |
| 2      | team2_bundle1_ajmc_en_2   | 0.781 | 0.745       | 0.822    |
| 3      | neurbsl_bundle3_ajmc_en_1 | 0.664 | 0.600       | 0.744    |

See [ranking-ajmc-en-fine-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-en-fine-micro-strict-all.tsv) for full details.

#### NERC fine ajmc English fuzzy (literal sense) \[`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_ajmc_en_1   | 0.847 | 0.801       | 0.899    |
| 2      | team2_bundle1_ajmc_en_2   | 0.847 | 0.807       | 0.891    |
| 3      | neurbsl_bundle3_ajmc_en_1 | 0.749 | 0.676       | 0.839    |

See [ranking-ajmc-en-fine-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-en-fine-micro-fuzzy-all.tsv) for full details.

#### NERC fine ajmc French strict (literal sense) \[`NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_ajmc_fr_2   | 0.669 | 0.646       | 0.694    |
| 2      | team2_bundle3_ajmc_fr_1   | 0.645 | 0.623       | 0.669    |
| 3      | neurbsl_bundle3_ajmc_fr_1 | 0.545 | 0.526       | 0.567    |

See [ranking-ajmc-fr-fine-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-fr-fine-micro-strict-all.tsv) for full details.

#### NERC fine ajmc French fuzzy (literal sense) \[`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_ajmc_fr_2   | 0.728 | 0.703       | 0.756    |
| 2      | team2_bundle3_ajmc_fr_1   | 0.710 | 0.685       | 0.736    |
| 3      | neurbsl_bundle3_ajmc_fr_1 | 0.639 | 0.616       | 0.664    |

See [ranking-ajmc-fr-fine-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-fr-fine-micro-fuzzy-all.tsv) for full details.

## EL

Relevant bundles: 1, 2

### hipe2020

#### EL hipe2020 German strict @1 (literal sense) \[`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`\]

| Rank   | System                      | F1    | Precision   | Recall   |
|:-------|:----------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_hipe2020_de_2 | 0.449 | 0.446       | 0.451    |
| 2      | team2_bundle1_hipe2020_de_1 | 0.447 | 0.438       | 0.458    |

See [ranking-hipe2020-de-nel-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-de-nel-micro-fuzzy-all.tsv) for full details.

#### EL hipe2020 English strict @1 (literal sense) \[`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`\]

| Rank   | System                      | F1    | Precision   | Recall   |
|:-------|:----------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_hipe2020_en_2 | 0.469 | 0.463       | 0.474    |
| 2      | team2_bundle1_hipe2020_en_1 | 0.468 | 0.471       | 0.465    |

See [ranking-hipe2020-en-nel-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-en-nel-micro-fuzzy-all.tsv) for full details.

#### EL hipe2020 French strict @1 (literal sense) \[`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`\]

| Rank   | System                      | F1    | Precision   | Recall   |
|:-------|:----------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_hipe2020_fr_1 | 0.560 | 0.546       | 0.576    |
| 2      | team2_bundle1_hipe2020_fr_2 | 0.558 | 0.543       | 0.574    |

See [ranking-hipe2020-fr-nel-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-fr-nel-micro-fuzzy-all.tsv) for full details.

### newseye

### letemps

### sonar

### topres19th

### ajmc

#### EL ajmc English strict @1 (literal sense) \[`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`\]

| Rank   | System                  | F1    | Precision   | Recall   |
|:-------|:------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_ajmc_en_2 | 0.030 | 0.022       | 0.044    |
| 2      | team2_bundle1_ajmc_en_1 | 0.029 | 0.022       | 0.044    |

See [ranking-ajmc-en-nel-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-en-nel-micro-fuzzy-all.tsv) for full details.

## EL only

Relevant bundles: 5

### hipe2020

#### EL only hipe2020 German strict @1 (literal sense) \[`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`\]

| Rank   | System                      | F1    | Precision   | Recall   |
|:-------|:----------------------------|:------|:------------|:---------|
| 1      | team5_bundle5_hipe2020_de_1 | 0.506 | 0.603       | 0.435    |
| 2      | team5_bundle5_hipe2020_de_2 | 0.499 | 0.663       | 0.400    |
| 3      | team2_bundle5_hipe2020_de_1 | 0.481 | 0.481       | 0.481    |

See [ranking-hipe2020-de-nel-only-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-de-nel-only-micro-fuzzy-all.tsv) for full details.

#### EL only hipe2020 English strict @1 (literal sense) \[`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`\]

| Rank   | System                      | F1    | Precision   | Recall   |
|:-------|:----------------------------|:------|:------------|:---------|
| 1      | team2_bundle5_hipe2020_en_1 | 0.546 | 0.546       | 0.546    |
| 2      | team5_bundle5_hipe2020_en_2 | 0.393 | 0.503       | 0.323    |
| 3      | team5_bundle5_hipe2020_en_1 | 0.380 | 0.481       | 0.314    |

See [ranking-hipe2020-en-nel-only-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-en-nel-only-micro-fuzzy-all.tsv) for full details.

#### EL only hipe2020 French strict @1 (literal sense) \[`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`\]

| Rank   | System                      | F1    | Precision   | Recall   |
|:-------|:----------------------------|:------|:------------|:---------|
| 1      | team2_bundle5_hipe2020_fr_1 | 0.602 | 0.602       | 0.602    |
| 2      | team5_bundle5_hipe2020_fr_2 | 0.596 | 0.707       | 0.515    |
| 3      | team5_bundle5_hipe2020_fr_1 | 0.562 | 0.664       | 0.487    |

See [ranking-hipe2020-fr-nel-only-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-fr-nel-only-micro-fuzzy-all.tsv) for full details.

### newseye

#### EL only newseye German strict @1 (literal sense) \[`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`\]

| Rank   | System                     | F1    | Precision   | Recall   |
|:-------|:---------------------------|:------|:------------|:---------|
| 1      | team5_bundle5_newseye_de_1 | 0.444 | 0.522       | 0.387    |
| 2      | team5_bundle5_newseye_de_2 | 0.393 | 0.520       | 0.316    |

See [ranking-newseye-de-nel-only-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-de-nel-only-micro-fuzzy-all.tsv) for full details.

#### EL only newseye French strict @1 (literal sense) \[`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`\]

| Rank   | System                     | F1    | Precision   | Recall   |
|:-------|:---------------------------|:------|:------------|:---------|
| 1      | team5_bundle5_newseye_fr_1 | 0.431 | 0.534       | 0.361    |
| 2      | team5_bundle5_newseye_fr_2 | 0.430 | 0.528       | 0.363    |

See [ranking-newseye-fr-nel-only-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-fr-nel-only-micro-fuzzy-all.tsv) for full details.

### letemps

### sonar

#### EL only sonar German strict @1 (literal sense) \[`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`\]

| Rank   | System                   | F1    | Precision   | Recall   |
|:-------|:-------------------------|:------|:------------|:---------|
| 1      | team5_bundle5_sonar_de_1 | 0.417 | 0.493       | 0.362    |
| 2      | team5_bundle5_sonar_de_2 | 0.373 | 0.466       | 0.310    |

See [ranking-sonar-de-nel-only-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-sonar-de-nel-only-micro-fuzzy-all.tsv) for full details.

### topres19th

#### EL only topres19th English strict @1 (literal sense) \[`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`\]

| Rank   | System                        | F1    | Precision   | Recall   |
|:-------|:------------------------------|:------|:------------|:---------|
| 1      | team5_bundle5_topres19th_en_2 | 0.651 | 0.778       | 0.559    |
| 2      | team5_bundle5_topres19th_en_1 | 0.649 | 0.786       | 0.552    |

See [ranking-topres19th-en-nel-only-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-topres19th-en-nel-only-micro-fuzzy-all.tsv) for full details.

### ajmc

#### EL only ajmc German strict @1 (literal sense) \[`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`\]

| Rank   | System                  | F1    | Precision   | Recall   |
|:-------|:------------------------|:------|:------------|:---------|
| 1      | team5_bundle5_ajmc_de_2 | 0.503 | 0.712       | 0.389    |
| 2      | team5_bundle5_ajmc_de_1 | 0.471 | 0.608       | 0.384    |

See [ranking-ajmc-de-nel-only-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-de-nel-only-micro-fuzzy-all.tsv) for full details.

#### EL only ajmc English strict @1 (literal sense) \[`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`\]

| Rank   | System                  | F1    | Precision   | Recall   |
|:-------|:------------------------|:------|:------------|:---------|
| 1      | team5_bundle5_ajmc_en_2 | 0.381 | 0.578       | 0.284    |
| 2      | team5_bundle5_ajmc_en_1 | 0.376 | 0.580       | 0.279    |

See [ranking-ajmc-en-nel-only-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-en-nel-only-micro-fuzzy-all.tsv) for full details.

#### EL only ajmc French strict @1 (literal sense) \[`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`\]

| Rank   | System                  | F1    | Precision   | Recall   |
|:-------|:------------------------|:------|:------------|:---------|
| 1      | team5_bundle5_ajmc_fr_1 | 0.470 | 0.621       | 0.378    |
| 2      | team5_bundle5_ajmc_fr_2 | 0.469 | 0.617       | 0.378    |

See [ranking-ajmc-fr-nel-only-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-fr-nel-only-micro-fuzzy-all.tsv) for full details.
