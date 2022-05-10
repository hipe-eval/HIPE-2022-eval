# CLEF HIPE 2022 preliminary results

We provide an **overview table** of the **PRELIMINARY** anonymized results of the runs submitted by the teams for the **first** phase. 
It also includes a neural baseline created by the organizers.

- Date: 04.05.2022.
- Bundles: 1 to 4
- The current results for NEL can still change as we are extending the list of equivalent wikidata IDs. 
- Detailed results for all systems can be found in this .tsv file.
- Detailed results for each team's runs are sent privately.
- System name composition is: teamID_bundle_dataset_lang_run.
- F1 scores of 0.0 are excluded from the table.
- Results are ordered by F1 scores.
- Results will be de-anonymized in the future.

### About the evaluation (reminder)

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


## NERC coarse

Relevant bundles: 1-4

### NERC coarse hipe2020 German strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                        | F1    | Precision   | Recall   |
|:-------|:------------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_hipe2020_de_1   | 0.802 | 0.795       | 0.808    |
| 2      | team2_bundle1_hipe2020_de_2   | 0.793 | 0.794       | 0.793    |
| 3      | team2_bundle2_hipe2020_de_2   | 0.793 | 0.794       | 0.793    |
| 4      | team2_bundle3_hipe2020_de_2   | 0.793 | 0.794       | 0.793    |
| 5      | team2_bundle1_hipe2020_de_1   | 0.781 | 0.768       | 0.794    |
| 6      | team2_bundle2_hipe2020_de_1   | 0.781 | 0.768       | 0.794    |
| 7      | team4_bundle4_hipe2020_de_1   | 0.725 | 0.716       | 0.735    |
| 8      | neurbsl_bundle3_hipe2020_de_1 | 0.703 | 0.665       | 0.746    |
| 9      | team4_bundle4_hipe2020_de_2   | 0.695 | 0.677       | 0.714    |

### NERC coarse hipe2020 German fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                        | F1    | Precision   | Recall   |
|:-------|:------------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_hipe2020_de_1   | 0.879 | 0.871       | 0.886    |
| 2      | team2_bundle1_hipe2020_de_2   | 0.878 | 0.879       | 0.877    |
| 3      | team2_bundle2_hipe2020_de_2   | 0.878 | 0.879       | 0.877    |
| 4      | team2_bundle3_hipe2020_de_2   | 0.878 | 0.879       | 0.877    |
| 5      | team2_bundle1_hipe2020_de_1   | 0.874 | 0.860       | 0.889    |
| 6      | team2_bundle2_hipe2020_de_1   | 0.874 | 0.860       | 0.889    |
| 7      | team4_bundle4_hipe2020_de_1   | 0.822 | 0.812       | 0.833    |
| 8      | team4_bundle4_hipe2020_de_2   | 0.804 | 0.783       | 0.826    |
| 9      | neurbsl_bundle3_hipe2020_de_1 | 0.793 | 0.750       | 0.842    |

### NERC coarse hipe2020 English strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                        | F1    | Precision   | Recall   |
|:-------|:------------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_hipe2020_en_1   | 0.620 | 0.624       | 0.617    |
| 2      | team2_bundle2_hipe2020_en_1   | 0.620 | 0.624       | 0.617    |
| 3      | team2_bundle1_hipe2020_en_2   | 0.615 | 0.609       | 0.621    |
| 4      | team2_bundle2_hipe2020_en_2   | 0.615 | 0.609       | 0.621    |
| 5      | team2_bundle3_hipe2020_en_1   | 0.615 | 0.609       | 0.621    |
| 6      | team4_bundle4_hipe2020_en_1   | 0.513 | 0.538       | 0.490    |
| 7      | neurbsl_bundle3_hipe2020_en_1 | 0.477 | 0.432       | 0.532    |
| 8      | team3_bundle4_hipe2020_en_1   | 0.414 | 0.400       | 0.430    |

