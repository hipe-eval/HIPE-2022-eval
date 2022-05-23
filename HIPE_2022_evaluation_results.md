# HIPE 2022 evaluation results

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

- Date: 23.05.2022.
- Bundles: 1 to 5
- HIPE-2022 data version: [v2.1-test-all-unmasked](https://github.com/hipe-eval/HIPE-2022-data/releases/tag/v2.1-test-all-unmasked)
- HIPE scorer version: [v2.0](https://github.com/hipe-eval/HIPE-scorer/releases/tag/2.0)
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




<!--ts-->
* [HIPE 2022 evaluation results](./ranking_summary.md#hipe-2022-evaluation-results)
   * [Track Evaluation results](./ranking_summary.md#track-evaluation-results)
      * [About the evaluation (reminder)](./ranking_summary.md#about-the-evaluation-reminder)
   * [NERC coarse](./ranking_summary.md#nerc-coarse)
      * [hipe2020](./ranking_summary.md#hipe2020)
      * [newseye](./ranking_summary.md#newseye)
      * [letemps](./ranking_summary.md#letemps)
      * [sonar](./ranking_summary.md#sonar)
      * [topres19th](./ranking_summary.md#topres19th)
      * [ajmc](./ranking_summary.md#ajmc)
   * [NERC fine](./ranking_summary.md#nerc-fine)
      * [hipe2020](./ranking_summary.md#hipe2020-1)
      * [letemps](./ranking_summary.md#letemps-1)
      * [ajmc](./ranking_summary.md#ajmc-1)
   * [EL](./ranking_summary.md#el)
      * [hipe2020](./ranking_summary.md#hipe2020-2)
      * [newseye](./ranking_summary.md#newseye-1)
      * [sonar](./ranking_summary.md#sonar-1)
      * [topres19th](./ranking_summary.md#topres19th-1)
      * [ajmc](./ranking_summary.md#ajmc-2)
   * [EL only](./ranking_summary.md#el-only)
      * [hipe2020](./ranking_summary.md#hipe2020-3)
      * [newseye](./ranking_summary.md#newseye-2)
      * [sonar](./ranking_summary.md#sonar-2)
      * [topres19th](./ranking_summary.md#topres19th-2)
      * [ajmc](./ranking_summary.md#ajmc-3)

<!-- Created by https://github.com/ekalinin/github-markdown-toc -->
<!-- Added by: maudehrmann, at: Mon May 23 18:07:23 CEST 2022 -->

<!--te-->


## NERC coarse

Relevant bundles: 1-4

### hipe2020

**NERC coarse hipe2020 German strict (literal sense)** [`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`]

| Rank   | System                        | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:------------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle3_hipe2020_de_1   | 0.794 | 0.784       | 0.805    | 923  | 254  | 224  |
| 2      | team2_bundle1_hipe2020_de_2   | 0.784 | 0.780       | 0.787    | 903  | 255  | 244  |
| 3      | team2_bundle1_hipe2020_de_1   | 0.774 | 0.757       | 0.792    | 908  | 292  | 239  |
| 4      | team4_bundle4_hipe2020_de_1   | 0.725 | 0.716       | 0.735    | 843  | 335  | 304  |
| 5      | neurbsl_bundle3_hipe2020_de_1 | 0.703 | 0.665       | 0.746    | 856  | 432  | 291  |
| 6      | team4_bundle4_hipe2020_de_2   | 0.695 | 0.677       | 0.714    | 819  | 391  | 328  |

See [ranking-hipe2020-de-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-de-coarse-micro-strict-all.tsv) for full details.

**NERC coarse hipe2020 German fuzzy (literal sense)** [`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`]

| Rank   | System                        | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:------------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle3_hipe2020_de_1   | 0.876 | 0.865       | 0.888    | 1018 | 159  | 129  |
| 2      | team2_bundle1_hipe2020_de_2   | 0.874 | 0.870       | 0.878    | 1007 | 151  | 140  |
| 3      | team2_bundle1_hipe2020_de_1   | 0.872 | 0.853       | 0.892    | 1023 | 177  | 124  |
| 4      | team4_bundle4_hipe2020_de_1   | 0.822 | 0.812       | 0.833    | 956  | 222  | 191  |
| 5      | team4_bundle4_hipe2020_de_2   | 0.804 | 0.783       | 0.826    | 947  | 263  | 200  |
| 6      | neurbsl_bundle3_hipe2020_de_1 | 0.793 | 0.750       | 0.842    | 966  | 322  | 181  |

See [ranking-hipe2020-de-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-de-coarse-micro-fuzzy-all.tsv) for full details.

**NERC coarse hipe2020 English strict (literal sense)** [`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`]

| Rank   | System                        | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:------------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle1_hipe2020_en_1   | 0.620 | 0.624       | 0.617    | 277  | 167  | 172  |
| 2      | team2_bundle1_hipe2020_en_2   | 0.612 | 0.604       | 0.619    | 278  | 182  | 171  |
| 3      | team4_bundle4_hipe2020_en_1   | 0.513 | 0.538       | 0.490    | 220  | 189  | 229  |
| 4      | neurbsl_bundle3_hipe2020_en_1 | 0.477 | 0.432       | 0.532    | 239  | 314  | 210  |
| 5      | team3_bundle4_hipe2020_en_1   | 0.414 | 0.400       | 0.430    | 193  | 290  | 256  |

See [ranking-hipe2020-en-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-en-coarse-micro-strict-all.tsv) for full details.

**NERC coarse hipe2020 English fuzzy (literal sense)** [`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`]

| Rank   | System                        | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:------------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle1_hipe2020_en_1   | 0.788 | 0.793       | 0.784    | 352  | 92   | 97   |
| 2      | team2_bundle1_hipe2020_en_2   | 0.781 | 0.772       | 0.791    | 355  | 105  | 94   |
| 3      | team4_bundle4_hipe2020_en_1   | 0.692 | 0.726       | 0.661    | 297  | 112  | 152  |
| 4      | neurbsl_bundle3_hipe2020_en_1 | 0.623 | 0.564       | 0.695    | 312  | 241  | 137  |
| 5      | team3_bundle4_hipe2020_en_1   | 0.603 | 0.582       | 0.626    | 281  | 202  | 168  |

See [ranking-hipe2020-en-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-en-coarse-micro-fuzzy-all.tsv) for full details.

**NERC coarse hipe2020 French strict (literal sense)** [`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`]

| Rank   | System                        | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:------------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle1_hipe2020_fr_1   | 0.808 | 0.786       | 0.831    | 1329 | 361  | 271  |
| 2      | team2_bundle1_hipe2020_fr_2   | 0.804 | 0.782       | 0.827    | 1323 | 368  | 277  |
| 3      | team2_bundle3_hipe2020_fr_1   | 0.798 | 0.775       | 0.823    | 1316 | 381  | 284  |
| 4      | neurbsl_bundle3_hipe2020_fr_1 | 0.757 | 0.730       | 0.785    | 1256 | 464  | 344  |
| 5      | team4_bundle4_hipe2020_fr_2   | 0.696 | 0.718       | 0.675    | 1080 | 425  | 520  |
| 6      | team4_bundle4_hipe2020_fr_1   | 0.678 | 0.700       | 0.657    | 1051 | 451  | 549  |
| 7      | team3_bundle4_hipe2020_fr_1   | 0.674 | 0.640       | 0.712    | 1139 | 640  | 461  |

See [ranking-hipe2020-fr-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-fr-coarse-micro-strict-all.tsv) for full details.

**NERC coarse hipe2020 French fuzzy (literal sense)** [`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`]

| Rank   | System                        | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:------------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle1_hipe2020_fr_2   | 0.907 | 0.883       | 0.933    | 1493 | 198  | 107  |
| 2      | team2_bundle1_hipe2020_fr_1   | 0.904 | 0.880       | 0.929    | 1487 | 203  | 113  |
| 3      | team2_bundle3_hipe2020_fr_1   | 0.901 | 0.875       | 0.928    | 1485 | 212  | 115  |
| 4      | neurbsl_bundle3_hipe2020_fr_1 | 0.866 | 0.836       | 0.899    | 1438 | 282  | 162  |
| 5      | team3_bundle4_hipe2020_fr_1   | 0.808 | 0.767       | 0.853    | 1365 | 414  | 235  |
| 6      | team4_bundle4_hipe2020_fr_2   | 0.800 | 0.825       | 0.776    | 1242 | 263  | 358  |
| 7      | team4_bundle4_hipe2020_fr_1   | 0.798 | 0.824       | 0.773    | 1237 | 265  | 363  |

See [ranking-hipe2020-fr-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-fr-coarse-micro-fuzzy-all.tsv) for full details.

### newseye

**NERC coarse newseye German strict (literal sense)** [`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`]

| Rank   | System                       | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:-----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | neurbsl_bundle3_newseye_de_1 | 0.477 | 0.429       | 0.537    | 1291 | 1721 | 1111 |
| 2      | team4_bundle4_newseye_de_2   | 0.408 | 0.395       | 0.421    | 1012 | 1550 | 1390 |
| 3      | team4_bundle4_newseye_de_1   | 0.395 | 0.396       | 0.394    | 947  | 1444 | 1455 |

See [ranking-newseye-de-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-de-coarse-micro-strict-all.tsv) for full details.

**NERC coarse newseye German fuzzy (literal sense)** [`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`]

| Rank   | System                       | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:-----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | neurbsl_bundle3_newseye_de_1 | 0.570 | 0.512       | 0.642    | 1542 | 1470 | 860  |
| 2      | team4_bundle4_newseye_de_2   | 0.495 | 0.480       | 0.512    | 1229 | 1333 | 1173 |
| 3      | team4_bundle4_newseye_de_1   | 0.479 | 0.481       | 0.478    | 1149 | 1242 | 1253 |

See [ranking-newseye-de-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-de-coarse-micro-fuzzy-all.tsv) for full details.

**NERC coarse newseye French strict (literal sense)** [`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`]

| Rank   | System                       | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:-----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team4_bundle4_newseye_fr_2   | 0.656 | 0.655       | 0.657    | 1661 | 876  | 869  |
| 2      | neurbsl_bundle3_newseye_fr_1 | 0.654 | 0.634       | 0.676    | 1710 | 989  | 820  |
| 3      | team4_bundle4_newseye_fr_1   | 0.648 | 0.673       | 0.625    | 1582 | 768  | 948  |

See [ranking-newseye-fr-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-fr-coarse-micro-strict-all.tsv) for full details.

**NERC coarse newseye French fuzzy (literal sense)** [`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`]

| Rank   | System                       | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:-----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team4_bundle4_newseye_fr_2   | 0.786 | 0.785       | 0.787    | 1992 | 545  | 538  |
| 2      | neurbsl_bundle3_newseye_fr_1 | 0.779 | 0.755       | 0.805    | 2037 | 662  | 493  |
| 3      | team4_bundle4_newseye_fr_1   | 0.772 | 0.801       | 0.744    | 1883 | 467  | 647  |

See [ranking-newseye-fr-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-fr-coarse-micro-fuzzy-all.tsv) for full details.

**NERC coarse newseye Swedish strict (literal sense)** [`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`]

| Rank   | System                       | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:-----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | neurbsl_bundle3_newseye_sv_1 | 0.651 | 0.588       | 0.728    | 440  | 308  | 164  |
| 2      | team4_bundle4_newseye_sv_1   | 0.643 | 0.686       | 0.604    | 365  | 167  | 239  |
| 3      | team4_bundle4_newseye_sv_2   | 0.636 | 0.673       | 0.603    | 364  | 177  | 240  |

See [ranking-newseye-sv-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-sv-coarse-micro-strict-all.tsv) for full details.

**NERC coarse newseye Swedish fuzzy (literal sense)** [`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`]

| Rank   | System                       | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:-----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | neurbsl_bundle3_newseye_sv_1 | 0.747 | 0.675       | 0.836    | 505  | 243  | 99   |
| 2      | team4_bundle4_newseye_sv_1   | 0.746 | 0.797       | 0.702    | 424  | 108  | 180  |
| 3      | team4_bundle4_newseye_sv_2   | 0.742 | 0.786       | 0.704    | 425  | 116  | 179  |

See [ranking-newseye-sv-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-sv-coarse-micro-fuzzy-all.tsv) for full details.

**NERC coarse newseye Finnish strict (literal sense)** [`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`]

| Rank   | System                       | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:-----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | neurbsl_bundle3_newseye_fi_1 | 0.644 | 0.605       | 0.687    | 475  | 310  | 216  |
| 2      | team4_bundle4_newseye_fi_1   | 0.567 | 0.618       | 0.524    | 362  | 224  | 329  |
| 3      | team4_bundle4_newseye_fi_2   | 0.556 | 0.592       | 0.524    | 362  | 250  | 329  |

See [ranking-newseye-fi-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-fi-coarse-micro-strict-all.tsv) for full details.

**NERC coarse newseye Finnish fuzzy (literal sense)** [`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`]

| Rank   | System                       | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:-----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | neurbsl_bundle3_newseye_fi_1 | 0.760 | 0.715       | 0.812    | 561  | 224  | 130  |
| 2      | team4_bundle4_newseye_fi_1   | 0.670 | 0.730       | 0.619    | 428  | 158  | 263  |
| 3      | team4_bundle4_newseye_fi_2   | 0.640 | 0.681       | 0.603    | 417  | 195  | 274  |

See [ranking-newseye-fi-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-fi-coarse-micro-fuzzy-all.tsv) for full details.

### letemps

**NERC coarse letemps French strict (literal sense)** [`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`]

| Rank   | System                       | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:-----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | neurbsl_bundle3_letemps_fr_1 | 0.661 | 0.595       | 0.744    | 757  | 516  | 260  |
| 2      | team4_bundle4_letemps_fr_1   | 0.644 | 0.589       | 0.710    | 722  | 503  | 295  |
| 3      | team4_bundle4_letemps_fr_2   | 0.622 | 0.557       | 0.704    | 716  | 570  | 301  |
| 4      | team3_bundle4_letemps_fr_1   | 0.618 | 0.581       | 0.659    | 670  | 483  | 347  |

See [ranking-letemps-fr-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-letemps-fr-coarse-micro-strict-all.tsv) for full details.

**NERC coarse letemps French fuzzy (literal sense)** [`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`]

| Rank   | System                       | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:-----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | neurbsl_bundle3_letemps_fr_1 | 0.711 | 0.639       | 0.800    | 814  | 459  | 203  |
| 2      | team4_bundle4_letemps_fr_1   | 0.701 | 0.642       | 0.773    | 786  | 439  | 231  |
| 3      | team4_bundle4_letemps_fr_2   | 0.681 | 0.610       | 0.771    | 784  | 502  | 233  |
| 4      | team3_bundle4_letemps_fr_1   | 0.666 | 0.627       | 0.711    | 723  | 430  | 294  |

See [ranking-letemps-fr-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-letemps-fr-coarse-micro-fuzzy-all.tsv) for full details.

### sonar

**NERC coarse sonar German strict (literal sense)** [`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`]

| Rank   | System                     | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:---------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team4_bundle4_sonar_de_1   | 0.529 | 0.512       | 0.548    | 258  | 246  | 213  |
| 2      | team4_bundle4_sonar_de_2   | 0.516 | 0.486       | 0.550    | 259  | 274  | 212  |
| 3      | neurbsl_bundle3_sonar_de_1 | 0.307 | 0.267       | 0.361    | 170  | 467  | 301  |

See [ranking-sonar-de-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-sonar-de-coarse-micro-strict-all.tsv) for full details.

**NERC coarse sonar German fuzzy (literal sense)** [`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`]

| Rank   | System                     | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:---------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team4_bundle4_sonar_de_2   | 0.695 | 0.655       | 0.741    | 349  | 184  | 122  |
| 2      | team4_bundle4_sonar_de_1   | 0.693 | 0.671       | 0.718    | 338  | 166  | 133  |
| 3      | neurbsl_bundle3_sonar_de_1 | 0.471 | 0.410       | 0.554    | 261  | 376  | 210  |

See [ranking-sonar-de-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-sonar-de-coarse-micro-fuzzy-all.tsv) for full details.

### topres19th

**NERC coarse topres19th English strict (literal sense)** [`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`]

| Rank   | System                          | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:--------------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team4_bundle4_topres19th_en_1   | 0.787 | 0.816       | 0.760    | 902  | 204  | 285  |
| 2      | team4_bundle4_topres19th_en_2   | 0.781 | 0.761       | 0.802    | 952  | 299  | 235  |
| 3      | neurbsl_bundle3_topres19th_en_1 | 0.764 | 0.747       | 0.782    | 928  | 315  | 259  |
| 4      | team3_bundle4_topres19th_en_1   | 0.740 | 0.712       | 0.771    | 915  | 371  | 272  |

See [ranking-topres19th-en-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-topres19th-en-coarse-micro-strict-all.tsv) for full details.

**NERC coarse topres19th English fuzzy (literal sense)** [`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`]

| Rank   | System                          | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:--------------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team4_bundle4_topres19th_en_1   | 0.838 | 0.869       | 0.810    | 961  | 145  | 226  |
| 2      | team4_bundle4_topres19th_en_2   | 0.829 | 0.807       | 0.851    | 1010 | 241  | 177  |
| 3      | neurbsl_bundle3_topres19th_en_1 | 0.816 | 0.798       | 0.836    | 992  | 251  | 195  |
| 4      | team3_bundle4_topres19th_en_1   | 0.796 | 0.765       | 0.829    | 984  | 302  | 203  |

See [ranking-topres19th-en-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-topres19th-en-coarse-micro-fuzzy-all.tsv) for full details.

### ajmc

**NERC coarse ajmc German strict (literal sense)** [`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`]

| Rank   | System                    | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:--------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle3_ajmc_de_2   | 0.934 | 0.946       | 0.921    | 352  | 20   | 30   |
| 2      | team1_bundle4_ajmc_de_1   | 0.913 | 0.930       | 0.898    | 343  | 26   | 39   |
| 3      | team1_bundle4_ajmc_de_2   | 0.912 | 0.905       | 0.919    | 351  | 37   | 31   |
| 4      | team2_bundle3_ajmc_de_1   | 0.908 | 0.913       | 0.903    | 345  | 33   | 37   |
| 5      | neurbsl_bundle3_ajmc_de_1 | 0.818 | 0.792       | 0.846    | 323  | 85   | 59   |

See [ranking-ajmc-de-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-de-coarse-micro-strict-all.tsv) for full details.

**NERC coarse ajmc German fuzzy (literal sense)** [`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`]

| Rank   | System                    | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:--------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle3_ajmc_de_2   | 0.952 | 0.965       | 0.940    | 359  | 13   | 23   |
| 2      | team1_bundle4_ajmc_de_2   | 0.945 | 0.938       | 0.953    | 364  | 24   | 18   |
| 3      | team1_bundle4_ajmc_de_1   | 0.937 | 0.954       | 0.921    | 352  | 17   | 30   |
| 4      | team2_bundle3_ajmc_de_1   | 0.934 | 0.939       | 0.929    | 355  | 23   | 27   |
| 5      | neurbsl_bundle3_ajmc_de_1 | 0.873 | 0.846       | 0.903    | 345  | 63   | 37   |

See [ranking-ajmc-de-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-de-coarse-micro-fuzzy-all.tsv) for full details.

**NERC coarse ajmc English strict (literal sense)** [`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`]

| Rank   | System                    | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:--------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team1_bundle4_ajmc_en_2   | 0.854 | 0.826       | 0.885    | 308  | 65   | 40   |
| 2      | team2_bundle1_ajmc_en_1   | 0.850 | 0.824       | 0.876    | 305  | 65   | 43   |
| 3      | team2_bundle1_ajmc_en_2   | 0.841 | 0.831       | 0.851    | 296  | 60   | 52   |
| 4      | team1_bundle4_ajmc_en_1   | 0.819 | 0.783       | 0.859    | 299  | 83   | 49   |
| 5      | neurbsl_bundle3_ajmc_en_1 | 0.736 | 0.680       | 0.802    | 279  | 131  | 69   |

See [ranking-ajmc-en-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-en-coarse-micro-strict-all.tsv) for full details.

**NERC coarse ajmc English fuzzy (literal sense)** [`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`]

| Rank   | System                    | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:--------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team1_bundle4_ajmc_en_2   | 0.910 | 0.879       | 0.943    | 328  | 45   | 20   |
| 2      | team1_bundle4_ajmc_en_1   | 0.899 | 0.859       | 0.943    | 328  | 54   | 20   |
| 3      | team2_bundle1_ajmc_en_1   | 0.894 | 0.868       | 0.922    | 321  | 49   | 27   |
| 4      | team2_bundle1_ajmc_en_2   | 0.884 | 0.874       | 0.894    | 311  | 45   | 37   |
| 5      | neurbsl_bundle3_ajmc_en_1 | 0.828 | 0.766       | 0.902    | 314  | 96   | 34   |

See [ranking-ajmc-en-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-en-coarse-micro-fuzzy-all.tsv) for full details.

**NERC coarse ajmc French strict (literal sense)** [`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`]

| Rank   | System                    | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:--------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team1_bundle4_ajmc_fr_2   | 0.842 | 0.834       | 0.850    | 306  | 61   | 54   |
| 2      | team1_bundle4_ajmc_fr_1   | 0.833 | 0.820       | 0.847    | 305  | 67   | 55   |
| 3      | team2_bundle3_ajmc_fr_2   | 0.826 | 0.810       | 0.842    | 303  | 71   | 57   |
| 4      | team2_bundle3_ajmc_fr_1   | 0.798 | 0.780       | 0.817    | 294  | 83   | 66   |
| 5      | neurbsl_bundle3_ajmc_fr_1 | 0.741 | 0.707       | 0.778    | 280  | 116  | 80   |

See [ranking-ajmc-fr-coarse-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-fr-coarse-micro-strict-all.tsv) for full details.

**NERC coarse ajmc French fuzzy (literal sense)** [`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`]

| Rank   | System                    | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:--------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team1_bundle4_ajmc_fr_1   | 0.888 | 0.874       | 0.903    | 325  | 47   | 35   |
| 2      | team1_bundle4_ajmc_fr_2   | 0.880 | 0.872       | 0.889    | 320  | 47   | 40   |
| 3      | team2_bundle3_ajmc_fr_2   | 0.872 | 0.856       | 0.889    | 320  | 54   | 40   |
| 4      | team2_bundle3_ajmc_fr_1   | 0.860 | 0.841       | 0.881    | 317  | 60   | 43   |
| 5      | neurbsl_bundle3_ajmc_fr_1 | 0.825 | 0.788       | 0.867    | 312  | 84   | 48   |

See [ranking-ajmc-fr-coarse-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-fr-coarse-micro-fuzzy-all.tsv) for full details.

## NERC fine

Relevant bundles: 1, 3

### hipe2020

**NERC fine hipe2020 German strict (literal sense)** [`NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL`]

| Rank   | System                        | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:------------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle3_hipe2020_de_1   | 0.718 | 0.691       | 0.747    | 857  | 384  | 290  |
| 2      | team2_bundle1_hipe2020_de_1   | 0.689 | 0.658       | 0.724    | 830  | 431  | 317  |
| 3      | team2_bundle1_hipe2020_de_2   | 0.682 | 0.657       | 0.710    | 814  | 425  | 333  |
| 4      | neurbsl_bundle3_hipe2020_de_1 | 0.625 | 0.584       | 0.673    | 772  | 550  | 375  |

See [ranking-hipe2020-de-fine-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-de-fine-micro-strict-all.tsv) for full details.

**NERC fine hipe2020 German fuzzy (literal sense)** [`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`]

| Rank   | System                        | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:------------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle3_hipe2020_de_1   | 0.807 | 0.776       | 0.840    | 963  | 278  | 184  |
| 2      | team2_bundle1_hipe2020_de_1   | 0.785 | 0.749       | 0.824    | 945  | 316  | 202  |
| 3      | team2_bundle1_hipe2020_de_2   | 0.783 | 0.754       | 0.814    | 934  | 305  | 213  |
| 4      | neurbsl_bundle3_hipe2020_de_1 | 0.706 | 0.659       | 0.759    | 871  | 451  | 276  |

See [ranking-hipe2020-de-fine-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-de-fine-micro-fuzzy-all.tsv) for full details.

**NERC fine hipe2020 German strict, nested entities** [`NE-NESTED-micro-strict-TIME-ALL-LED-ALL`]

| Rank   | System                      | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle3_hipe2020_de_1 | 0.522 | 0.714       | 0.411    | 30   | 12   | 43   |
| 2      | team2_bundle1_hipe2020_de_2 | 0.457 | 0.750       | 0.329    | 24   | 8    | 49   |
| 3      | team2_bundle1_hipe2020_de_1 | 0.393 | 0.618       | 0.288    | 21   | 13   | 52   |

See [ranking-hipe2020-de-fine-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-de-fine-micro-strict-all.tsv) for full details.

**NERC fine hipe2020 German fuzzy, nested entities** [`NE-NESTED-micro-fuzzy-TIME-ALL-LED-ALL`]

| Rank   | System                      | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle3_hipe2020_de_1 | 0.539 | 0.738       | 0.425    | 31   | 11   | 42   |
| 2      | team2_bundle1_hipe2020_de_2 | 0.476 | 0.781       | 0.342    | 25   | 7    | 48   |
| 3      | team2_bundle1_hipe2020_de_1 | 0.393 | 0.618       | 0.288    | 21   | 13   | 52   |

See [ranking-hipe2020-de-fine-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-de-fine-micro-fuzzy-all.tsv) for full details.

**NERC fine hipe2020 French strict (literal sense)** [`NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL`]

| Rank   | System                        | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:------------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle1_hipe2020_fr_1   | 0.740 | 0.702       | 0.782    | 1251 | 531  | 349  |
| 2      | team2_bundle1_hipe2020_fr_2   | 0.736 | 0.697       | 0.779    | 1246 | 541  | 354  |
| 3      | team2_bundle3_hipe2020_fr_1   | 0.720 | 0.679       | 0.767    | 1227 | 581  | 373  |
| 4      | neurbsl_bundle3_hipe2020_fr_1 | 0.708 | 0.685       | 0.733    | 1172 | 538  | 428  |

See [ranking-hipe2020-fr-fine-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-fr-fine-micro-strict-all.tsv) for full details.

**NERC fine hipe2020 French fuzzy (literal sense)** [`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`]

| Rank   | System                        | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:------------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle1_hipe2020_fr_1   | 0.826 | 0.784       | 0.873    | 1397 | 385  | 203  |
| 2      | team2_bundle1_hipe2020_fr_2   | 0.825 | 0.782       | 0.873    | 1397 | 390  | 203  |
| 3      | team2_bundle3_hipe2020_fr_1   | 0.812 | 0.765       | 0.865    | 1384 | 424  | 216  |
| 4      | neurbsl_bundle3_hipe2020_fr_1 | 0.795 | 0.769       | 0.822    | 1315 | 395  | 285  |

See [ranking-hipe2020-fr-fine-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-fr-fine-micro-fuzzy-all.tsv) for full details.

**NERC fine hipe2020 French strict, nested entities** [`NE-NESTED-micro-strict-TIME-ALL-LED-ALL`]

| Rank   | System                      | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle1_hipe2020_fr_2 | 0.377 | 0.390       | 0.366    | 30   | 47   | 52   |
| 2      | team2_bundle1_hipe2020_fr_1 | 0.366 | 0.394       | 0.341    | 28   | 43   | 54   |
| 3      | team2_bundle3_hipe2020_fr_1 | 0.320 | 0.301       | 0.341    | 28   | 65   | 54   |

See [ranking-hipe2020-fr-fine-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-fr-fine-micro-strict-all.tsv) for full details.

**NERC fine hipe2020 French fuzzy, nested entities** [`NE-NESTED-micro-fuzzy-TIME-ALL-LED-ALL`]

| Rank   | System                      | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle1_hipe2020_fr_2 | 0.403 | 0.416       | 0.390    | 32   | 45   | 50   |
| 2      | team2_bundle1_hipe2020_fr_1 | 0.392 | 0.423       | 0.366    | 30   | 41   | 52   |
| 3      | team2_bundle3_hipe2020_fr_1 | 0.389 | 0.366       | 0.415    | 34   | 59   | 48   |

See [ranking-hipe2020-fr-fine-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-fr-fine-micro-fuzzy-all.tsv) for full details.

### letemps

**NERC fine letemps French strict (literal sense)** [`NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL`]

| Rank   | System                       | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:-----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | neurbsl_bundle3_letemps_fr_1 | 0.615 | 0.564       | 0.676    | 688  | 531  | 329  |

See [ranking-letemps-fr-fine-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-letemps-fr-fine-micro-strict-all.tsv) for full details.

**NERC fine letemps French fuzzy (literal sense)** [`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`]

| Rank   | System                       | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:-----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | neurbsl_bundle3_letemps_fr_1 | 0.654 | 0.600       | 0.719    | 731  | 488  | 286  |

See [ranking-letemps-fr-fine-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-letemps-fr-fine-micro-fuzzy-all.tsv) for full details.

### ajmc

**NERC fine ajmc German strict (literal sense)** [`NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL`]

| Rank   | System                    | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:--------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle3_ajmc_de_2   | 0.906 | 0.915       | 0.898    | 343  | 32   | 39   |
| 2      | team2_bundle3_ajmc_de_1   | 0.880 | 0.860       | 0.901    | 344  | 56   | 38   |
| 3      | neurbsl_bundle3_ajmc_de_1 | 0.818 | 0.819       | 0.817    | 312  | 69   | 70   |

See [ranking-ajmc-de-fine-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-de-fine-micro-strict-all.tsv) for full details.

**NERC fine ajmc German fuzzy (literal sense)** [`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`]

| Rank   | System                    | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:--------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle3_ajmc_de_2   | 0.933 | 0.941       | 0.924    | 353  | 22   | 29   |
| 2      | team2_bundle3_ajmc_de_1   | 0.905 | 0.885       | 0.927    | 354  | 46   | 28   |
| 3      | neurbsl_bundle3_ajmc_de_1 | 0.865 | 0.866       | 0.864    | 330  | 51   | 52   |

See [ranking-ajmc-de-fine-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-de-fine-micro-fuzzy-all.tsv) for full details.

**NERC fine ajmc English strict (literal sense)** [`NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL`]

| Rank   | System                    | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:--------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle1_ajmc_en_1   | 0.798 | 0.754       | 0.848    | 295  | 96   | 53   |
| 2      | team2_bundle1_ajmc_en_2   | 0.781 | 0.745       | 0.822    | 286  | 98   | 62   |
| 3      | neurbsl_bundle3_ajmc_en_1 | 0.664 | 0.600       | 0.744    | 259  | 173  | 89   |

See [ranking-ajmc-en-fine-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-en-fine-micro-strict-all.tsv) for full details.

**NERC fine ajmc English fuzzy (literal sense)** [`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`]

| Rank   | System                    | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:--------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle1_ajmc_en_1   | 0.847 | 0.801       | 0.899    | 313  | 78   | 35   |
| 2      | team2_bundle1_ajmc_en_2   | 0.847 | 0.807       | 0.891    | 310  | 74   | 38   |
| 3      | neurbsl_bundle3_ajmc_en_1 | 0.749 | 0.676       | 0.839    | 292  | 140  | 56   |

See [ranking-ajmc-en-fine-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-en-fine-micro-fuzzy-all.tsv) for full details.

**NERC fine ajmc French strict (literal sense)** [`NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL`]

| Rank   | System                    | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:--------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle3_ajmc_fr_2   | 0.669 | 0.646       | 0.694    | 250  | 137  | 110  |
| 2      | team2_bundle3_ajmc_fr_1   | 0.645 | 0.623       | 0.669    | 241  | 146  | 119  |
| 3      | neurbsl_bundle3_ajmc_fr_1 | 0.545 | 0.526       | 0.567    | 204  | 184  | 156  |

See [ranking-ajmc-fr-fine-micro-strict-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-fr-fine-micro-strict-all.tsv) for full details.

**NERC fine ajmc French fuzzy (literal sense)** [`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`]

| Rank   | System                    | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:--------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle3_ajmc_fr_2   | 0.728 | 0.703       | 0.756    | 272  | 115  | 88   |
| 2      | team2_bundle3_ajmc_fr_1   | 0.710 | 0.685       | 0.736    | 265  | 122  | 95   |
| 3      | neurbsl_bundle3_ajmc_fr_1 | 0.639 | 0.616       | 0.664    | 239  | 149  | 121  |

See [ranking-ajmc-fr-fine-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-fr-fine-micro-fuzzy-all.tsv) for full details.

## EL

Relevant bundles: 1, 2

### hipe2020

**EL hipe2020 German strict @1 (literal sense)** [`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`]

| Rank   | System                      | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle1_hipe2020_de_2 | 0.449 | 0.446       | 0.451    | 517  | 641  | 630  |
| 2      | team2_bundle1_hipe2020_de_1 | 0.447 | 0.438       | 0.458    | 525  | 675  | 622  |

See [ranking-hipe2020-de-nel-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-de-nel-micro-fuzzy-all.tsv) for full details.

**EL hipe2020 German relaxed @1 (literal sense)** [`NEL-LIT-micro-fuzzy-relaxed-TIME-ALL-LED-ALL-@1`]

| Rank   | System                      | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle1_hipe2020_de_2 | 0.464 | 0.462       | 0.466    | 535  | 623  | 612  |
| 2      | team2_bundle1_hipe2020_de_1 | 0.463 | 0.453       | 0.473    | 543  | 657  | 604  |

See [ranking-hipe2020-de-nel-micro-fuzzy-relaxed-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-de-nel-micro-fuzzy-relaxed-all.tsv) for full details.

**EL hipe2020 English strict @1 (literal sense)** [`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`]

| Rank   | System                      | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle1_hipe2020_en_2 | 0.469 | 0.463       | 0.474    | 213  | 247  | 236  |
| 2      | team2_bundle1_hipe2020_en_1 | 0.468 | 0.471       | 0.465    | 209  | 235  | 240  |

See [ranking-hipe2020-en-nel-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-en-nel-micro-fuzzy-all.tsv) for full details.

**EL hipe2020 English relaxed @1 (literal sense)** [`NEL-LIT-micro-fuzzy-relaxed-TIME-ALL-LED-ALL-@1`]

| Rank   | System                      | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle1_hipe2020_en_2 | 0.469 | 0.463       | 0.474    | 213  | 247  | 236  |
| 2      | team2_bundle1_hipe2020_en_1 | 0.468 | 0.471       | 0.465    | 209  | 235  | 240  |

See [ranking-hipe2020-en-nel-micro-fuzzy-relaxed-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-en-nel-micro-fuzzy-relaxed-all.tsv) for full details.

**EL hipe2020 French strict @1 (literal sense)** [`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`]

| Rank   | System                      | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle1_hipe2020_fr_1 | 0.560 | 0.546       | 0.576    | 922  | 768  | 678  |
| 2      | team2_bundle1_hipe2020_fr_2 | 0.558 | 0.543       | 0.574    | 918  | 773  | 682  |

See [ranking-hipe2020-fr-nel-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-fr-nel-micro-fuzzy-all.tsv) for full details.

**EL hipe2020 French relaxed @1 (literal sense)** [`NEL-LIT-micro-fuzzy-relaxed-TIME-ALL-LED-ALL-@1`]

| Rank   | System                      | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle1_hipe2020_fr_1 | 0.578 | 0.563       | 0.594    | 951  | 739  | 649  |
| 2      | team2_bundle1_hipe2020_fr_2 | 0.576 | 0.560       | 0.592    | 947  | 744  | 653  |

See [ranking-hipe2020-fr-nel-micro-fuzzy-relaxed-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-fr-nel-micro-fuzzy-relaxed-all.tsv) for full details.

### newseye

### sonar

### topres19th

### ajmc

**EL ajmc English strict @1 (literal sense)** [`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`]

| Rank   | System                  | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle1_ajmc_en_2 | 0.030 | 0.022       | 0.044    | 8    | 348  | 175  |
| 2      | team2_bundle1_ajmc_en_1 | 0.029 | 0.022       | 0.044    | 8    | 362  | 175  |

See [ranking-ajmc-en-nel-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-en-nel-micro-fuzzy-all.tsv) for full details.

**EL ajmc English relaxed @1 (literal sense)** [`NEL-LIT-micro-fuzzy-relaxed-TIME-ALL-LED-ALL-@1`]

| Rank   | System                  | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle1_ajmc_en_2 | 0.030 | 0.022       | 0.044    | 8    | 348  | 175  |
| 2      | team2_bundle1_ajmc_en_1 | 0.029 | 0.022       | 0.044    | 8    | 362  | 175  |

See [ranking-ajmc-en-nel-micro-fuzzy-relaxed-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-en-nel-micro-fuzzy-relaxed-all.tsv) for full details.

## EL only

Relevant bundles: 5

### hipe2020

**EL only hipe2020 German strict @1 (literal sense)** [`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`]

| Rank   | System                      | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team5_bundle5_hipe2020_de_1 | 0.506 | 0.603       | 0.435    | 499  | 328  | 648  |
| 2      | team5_bundle5_hipe2020_de_2 | 0.499 | 0.663       | 0.400    | 459  | 233  | 688  |
| 3      | team2_bundle5_hipe2020_de_1 | 0.481 | 0.481       | 0.481    | 552  | 595  | 595  |

See [ranking-hipe2020-de-nel-only-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-de-nel-only-micro-fuzzy-all.tsv) for full details.

**EL only hipe2020 German relaxed @1 (literal sense)** [`NEL-LIT-micro-fuzzy-relaxed-TIME-ALL-LED-ALL-@1`]

| Rank   | System                      | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team5_bundle5_hipe2020_de_1 | 0.525 | 0.626       | 0.452    | 518  | 309  | 629  |
| 2      | team5_bundle5_hipe2020_de_2 | 0.517 | 0.686       | 0.414    | 475  | 217  | 672  |
| 3      | team2_bundle5_hipe2020_de_1 | 0.497 | 0.497       | 0.497    | 570  | 577  | 577  |

See [ranking-hipe2020-de-nel-only-micro-fuzzy-relaxed-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-de-nel-only-micro-fuzzy-relaxed-all.tsv) for full details.

**EL only hipe2020 English strict @1 (literal sense)** [`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`]

| Rank   | System                      | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle5_hipe2020_en_1 | 0.546 | 0.546       | 0.546    | 245  | 204  | 204  |
| 2      | team5_bundle5_hipe2020_en_2 | 0.393 | 0.503       | 0.323    | 145  | 143  | 304  |
| 3      | team5_bundle5_hipe2020_en_1 | 0.380 | 0.481       | 0.314    | 141  | 152  | 308  |

See [ranking-hipe2020-en-nel-only-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-en-nel-only-micro-fuzzy-all.tsv) for full details.

**EL only hipe2020 English relaxed @1 (literal sense)** [`NEL-LIT-micro-fuzzy-relaxed-TIME-ALL-LED-ALL-@1`]

| Rank   | System                      | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle5_hipe2020_en_1 | 0.546 | 0.546       | 0.546    | 245  | 204  | 204  |
| 2      | team5_bundle5_hipe2020_en_2 | 0.393 | 0.503       | 0.323    | 145  | 143  | 304  |
| 3      | team5_bundle5_hipe2020_en_1 | 0.380 | 0.481       | 0.314    | 141  | 152  | 308  |

See [ranking-hipe2020-en-nel-only-micro-fuzzy-relaxed-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-en-nel-only-micro-fuzzy-relaxed-all.tsv) for full details.

**EL only hipe2020 French strict @1 (literal sense)** [`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`]

| Rank   | System                      | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle5_hipe2020_fr_1 | 0.602 | 0.602       | 0.602    | 963  | 637  | 637  |
| 2      | team5_bundle5_hipe2020_fr_2 | 0.596 | 0.707       | 0.515    | 824  | 341  | 776  |
| 3      | team5_bundle5_hipe2020_fr_1 | 0.562 | 0.664       | 0.487    | 779  | 394  | 821  |

See [ranking-hipe2020-fr-nel-only-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-fr-nel-only-micro-fuzzy-all.tsv) for full details.

**EL only hipe2020 French relaxed @1 (literal sense)** [`NEL-LIT-micro-fuzzy-relaxed-TIME-ALL-LED-ALL-@1`]

| Rank   | System                      | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:----------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team2_bundle5_hipe2020_fr_1 | 0.620 | 0.620       | 0.620    | 992  | 608  | 608  |
| 2      | team5_bundle5_hipe2020_fr_2 | 0.616 | 0.730       | 0.532    | 851  | 314  | 749  |
| 3      | team5_bundle5_hipe2020_fr_1 | 0.582 | 0.688       | 0.504    | 807  | 366  | 793  |

See [ranking-hipe2020-fr-nel-only-micro-fuzzy-relaxed-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-hipe2020-fr-nel-only-micro-fuzzy-relaxed-all.tsv) for full details.

### newseye

**EL only newseye German strict @1 (literal sense)** [`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`]

| Rank   | System                     | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:---------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team5_bundle5_newseye_de_1 | 0.444 | 0.522       | 0.387    | 929  | 849  | 1473 |
| 2      | team5_bundle5_newseye_de_2 | 0.393 | 0.520       | 0.316    | 759  | 701  | 1643 |

See [ranking-newseye-de-nel-only-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-de-nel-only-micro-fuzzy-all.tsv) for full details.

**EL only newseye German relaxed @1 (literal sense)** [`NEL-LIT-micro-fuzzy-relaxed-TIME-ALL-LED-ALL-@1`]

| Rank   | System                     | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:---------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team5_bundle5_newseye_de_1 | 0.455 | 0.535       | 0.396    | 951  | 827  | 1451 |
| 2      | team5_bundle5_newseye_de_2 | 0.405 | 0.536       | 0.326    | 782  | 678  | 1620 |

See [ranking-newseye-de-nel-only-micro-fuzzy-relaxed-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-de-nel-only-micro-fuzzy-relaxed-all.tsv) for full details.

**EL only newseye French strict @1 (literal sense)** [`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`]

| Rank   | System                     | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:---------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team5_bundle5_newseye_fr_1 | 0.431 | 0.534       | 0.361    | 914  | 797  | 1616 |
| 2      | team5_bundle5_newseye_fr_2 | 0.430 | 0.528       | 0.363    | 919  | 821  | 1611 |

See [ranking-newseye-fr-nel-only-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-fr-nel-only-micro-fuzzy-all.tsv) for full details.

**EL only newseye French relaxed @1 (literal sense)** [`NEL-LIT-micro-fuzzy-relaxed-TIME-ALL-LED-ALL-@1`]

| Rank   | System                     | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:---------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team5_bundle5_newseye_fr_1 | 0.435 | 0.539       | 0.364    | 922  | 789  | 1608 |
| 2      | team5_bundle5_newseye_fr_2 | 0.433 | 0.531       | 0.365    | 924  | 816  | 1606 |

See [ranking-newseye-fr-nel-only-micro-fuzzy-relaxed-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-newseye-fr-nel-only-micro-fuzzy-relaxed-all.tsv) for full details.

### sonar

**EL only sonar German strict @1 (literal sense)** [`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`]

| Rank   | System                   | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:-------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team5_bundle5_sonar_de_1 | 0.517 | 0.616       | 0.446    | 210  | 131  | 261  |
| 2      | team5_bundle5_sonar_de_2 | 0.503 | 0.634       | 0.416    | 196  | 113  | 275  |

See [ranking-sonar-de-nel-only-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-sonar-de-nel-only-micro-fuzzy-all.tsv) for full details.

**EL only sonar German relaxed @1 (literal sense)** [`NEL-LIT-micro-fuzzy-relaxed-TIME-ALL-LED-ALL-@1`]

| Rank   | System                   | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:-------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team5_bundle5_sonar_de_1 | 0.517 | 0.616       | 0.446    | 210  | 131  | 261  |
| 2      | team5_bundle5_sonar_de_2 | 0.505 | 0.638       | 0.418    | 197  | 112  | 274  |

See [ranking-sonar-de-nel-only-micro-fuzzy-relaxed-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-sonar-de-nel-only-micro-fuzzy-relaxed-all.tsv) for full details.

### topres19th

**EL only topres19th English strict @1 (literal sense)** [`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`]

| Rank   | System                        | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:------------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team5_bundle5_topres19th_en_2 | 0.651 | 0.778       | 0.559    | 664  | 190  | 523  |
| 2      | team5_bundle5_topres19th_en_1 | 0.649 | 0.786       | 0.552    | 655  | 178  | 532  |

See [ranking-topres19th-en-nel-only-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-topres19th-en-nel-only-micro-fuzzy-all.tsv) for full details.

**EL only topres19th English relaxed @1 (literal sense)** [`NEL-LIT-micro-fuzzy-relaxed-TIME-ALL-LED-ALL-@1`]

| Rank   | System                        | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:------------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team5_bundle5_topres19th_en_2 | 0.654 | 0.781       | 0.562    | 667  | 187  | 520  |
| 2      | team5_bundle5_topres19th_en_1 | 0.650 | 0.789       | 0.553    | 657  | 176  | 530  |

See [ranking-topres19th-en-nel-only-micro-fuzzy-relaxed-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-topres19th-en-nel-only-micro-fuzzy-relaxed-all.tsv) for full details.

### ajmc

**EL only ajmc German strict @1 (literal sense)** [`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`]

| Rank   | System                  | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team5_bundle5_ajmc_de_2 | 0.503 | 0.712       | 0.389    | 74   | 30   | 116  |
| 2      | team5_bundle5_ajmc_de_1 | 0.471 | 0.608       | 0.384    | 73   | 47   | 117  |

See [ranking-ajmc-de-nel-only-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-de-nel-only-micro-fuzzy-all.tsv) for full details.

**EL only ajmc German relaxed @1 (literal sense)** [`NEL-LIT-micro-fuzzy-relaxed-TIME-ALL-LED-ALL-@1`]

| Rank   | System                  | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team5_bundle5_ajmc_de_2 | 0.503 | 0.712       | 0.389    | 74   | 30   | 116  |
| 2      | team5_bundle5_ajmc_de_1 | 0.471 | 0.608       | 0.384    | 73   | 47   | 117  |

See [ranking-ajmc-de-nel-only-micro-fuzzy-relaxed-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-de-nel-only-micro-fuzzy-relaxed-all.tsv) for full details.

**EL only ajmc English strict @1 (literal sense)** [`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`]

| Rank   | System                  | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team5_bundle5_ajmc_en_2 | 0.381 | 0.578       | 0.284    | 52   | 38   | 131  |
| 2      | team5_bundle5_ajmc_en_1 | 0.376 | 0.580       | 0.279    | 51   | 37   | 132  |

See [ranking-ajmc-en-nel-only-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-en-nel-only-micro-fuzzy-all.tsv) for full details.

**EL only ajmc English relaxed @1 (literal sense)** [`NEL-LIT-micro-fuzzy-relaxed-TIME-ALL-LED-ALL-@1`]

| Rank   | System                  | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team5_bundle5_ajmc_en_2 | 0.381 | 0.578       | 0.284    | 52   | 38   | 131  |
| 2      | team5_bundle5_ajmc_en_1 | 0.376 | 0.580       | 0.279    | 51   | 37   | 132  |

See [ranking-ajmc-en-nel-only-micro-fuzzy-relaxed-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-en-nel-only-micro-fuzzy-relaxed-all.tsv) for full details.

**EL only ajmc French strict @1 (literal sense)** [`NEL-LIT-micro-fuzzy-TIME-ALL-LED-ALL-@1`]

| Rank   | System                  | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team5_bundle5_ajmc_fr_1 | 0.470 | 0.621       | 0.378    | 82   | 50   | 135  |
| 2      | team5_bundle5_ajmc_fr_2 | 0.469 | 0.617       | 0.378    | 82   | 51   | 135  |

See [ranking-ajmc-fr-nel-only-micro-fuzzy-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-fr-nel-only-micro-fuzzy-all.tsv) for full details.

**EL only ajmc French relaxed @1 (literal sense)** [`NEL-LIT-micro-fuzzy-relaxed-TIME-ALL-LED-ALL-@1`]

| Rank   | System                  | F1    | Precision   | Recall   | TP   | FP   | FN   |
|:-------|:------------------------|:------|:------------|:---------|:-----|:-----|:-----|
| 1      | team5_bundle5_ajmc_fr_1 | 0.464 | 0.614       | 0.373    | 81   | 51   | 136  |
| 2      | team5_bundle5_ajmc_fr_2 | 0.463 | 0.609       | 0.373    | 81   | 52   | 136  |

See [ranking-ajmc-fr-nel-only-micro-fuzzy-relaxed-all.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/ranking-ajmc-fr-nel-only-micro-fuzzy-relaxed-all.tsv) for full details.
## HIPE 2022 Challenge Evaluation Results


<!--ts-->
   * [Multilingual Newspaper Challenge (MNC)](./ranking_challenge_summary.md#multilingual-newspaper-challenge-mnc)
      * [MNC: Overall ranking](./ranking_challenge_summary.md#mnc-overall-ranking)
      * [MNC: Ranking overview for nel-only-relaxed](./ranking_challenge_summary.md#mnc-ranking-overview-for-nel-only-relaxed)
      * [MNC: Detailed view for nel-only-relaxed](./ranking_challenge_summary.md#mnc-detailed-view-for-nel-only-relaxed)
      * [MNC: Ranking overview for nel-relaxed](./ranking_challenge_summary.md#mnc-ranking-overview-for-nel-relaxed)
      * [MNC: Detailed view for nel-relaxed](./ranking_challenge_summary.md#mnc-detailed-view-for-nel-relaxed)
      * [MNC: Ranking overview for nerc-coarse-fuzzy](./ranking_challenge_summary.md#mnc-ranking-overview-for-nerc-coarse-fuzzy)
      * [MNC: Detailed view for nerc-coarse-fuzzy](./ranking_challenge_summary.md#mnc-detailed-view-for-nerc-coarse-fuzzy)
   * [Multilingual Classical Commentary Challenge (MCC)](./ranking_challenge_summary.md#multilingual-classical-commentary-challenge-mcc)
      * [MCC: Overall ranking](./ranking_challenge_summary.md#mcc-overall-ranking)
      * [MCC: Ranking overview for nel-only-relaxed](./ranking_challenge_summary.md#mcc-ranking-overview-for-nel-only-relaxed)
      * [MCC: Detailed view for nel-only-relaxed](./ranking_challenge_summary.md#mcc-detailed-view-for-nel-only-relaxed)
      * [MCC: Ranking overview for nel-relaxed](./ranking_challenge_summary.md#mcc-ranking-overview-for-nel-relaxed)
      * [MCC: Detailed view for nel-relaxed](./ranking_challenge_summary.md#mcc-detailed-view-for-nel-relaxed)
      * [MCC: Ranking overview for nerc-coarse-fuzzy](./ranking_challenge_summary.md#mcc-ranking-overview-for-nerc-coarse-fuzzy)
      * [MCC: Detailed view for nerc-coarse-fuzzy](./ranking_challenge_summary.md#mcc-detailed-view-for-nerc-coarse-fuzzy)
   * [Global Adaptation Challenge (GAC)](./ranking_challenge_summary.md#global-adaptation-challenge-gac)
      * [GAC: Overall ranking](./ranking_challenge_summary.md#gac-overall-ranking)
      * [GAC: Ranking overview for nel-only-relaxed](./ranking_challenge_summary.md#gac-ranking-overview-for-nel-only-relaxed)
      * [GAC: Detailed view for nel-only-relaxed](./ranking_challenge_summary.md#gac-detailed-view-for-nel-only-relaxed)
      * [GAC: Ranking overview for nel-relaxed](./ranking_challenge_summary.md#gac-ranking-overview-for-nel-relaxed)
      * [GAC: Detailed view for nel-relaxed](./ranking_challenge_summary.md#gac-detailed-view-for-nel-relaxed)
      * [GAC: Ranking overview for nerc-coarse-fuzzy](./ranking_challenge_summary.md#gac-ranking-overview-for-nerc-coarse-fuzzy)
      * [GAC: Detailed view for nerc-coarse-fuzzy](./ranking_challenge_summary.md#gac-detailed-view-for-nerc-coarse-fuzzy)
      * [GAC: Ranking overview for nerc-fine+nested-fuzzy](./ranking_challenge_summary.md#gac-ranking-overview-for-nerc-finenested-fuzzy)
      * [GAC: Detailed view for nerc-fine+nested-fuzzy](./ranking_challenge_summary.md#gac-detailed-view-for-nerc-finenested-fuzzy)
<!--te-->


## Multilingual Newspaper Challenge (MNC)



### MNC: Overall ranking

|    | CHALLENGE   | RANK   | POINTS   | TEAM   |
|:---|:------------|:-------|:---------|:-------|
| 0  | MNC         | 1      | 460      | team4  |
| 1  | MNC         | 2      | 440      | team2  |
| 2  | MNC         | 3      | 330      | team5  |
| 3  | MNC         | 4      | 150      | team3  |

### MNC: Ranking overview for nel-only-relaxed 

|    | CHALLENGE   | RANK   | POINTS   | TEAM   |
|:---|:------------|:-------|:---------|:-------|
| 0  | MCC:EL-ONLY | 1      | 330      | team5  |
| 1  | MCC:EL-ONLY | 2      | 140      | team2  |

See [mnc-challenge-nel-only-relaxed-challenge-team-ranking.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/mnc-challenge-nel-only-relaxed-challenge-team-ranking.tsv) for full details.

### MNC: Detailed view for nel-only-relaxed 

|    | CHALLENGE   | RANK   | POINTS   | TEAM   | DATASET    | LANGUAGE   | F1    | System                        |
|:---|:------------|:-------|:---------|:-------|:-----------|:-----------|:------|:------------------------------|
| 0  | MCC:EL-ONLY | 1      | 50       | team5  | hipe2020   | de         | 0.525 | team5_bundle5_hipe2020_de_1   |
| 1  | MCC:EL-ONLY | 2      | 40       | team2  | hipe2020   | de         | 0.497 | team2_bundle5_hipe2020_de_1   |
| 2  | MCC:EL-ONLY | 1      | 50       | team2  | hipe2020   | en         | 0.546 | team2_bundle5_hipe2020_en_1   |
| 3  | MCC:EL-ONLY | 2      | 40       | team5  | hipe2020   | en         | 0.393 | team5_bundle5_hipe2020_en_2   |
| 4  | MCC:EL-ONLY | 1      | 50       | team2  | hipe2020   | fr         | 0.620 | team2_bundle5_hipe2020_fr_1   |
| 5  | MCC:EL-ONLY | 2      | 40       | team5  | hipe2020   | fr         | 0.616 | team5_bundle5_hipe2020_fr_2   |
| 6  | MCC:EL-ONLY | 1      | 50       | team5  | newseye    | de         | 0.455 | team5_bundle5_newseye_de_1    |
| 7  | MCC:EL-ONLY | 1      | 50       | team5  | newseye    | fr         | 0.435 | team5_bundle5_newseye_fr_1    |
| 8  | MCC:EL-ONLY | 1      | 50       | team5  | sonar      | de         | 0.517 | team5_bundle5_sonar_de_1      |
| 9  | MCC:EL-ONLY | 1      | 50       | team5  | topres19th | en         | 0.654 | team5_bundle5_topres19th_en_2 |

See [mnc-challenge-nel-only-relaxed-dataset-team-ranking.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/mnc-challenge-nel-only-relaxed-dataset-team-ranking.tsv) for full details.

### MNC: Ranking overview for nel-relaxed 

|    | CHALLENGE   | RANK   | POINTS   | TEAM   |
|:---|:------------|:-------|:---------|:-------|
| 0  | MNC:EL      | 1      | 150      | team2  |

See [mnc-challenge-nel-relaxed-challenge-team-ranking.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/mnc-challenge-nel-relaxed-challenge-team-ranking.tsv) for full details.

### MNC: Detailed view for nel-relaxed 

|    | CHALLENGE   | RANK   | POINTS   | TEAM   | DATASET   | LANGUAGE   | F1    | System                      |
|:---|:------------|:-------|:---------|:-------|:----------|:-----------|:------|:----------------------------|
| 0  | MNC:EL      | 1      | 50       | team2  | hipe2020  | de         | 0.464 | team2_bundle1_hipe2020_de_2 |
| 1  | MNC:EL      | 1      | 50       | team2  | hipe2020  | en         | 0.469 | team2_bundle1_hipe2020_en_2 |
| 2  | MNC:EL      | 1      | 50       | team2  | hipe2020  | fr         | 0.578 | team2_bundle1_hipe2020_fr_1 |

See [mnc-challenge-nel-relaxed-dataset-team-ranking.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/mnc-challenge-nel-relaxed-dataset-team-ranking.tsv) for full details.

### MNC: Ranking overview for nerc-coarse-fuzzy 

|    | CHALLENGE       | RANK   | POINTS   | TEAM   |
|:---|:----------------|:-------|:---------|:-------|
| 0  | MNC:NERC-COARSE | 1      | 460      | team4  |
| 1  | MNC:NERC-COARSE | 2      | 150      | team2  |
| 2  | MNC:NERC-COARSE | 3      | 150      | team3  |

See [mnc-challenge-nerc-coarse-fuzzy-challenge-team-ranking.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/mnc-challenge-nerc-coarse-fuzzy-challenge-team-ranking.tsv) for full details.

### MNC: Detailed view for nerc-coarse-fuzzy 

|    | CHALLENGE       | RANK   | POINTS   | TEAM   | DATASET    | LANGUAGE   | F1    | System                        |
|:---|:----------------|:-------|:---------|:-------|:-----------|:-----------|:------|:------------------------------|
| 0  | MNC:NERC-COARSE | 1      | 50       | team2  | hipe2020   | de         | 0.876 | team2_bundle3_hipe2020_de_1   |
| 1  | MNC:NERC-COARSE | 2      | 40       | team4  | hipe2020   | de         | 0.822 | team4_bundle4_hipe2020_de_1   |
| 2  | MNC:NERC-COARSE | 1      | 50       | team2  | hipe2020   | en         | 0.788 | team2_bundle1_hipe2020_en_1   |
| 3  | MNC:NERC-COARSE | 2      | 40       | team4  | hipe2020   | en         | 0.692 | team4_bundle4_hipe2020_en_1   |
| 4  | MNC:NERC-COARSE | 3      | 30       | team3  | hipe2020   | en         | 0.603 | team3_bundle4_hipe2020_en_1   |
| 5  | MNC:NERC-COARSE | 1      | 50       | team2  | hipe2020   | fr         | 0.907 | team2_bundle1_hipe2020_fr_2   |
| 6  | MNC:NERC-COARSE | 2      | 40       | team3  | hipe2020   | fr         | 0.808 | team3_bundle4_hipe2020_fr_1   |
| 7  | MNC:NERC-COARSE | 3      | 30       | team4  | hipe2020   | fr         | 0.800 | team4_bundle4_hipe2020_fr_2   |
| 8  | MNC:NERC-COARSE | 1      | 50       | team4  | letemps    | fr         | 0.701 | team4_bundle4_letemps_fr_1    |
| 9  | MNC:NERC-COARSE | 2      | 40       | team3  | letemps    | fr         | 0.666 | team3_bundle4_letemps_fr_1    |
| 10 | MNC:NERC-COARSE | 1      | 50       | team4  | newseye    | de         | 0.495 | team4_bundle4_newseye_de_2    |
| 11 | MNC:NERC-COARSE | 1      | 50       | team4  | newseye    | fi         | 0.670 | team4_bundle4_newseye_fi_1    |
| 12 | MNC:NERC-COARSE | 1      | 50       | team4  | newseye    | fr         | 0.786 | team4_bundle4_newseye_fr_2    |
| 13 | MNC:NERC-COARSE | 1      | 50       | team4  | newseye    | sv         | 0.746 | team4_bundle4_newseye_sv_1    |
| 14 | MNC:NERC-COARSE | 1      | 50       | team4  | sonar      | de         | 0.695 | team4_bundle4_sonar_de_2      |
| 15 | MNC:NERC-COARSE | 1      | 50       | team4  | topres19th | en         | 0.838 | team4_bundle4_topres19th_en_1 |
| 16 | MNC:NERC-COARSE | 2      | 40       | team3  | topres19th | en         | 0.796 | team3_bundle4_topres19th_en_1 |

See [mnc-challenge-nerc-coarse-fuzzy-dataset-team-ranking.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/mnc-challenge-nerc-coarse-fuzzy-dataset-team-ranking.tsv) for full details.

## Multilingual Classical Commentary Challenge (MCC)



### MCC: Overall ranking

|    | CHALLENGE   | RANK   | POINTS   | TEAM   |
|:---|:------------|:-------|:---------|:-------|
| 0  | MCC         | 1      | 180      | team2  |
| 1  | MCC         | 2      | 150      | team5  |
| 2  | MCC         | 3      | 140      | team1  |

### MCC: Ranking overview for nel-only-relaxed 

|    | CHALLENGE   | RANK   | POINTS   | TEAM   |
|:---|:------------|:-------|:---------|:-------|
| 0  | MCC:EL-ONLY | 1      | 150      | team5  |

See [mcc-challenge-nel-only-relaxed-challenge-team-ranking.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/mcc-challenge-nel-only-relaxed-challenge-team-ranking.tsv) for full details.

### MCC: Detailed view for nel-only-relaxed 

|    | CHALLENGE   | RANK   | POINTS   | TEAM   | DATASET   | LANGUAGE   | F1    | System                  |
|:---|:------------|:-------|:---------|:-------|:----------|:-----------|:------|:------------------------|
| 0  | MCC:EL-ONLY | 1      | 50       | team5  | ajmc      | de         | 0.503 | team5_bundle5_ajmc_de_2 |
| 1  | MCC:EL-ONLY | 1      | 50       | team5  | ajmc      | en         | 0.381 | team5_bundle5_ajmc_en_2 |
| 2  | MCC:EL-ONLY | 1      | 50       | team5  | ajmc      | fr         | 0.464 | team5_bundle5_ajmc_fr_1 |

See [mcc-challenge-nel-only-relaxed-dataset-team-ranking.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/mcc-challenge-nel-only-relaxed-dataset-team-ranking.tsv) for full details.

### MCC: Ranking overview for nel-relaxed 

|    | CHALLENGE   | RANK   | POINTS   | TEAM   |
|:---|:------------|:-------|:---------|:-------|
| 0  | MCC:EL      | 1      | 50       | team2  |

See [mcc-challenge-nel-relaxed-challenge-team-ranking.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/mcc-challenge-nel-relaxed-challenge-team-ranking.tsv) for full details.

### MCC: Detailed view for nel-relaxed 

|    | CHALLENGE   | RANK   | POINTS   | TEAM   | DATASET   | LANGUAGE   | F1    | System                  |
|:---|:------------|:-------|:---------|:-------|:----------|:-----------|:------|:------------------------|
| 0  | MCC:EL      | 1      | 50       | team2  | ajmc      | en         | 0.030 | team2_bundle1_ajmc_en_2 |

See [mcc-challenge-nel-relaxed-dataset-team-ranking.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/mcc-challenge-nel-relaxed-dataset-team-ranking.tsv) for full details.

### MCC: Ranking overview for nerc-coarse-fuzzy 

|    | CHALLENGE       | RANK   | POINTS   | TEAM   |
|:---|:----------------|:-------|:---------|:-------|
| 0  | MCC:NERC-COARSE | 1      | 140      | team1  |
| 1  | MCC:NERC-COARSE | 2      | 130      | team2  |

See [mcc-challenge-nerc-coarse-fuzzy-challenge-team-ranking.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/mcc-challenge-nerc-coarse-fuzzy-challenge-team-ranking.tsv) for full details.

### MCC: Detailed view for nerc-coarse-fuzzy 

|    | CHALLENGE       | RANK   | POINTS   | TEAM   | DATASET   | LANGUAGE   | F1    | System                  |
|:---|:----------------|:-------|:---------|:-------|:----------|:-----------|:------|:------------------------|
| 0  | MCC:NERC-COARSE | 1      | 50       | team2  | ajmc      | de         | 0.952 | team2_bundle3_ajmc_de_2 |
| 1  | MCC:NERC-COARSE | 2      | 40       | team1  | ajmc      | de         | 0.945 | team1_bundle4_ajmc_de_2 |
| 2  | MCC:NERC-COARSE | 1      | 50       | team1  | ajmc      | en         | 0.910 | team1_bundle4_ajmc_en_2 |
| 3  | MCC:NERC-COARSE | 2      | 40       | team2  | ajmc      | en         | 0.894 | team2_bundle1_ajmc_en_1 |
| 4  | MCC:NERC-COARSE | 1      | 50       | team1  | ajmc      | fr         | 0.888 | team1_bundle4_ajmc_fr_1 |
| 5  | MCC:NERC-COARSE | 2      | 40       | team2  | ajmc      | fr         | 0.872 | team2_bundle3_ajmc_fr_2 |

See [mcc-challenge-nerc-coarse-fuzzy-dataset-team-ranking.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/mcc-challenge-nerc-coarse-fuzzy-dataset-team-ranking.tsv) for full details.

## Global Adaptation Challenge (GAC)



### GAC: Overall ranking

|    | CHALLENGE   | RANK   | POINTS   | TEAM   |
|:---|:------------|:-------|:---------|:-------|
| 0  | GAC         | 1      | 890      | team2  |
| 1  | GAC         | 2      | 480      | team5  |

### GAC: Ranking overview for nel-only-relaxed 

|    | CHALLENGE   | RANK   | POINTS   | TEAM   |
|:---|:------------|:-------|:---------|:-------|
| 0  | GAC:EL-ONLY | 1      | 480      | team5  |
| 1  | GAC:EL-ONLY | 2      | 140      | team2  |

See [gac-challenge-nel-only-relaxed-challenge-team-ranking.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/gac-challenge-nel-only-relaxed-challenge-team-ranking.tsv) for full details.

### GAC: Detailed view for nel-only-relaxed 

|    | CHALLENGE   | RANK   | POINTS   | TEAM   | DATASET    | LANGUAGE   | F1    | System                        |
|:---|:------------|:-------|:---------|:-------|:-----------|:-----------|:------|:------------------------------|
| 0  | GAC:EL-ONLY | 1      | 50       | team5  | ajmc       | de         | 0.503 | team5_bundle5_ajmc_de_2       |
| 1  | GAC:EL-ONLY | 1      | 50       | team5  | ajmc       | en         | 0.381 | team5_bundle5_ajmc_en_2       |
| 2  | GAC:EL-ONLY | 1      | 50       | team5  | ajmc       | fr         | 0.464 | team5_bundle5_ajmc_fr_1       |
| 3  | GAC:EL-ONLY | 1      | 50       | team5  | hipe2020   | de         | 0.525 | team5_bundle5_hipe2020_de_1   |
| 4  | GAC:EL-ONLY | 2      | 40       | team2  | hipe2020   | de         | 0.497 | team2_bundle5_hipe2020_de_1   |
| 5  | GAC:EL-ONLY | 1      | 50       | team2  | hipe2020   | en         | 0.546 | team2_bundle5_hipe2020_en_1   |
| 6  | GAC:EL-ONLY | 2      | 40       | team5  | hipe2020   | en         | 0.393 | team5_bundle5_hipe2020_en_2   |
| 7  | GAC:EL-ONLY | 1      | 50       | team2  | hipe2020   | fr         | 0.620 | team2_bundle5_hipe2020_fr_1   |
| 8  | GAC:EL-ONLY | 2      | 40       | team5  | hipe2020   | fr         | 0.616 | team5_bundle5_hipe2020_fr_2   |
| 9  | GAC:EL-ONLY | 1      | 50       | team5  | newseye    | de         | 0.455 | team5_bundle5_newseye_de_1    |
| 10 | GAC:EL-ONLY | 1      | 50       | team5  | newseye    | fr         | 0.435 | team5_bundle5_newseye_fr_1    |
| 11 | GAC:EL-ONLY | 1      | 50       | team5  | sonar      | de         | 0.517 | team5_bundle5_sonar_de_1      |
| 12 | GAC:EL-ONLY | 1      | 50       | team5  | topres19th | en         | 0.654 | team5_bundle5_topres19th_en_2 |

See [gac-challenge-nel-only-relaxed-dataset-team-ranking.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/gac-challenge-nel-only-relaxed-dataset-team-ranking.tsv) for full details.

### GAC: Ranking overview for nel-relaxed 

|    | CHALLENGE   | RANK   | POINTS   | TEAM   |
|:---|:------------|:-------|:---------|:-------|
| 0  | GAC:EL      | 1      | 200      | team2  |

See [gac-challenge-nel-relaxed-challenge-team-ranking.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/gac-challenge-nel-relaxed-challenge-team-ranking.tsv) for full details.

### GAC: Detailed view for nel-relaxed 

|    | CHALLENGE   | RANK   | POINTS   | TEAM   | DATASET   | LANGUAGE   | F1    | System                      |
|:---|:------------|:-------|:---------|:-------|:----------|:-----------|:------|:----------------------------|
| 0  | GAC:EL      | 1      | 50       | team2  | ajmc      | en         | 0.030 | team2_bundle1_ajmc_en_2     |
| 1  | GAC:EL      | 1      | 50       | team2  | hipe2020  | de         | 0.464 | team2_bundle1_hipe2020_de_2 |
| 2  | GAC:EL      | 1      | 50       | team2  | hipe2020  | en         | 0.469 | team2_bundle1_hipe2020_en_2 |
| 3  | GAC:EL      | 1      | 50       | team2  | hipe2020  | fr         | 0.578 | team2_bundle1_hipe2020_fr_1 |

See [gac-challenge-nel-relaxed-dataset-team-ranking.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/gac-challenge-nel-relaxed-dataset-team-ranking.tsv) for full details.

### GAC: Ranking overview for nerc-coarse-fuzzy 

|    | CHALLENGE       | RANK   | POINTS   | TEAM   |
|:---|:----------------|:-------|:---------|:-------|
| 0  | GAC:NERC-COARSE | 1      | 300      | team2  |

See [gac-challenge-nerc-coarse-fuzzy-challenge-team-ranking.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/gac-challenge-nerc-coarse-fuzzy-challenge-team-ranking.tsv) for full details.

### GAC: Detailed view for nerc-coarse-fuzzy 

|    | CHALLENGE       | RANK   | POINTS   | TEAM   | DATASET   | LANGUAGE   | F1    | System                      |
|:---|:----------------|:-------|:---------|:-------|:----------|:-----------|:------|:----------------------------|
| 0  | GAC:NERC-COARSE | 1      | 50       | team2  | ajmc      | de         | 0.952 | team2_bundle3_ajmc_de_2     |
| 1  | GAC:NERC-COARSE | 1      | 50       | team2  | ajmc      | en         | 0.894 | team2_bundle1_ajmc_en_1     |
| 2  | GAC:NERC-COARSE | 1      | 50       | team2  | ajmc      | fr         | 0.872 | team2_bundle3_ajmc_fr_2     |
| 3  | GAC:NERC-COARSE | 1      | 50       | team2  | hipe2020  | de         | 0.876 | team2_bundle3_hipe2020_de_1 |
| 4  | GAC:NERC-COARSE | 1      | 50       | team2  | hipe2020  | en         | 0.788 | team2_bundle1_hipe2020_en_1 |
| 5  | GAC:NERC-COARSE | 1      | 50       | team2  | hipe2020  | fr         | 0.907 | team2_bundle1_hipe2020_fr_2 |

See [gac-challenge-nerc-coarse-fuzzy-dataset-team-ranking.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/gac-challenge-nerc-coarse-fuzzy-dataset-team-ranking.tsv) for full details.

### GAC: Ranking overview for nerc-fine+nested-fuzzy 

|    | CHALLENGE            | RANK   | POINTS   | TEAM   |
|:---|:---------------------|:-------|:---------|:-------|
| 0  | GAC:NERC-FINE+NESTED | 1      | 250      | team2  |

See [gac-challenge-nerc-fine+nested-fuzzy-challenge-team-ranking.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/gac-challenge-nerc-fine+nested-fuzzy-challenge-team-ranking.tsv) for full details.

### GAC: Detailed view for nerc-fine+nested-fuzzy 

|    | CHALLENGE            | RANK   | POINTS   | TEAM   | DATASET   | LANGUAGE   | F1    | System                      |
|:---|:---------------------|:-------|:---------|:-------|:----------|:-----------|:------|:----------------------------|
| 0  | GAC:NERC-FINE+NESTED | 1      | 50       | team2  | ajmc      | de         | 0.933 | team2_bundle3_ajmc_de_2     |
| 1  | GAC:NERC-FINE+NESTED | 1      | 50       | team2  | ajmc      | en         | 0.847 | team2_bundle1_ajmc_en_1     |
| 2  | GAC:NERC-FINE+NESTED | 1      | 50       | team2  | ajmc      | fr         | 0.728 | team2_bundle3_ajmc_fr_2     |
| 3  | GAC:NERC-FINE+NESTED | 1      | 50       | team2  | hipe2020  | de         | 0.673 | team2_bundle3_hipe2020_de_1 |
| 4  | GAC:NERC-FINE+NESTED | 1      | 50       | team2  | hipe2020  | fr         | 0.614 | team2_bundle1_hipe2020_fr_2 |

See [gac-challenge-nerc-fine+nested-fuzzy-dataset-team-ranking.tsv](https://github.com/hipe-eval/HIPE-2022-eval/blob/master/evaluation/system-rankings/gac-challenge-nerc-fine+nested-fuzzy-dataset-team-ranking.tsv) for full details.