### NERC coarse hipe2020 English fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                        | F1    | Precision   | Recall   |
|:-------|:------------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_hipe2020_en_1   | 0.788 | 0.793       | 0.784    |
| 2      | team2_bundle2_hipe2020_en_1   | 0.788 | 0.793       | 0.784    |
| 3      | team2_bundle1_hipe2020_en_2   | 0.783 | 0.775       | 0.791    |
| 4      | team2_bundle2_hipe2020_en_2   | 0.783 | 0.775       | 0.791    |
| 5      | team2_bundle3_hipe2020_en_1   | 0.783 | 0.775       | 0.791    |
| 6      | team4_bundle4_hipe2020_en_1   | 0.692 | 0.726       | 0.661    |
| 7      | neurbsl_bundle3_hipe2020_en_1 | 0.623 | 0.564       | 0.695    |
| 8      | team3_bundle4_hipe2020_en_1   | 0.603 | 0.582       | 0.626    |

### NERC coarse hipe2020 French strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                        | F1    | Precision   | Recall   |
|:-------|:------------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_hipe2020_fr_1   | 0.818 | 0.801       | 0.836    |
| 2      | team2_bundle2_hipe2020_fr_1   | 0.818 | 0.801       | 0.836    |
| 3      | team2_bundle1_hipe2020_fr_2   | 0.814 | 0.797       | 0.832    |
| 4      | team2_bundle2_hipe2020_fr_2   | 0.814 | 0.797       | 0.832    |
| 5      | team2_bundle3_hipe2020_fr_1   | 0.808 | 0.789       | 0.828    |
| 6      | neurbsl_bundle3_hipe2020_fr_1 | 0.757 | 0.730       | 0.785    |
| 7      | team4_bundle4_hipe2020_fr_2   | 0.696 | 0.718       | 0.675    |
| 8      | team4_bundle4_hipe2020_fr_1   | 0.678 | 0.700       | 0.657    |
| 9      | team3_bundle4_hipe2020_fr_1   | 0.674 | 0.640       | 0.712    |

### NERC coarse hipe2020 French fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                        | F1    | Precision   | Recall   |
|:-------|:------------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_hipe2020_fr_2   | 0.912 | 0.892       | 0.932    |
| 2      | team2_bundle2_hipe2020_fr_2   | 0.912 | 0.892       | 0.932    |
| 3      | team2_bundle1_hipe2020_fr_1   | 0.909 | 0.890       | 0.928    |
| 4      | team2_bundle2_hipe2020_fr_1   | 0.909 | 0.890       | 0.928    |
| 5      | team2_bundle3_hipe2020_fr_1   | 0.905 | 0.884       | 0.927    |
| 6      | neurbsl_bundle3_hipe2020_fr_1 | 0.866 | 0.836       | 0.899    |
| 7      | team3_bundle4_hipe2020_fr_1   | 0.808 | 0.767       | 0.853    |
| 8      | team4_bundle4_hipe2020_fr_2   | 0.800 | 0.825       | 0.776    |
| 9      | team4_bundle4_hipe2020_fr_1   | 0.798 | 0.824       | 0.773    |

### NERC coarse newseye German strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_newseye_de_1 | 0.477 | 0.429       | 0.537    |
| 2      | team4_bundle4_newseye_de_2   | 0.408 | 0.395       | 0.421    |
| 3      | team4_bundle4_newseye_de_1   | 0.395 | 0.396       | 0.394    |

### NERC coarse newseye German fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_newseye_de_1 | 0.570 | 0.512       | 0.642    |
| 2      | team4_bundle4_newseye_de_2   | 0.495 | 0.480       | 0.512    |
| 3      | team4_bundle4_newseye_de_1   | 0.479 | 0.481       | 0.478    |

### NERC coarse newseye French strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | team4_bundle4_newseye_fr_2   | 0.656 | 0.655       | 0.657    |
| 2      | neurbsl_bundle3_newseye_fr_1 | 0.654 | 0.634       | 0.676    |
| 3      | team4_bundle4_newseye_fr_1   | 0.648 | 0.673       | 0.625    |

### NERC coarse newseye French fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | team4_bundle4_newseye_fr_2   | 0.786 | 0.785       | 0.787    |
| 2      | neurbsl_bundle3_newseye_fr_1 | 0.779 | 0.755       | 0.805    |
| 3      | team4_bundle4_newseye_fr_1   | 0.772 | 0.801       | 0.744    |

### NERC coarse newseye Swedish strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_newseye_sv_1 | 0.651 | 0.588       | 0.728    |
| 2      | team4_bundle4_newseye_sv_1   | 0.643 | 0.686       | 0.604    |
| 3      | team4_bundle4_newseye_sv_2   | 0.636 | 0.673       | 0.603    |

### NERC coarse newseye Swedish fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_newseye_sv_1 | 0.747 | 0.675       | 0.836    |
| 2      | team4_bundle4_newseye_sv_1   | 0.746 | 0.797       | 0.702    |
| 3      | team4_bundle4_newseye_sv_2   | 0.742 | 0.786       | 0.704    |

### NERC coarse newseye Finnish strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_newseye_fi_1 | 0.644 | 0.605       | 0.687    |
| 2      | team4_bundle4_newseye_fi_1   | 0.567 | 0.618       | 0.524    |
| 3      | team4_bundle4_newseye_fi_2   | 0.556 | 0.592       | 0.524    |

### NERC coarse newseye Finnish fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_newseye_fi_1 | 0.760 | 0.715       | 0.812    |
| 2      | team4_bundle4_newseye_fi_1   | 0.670 | 0.730       | 0.619    |
| 3      | team4_bundle4_newseye_fi_2   | 0.640 | 0.681       | 0.603    |

### NERC coarse letemps French strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_letemps_fr_1 | 0.661 | 0.595       | 0.744    |
| 2      | team4_bundle4_letemps_fr_1   | 0.644 | 0.589       | 0.710    |
| 3      | team4_bundle4_letemps_fr_2   | 0.622 | 0.557       | 0.704    |
| 4      | team3_bundle4_letemps_fr_1   | 0.618 | 0.581       | 0.659    |

### NERC coarse letemps French fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_letemps_fr_1 | 0.711 | 0.639       | 0.800    |
| 2      | team4_bundle4_letemps_fr_1   | 0.701 | 0.642       | 0.773    |
| 3      | team4_bundle4_letemps_fr_2   | 0.681 | 0.610       | 0.771    |
| 4      | team3_bundle4_letemps_fr_1   | 0.666 | 0.627       | 0.711    |

### NERC coarse sonar German strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                     | F1    | Precision   | Recall   |
|:-------|:---------------------------|:------|:------------|:---------|
| 1      | team4_bundle4_sonar_de_1   | 0.490 | 0.470       | 0.511    |
| 2      | team4_bundle4_sonar_de_2   | 0.477 | 0.447       | 0.513    |
| 3      | neurbsl_bundle3_sonar_de_1 | 0.314 | 0.272       | 0.373    |

### NERC coarse sonar German fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                     | F1    | Precision   | Recall   |
|:-------|:---------------------------|:------|:------------|:---------|
| 1      | team4_bundle4_sonar_de_2   | 0.668 | 0.625       | 0.718    |
| 2      | team4_bundle4_sonar_de_1   | 0.667 | 0.641       | 0.696    |
| 3      | neurbsl_bundle3_sonar_de_1 | 0.467 | 0.403       | 0.554    |

### NERC coarse topres19th English strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                          | F1    | Precision   | Recall   |
|:-------|:--------------------------------|:------|:------------|:---------|
| 1      | team4_bundle4_topres19th_en_1   | 0.787 | 0.816       | 0.760    |
| 2      | team4_bundle4_topres19th_en_2   | 0.781 | 0.761       | 0.802    |
| 3      | neurbsl_bundle3_topres19th_en_1 | 0.764 | 0.747       | 0.782    |
| 4      | team3_bundle4_topres19th_en_1   | 0.740 | 0.712       | 0.771    |

### NERC coarse topres19th English fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                          | F1    | Precision   | Recall   |
|:-------|:--------------------------------|:------|:------------|:---------|
| 1      | team4_bundle4_topres19th_en_1   | 0.838 | 0.869       | 0.810    |
| 2      | team4_bundle4_topres19th_en_2   | 0.829 | 0.807       | 0.851    |
| 3      | neurbsl_bundle3_topres19th_en_1 | 0.816 | 0.798       | 0.836    |
| 4      | team3_bundle4_topres19th_en_1   | 0.796 | 0.765       | 0.829    |

### NERC coarse ajmc German strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_ajmc_de_2   | 0.934 | 0.946       | 0.921    |
| 2      | team2_bundle4_ajmc_de_2   | 0.934 | 0.946       | 0.921    |
| 3      | team1_bundle4_ajmc_de_1   | 0.913 | 0.930       | 0.898    |
| 4      | team1_bundle4_ajmc_de_2   | 0.912 | 0.905       | 0.919    |
| 5      | team2_bundle3_ajmc_de_1   | 0.908 | 0.913       | 0.903    |
| 6      | team2_bundle4_ajmc_de_1   | 0.908 | 0.913       | 0.903    |
| 7      | neurbsl_bundle3_ajmc_de_1 | 0.818 | 0.792       | 0.846    |

### NERC coarse ajmc German fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_ajmc_de_2   | 0.952 | 0.965       | 0.940    |
| 2      | team2_bundle4_ajmc_de_2   | 0.952 | 0.965       | 0.940    |
| 3      | team1_bundle4_ajmc_de_2   | 0.945 | 0.938       | 0.953    |
| 4      | team1_bundle4_ajmc_de_1   | 0.937 | 0.954       | 0.921    |
| 5      | team2_bundle3_ajmc_de_1   | 0.934 | 0.939       | 0.929    |
| 6      | team2_bundle4_ajmc_de_1   | 0.934 | 0.939       | 0.929    |
| 7      | neurbsl_bundle3_ajmc_de_1 | 0.873 | 0.846       | 0.903    |

### NERC coarse ajmc English strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team1_bundle4_ajmc_en_2   | 0.854 | 0.826       | 0.885    |
| 2      | team2_bundle1_ajmc_en_1   | 0.851 | 0.827       | 0.876    |
| 3      | team2_bundle1_ajmc_en_2   | 0.841 | 0.831       | 0.851    |
| 4      | team1_bundle4_ajmc_en_1   | 0.819 | 0.783       | 0.859    |
| 5      | neurbsl_bundle3_ajmc_en_1 | 0.736 | 0.680       | 0.802    |

### NERC coarse ajmc English fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team1_bundle4_ajmc_en_2   | 0.910 | 0.879       | 0.943    |
| 2      | team1_bundle4_ajmc_en_1   | 0.899 | 0.859       | 0.943    |
| 3      | team2_bundle1_ajmc_en_1   | 0.895 | 0.870       | 0.922    |
| 4      | team2_bundle1_ajmc_en_2   | 0.884 | 0.874       | 0.894    |
| 5      | neurbsl_bundle3_ajmc_en_1 | 0.828 | 0.766       | 0.902    |

### NERC coarse ajmc French strict (literal sense) \[`NE-COARSE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team1_bundle4_ajmc_fr_2   | 0.842 | 0.834       | 0.850    |
| 2      | team2_bundle3_ajmc_fr_2   | 0.834 | 0.824       | 0.844    |
| 3      | team2_bundle4_ajmc_fr_2   | 0.834 | 0.824       | 0.844    |
| 4      | team1_bundle4_ajmc_fr_1   | 0.833 | 0.820       | 0.847    |
| 5      | team2_bundle3_ajmc_fr_1   | 0.814 | 0.801       | 0.828    |
| 6      | team2_bundle4_ajmc_fr_1   | 0.814 | 0.801       | 0.828    |
| 7      | neurbsl_bundle3_ajmc_fr_1 | 0.741 | 0.707       | 0.778    |

### NERC coarse ajmc French fuzzy (literal sense) \[`NE-COARSE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team1_bundle4_ajmc_fr_1   | 0.888 | 0.874       | 0.903    |
| 2      | team1_bundle4_ajmc_fr_2   | 0.880 | 0.872       | 0.889    |
| 3      | team2_bundle3_ajmc_fr_2   | 0.878 | 0.867       | 0.889    |
| 4      | team2_bundle4_ajmc_fr_2   | 0.878 | 0.867       | 0.889    |
| 5      | team2_bundle3_ajmc_fr_1   | 0.866 | 0.852       | 0.881    |
| 6      | team2_bundle4_ajmc_fr_1   | 0.866 | 0.852       | 0.881    |
| 7      | neurbsl_bundle3_ajmc_fr_1 | 0.825 | 0.788       | 0.867    |

## NERC fine

Relevant bundles: 1, 3

### NERC fine hipe2020 German strict (literal sense) \[`NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                        | F1    | Precision   | Recall   |
|:-------|:------------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_hipe2020_de_1   | 0.718 | 0.691       | 0.747    |
| 2      | team2_bundle1_hipe2020_de_1   | 0.689 | 0.658       | 0.724    |
| 3      | team2_bundle1_hipe2020_de_2   | 0.682 | 0.657       | 0.710    |
| 4      | team2_bundle3_hipe2020_de_2   | 0.682 | 0.657       | 0.710    |
| 5      | neurbsl_bundle3_hipe2020_de_1 | 0.625 | 0.584       | 0.673    |

### NERC fine hipe2020 German fuzzy (literal sense) \[`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                        | F1    | Precision   | Recall   |
|:-------|:------------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_hipe2020_de_1   | 0.807 | 0.776       | 0.840    |
| 2      | team2_bundle1_hipe2020_de_1   | 0.785 | 0.749       | 0.824    |
| 3      | team2_bundle1_hipe2020_de_2   | 0.783 | 0.754       | 0.814    |
| 4      | team2_bundle3_hipe2020_de_2   | 0.783 | 0.754       | 0.814    |
| 5      | neurbsl_bundle3_hipe2020_de_1 | 0.706 | 0.659       | 0.759    |

### NERC fine hipe2020 German strict, nested entities \[`NE-NESTED-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                      | F1    | Precision   | Recall   |
|:-------|:----------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_hipe2020_de_1 | 0.522 | 0.714       | 0.411    |
| 2      | team2_bundle1_hipe2020_de_2 | 0.457 | 0.750       | 0.329    |
| 3      | team2_bundle3_hipe2020_de_2 | 0.457 | 0.750       | 0.329    |
| 4      | team2_bundle1_hipe2020_de_1 | 0.393 | 0.618       | 0.288    |

### NERC fine hipe2020 German fuzzy, nested entities \[`NE-NESTED-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                      | F1    | Precision   | Recall   |
|:-------|:----------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_hipe2020_de_1 | 0.539 | 0.738       | 0.425    |
| 2      | team2_bundle1_hipe2020_de_2 | 0.476 | 0.781       | 0.342    |
| 3      | team2_bundle3_hipe2020_de_2 | 0.476 | 0.781       | 0.342    |
| 4      | team2_bundle1_hipe2020_de_1 | 0.393 | 0.618       | 0.288    |

### NERC fine hipe2020 French strict (literal sense) \[`NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                        | F1    | Precision   | Recall   |
|:-------|:------------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_hipe2020_fr_1   | 0.740 | 0.702       | 0.782    |
| 2      | team2_bundle1_hipe2020_fr_2   | 0.736 | 0.697       | 0.779    |
| 3      | team2_bundle3_hipe2020_fr_1   | 0.720 | 0.679       | 0.767    |
| 4      | neurbsl_bundle3_hipe2020_fr_1 | 0.708 | 0.685       | 0.733    |

### NERC fine hipe2020 French fuzzy (literal sense) \[`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                        | F1    | Precision   | Recall   |
|:-------|:------------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_hipe2020_fr_1   | 0.826 | 0.784       | 0.873    |
| 2      | team2_bundle1_hipe2020_fr_2   | 0.825 | 0.782       | 0.873    |
| 3      | team2_bundle3_hipe2020_fr_1   | 0.812 | 0.765       | 0.865    |
| 4      | neurbsl_bundle3_hipe2020_fr_1 | 0.795 | 0.769       | 0.822    |

### NERC fine hipe2020 French strict, nested entities \[`NE-NESTED-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                      | F1    | Precision   | Recall   |
|:-------|:----------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_hipe2020_fr_2 | 0.377 | 0.390       | 0.366    |
| 2      | team2_bundle1_hipe2020_fr_1 | 0.366 | 0.394       | 0.341    |
| 3      | team2_bundle3_hipe2020_fr_1 | 0.320 | 0.301       | 0.341    |

### NERC fine hipe2020 French fuzzy, nested entities \[`NE-NESTED-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                      | F1    | Precision   | Recall   |
|:-------|:----------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_hipe2020_fr_2 | 0.403 | 0.416       | 0.390    |
| 2      | team2_bundle1_hipe2020_fr_1 | 0.392 | 0.423       | 0.366    |
| 3      | team2_bundle3_hipe2020_fr_1 | 0.389 | 0.366       | 0.415    |

### NERC fine newseye German strict (literal sense) \[`NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_newseye_de_1 | 0.235 | 0.500       | 0.154    |

### NERC fine newseye German fuzzy (literal sense) \[`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_newseye_de_1 | 0.353 | 0.750       | 0.231    |

### NERC fine newseye French strict (literal sense) \[`NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_newseye_fr_1 | 0.394 | 0.406       | 0.382    |

### NERC fine newseye French fuzzy (literal sense) \[`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_newseye_fr_1 | 0.485 | 0.500       | 0.471    |

### NERC fine newseye Finnish fuzzy (literal sense) \[`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_newseye_fi_1 | 0.222 | 0.500       | 0.143    |

### NERC fine letemps French strict (literal sense) \[`NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_letemps_fr_1 | 0.615 | 0.564       | 0.676    |

### NERC fine letemps French fuzzy (literal sense) \[`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                       | F1    | Precision   | Recall   |
|:-------|:-----------------------------|:------|:------------|:---------|
| 1      | neurbsl_bundle3_letemps_fr_1 | 0.654 | 0.600       | 0.719    |

### NERC fine ajmc German strict (literal sense) \[`NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_ajmc_de_2   | 0.906 | 0.915       | 0.898    |
| 2      | team2_bundle3_ajmc_de_1   | 0.880 | 0.860       | 0.901    |
| 3      | neurbsl_bundle3_ajmc_de_1 | 0.818 | 0.819       | 0.817    |

### NERC fine ajmc German fuzzy (literal sense) \[`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_ajmc_de_2   | 0.933 | 0.941       | 0.924    |
| 2      | team2_bundle3_ajmc_de_1   | 0.905 | 0.885       | 0.927    |
| 3      | neurbsl_bundle3_ajmc_de_1 | 0.865 | 0.866       | 0.864    |

### NERC fine ajmc English strict (literal sense) \[`NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_ajmc_en_1   | 0.798 | 0.754       | 0.848    |
| 2      | team2_bundle1_ajmc_en_2   | 0.781 | 0.745       | 0.822    |
| 3      | neurbsl_bundle3_ajmc_en_1 | 0.664 | 0.600       | 0.744    |

### NERC fine ajmc English fuzzy (literal sense) \[`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team2_bundle1_ajmc_en_1   | 0.847 | 0.801       | 0.899    |
| 2      | team2_bundle1_ajmc_en_2   | 0.847 | 0.807       | 0.891    |
| 3      | neurbsl_bundle3_ajmc_en_1 | 0.749 | 0.676       | 0.839    |

### NERC fine ajmc French strict (literal sense) \[`NE-FINE-LIT-micro-strict-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_ajmc_fr_2   | 0.669 | 0.646       | 0.694    |
| 2      | team2_bundle3_ajmc_fr_1   | 0.645 | 0.623       | 0.669    |
| 3      | neurbsl_bundle3_ajmc_fr_1 | 0.545 | 0.526       | 0.567    |

### NERC fine ajmc French fuzzy (literal sense) \[`NE-FINE-LIT-micro-fuzzy-TIME-ALL-LED-ALL`\]

| Rank   | System                    | F1    | Precision   | Recall   |
|:-------|:--------------------------|:------|:------------|:---------|
| 1      | team2_bundle3_ajmc_fr_2   | 0.728 | 0.703       | 0.756    |
| 2      | team2_bundle3_ajmc_fr_1   | 0.710 | 0.685       | 0.736    |
| 3      | neurbsl_bundle3_ajmc_fr_1 | 0.639 | 0.616       | 0.664    |

## EL

Relevant bundles: 1, 2

## EL only

Relevant bundles: 5
