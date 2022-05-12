# HIPE-2022 Evaluation Toolkit

This repository contains the **results of the HIPE-2022 [shared task](https://hipe-eval.github.io/HIPE-2022/)** on NE processing of historical documents, as well as the necessary material for **replicating** them, namely:

- the test data;
- the submitted system responses;
- the [HIPE-scorer](https://github.com/hipe-eval/HIPE-scorer) (as a submodule);
- the system result files;
- a makefile to run the whole evaluation process.

**Additional links**

- HIPE-2022 [website](https://hipe-eval.github.io/HIPE-2022/);
- Official HIPE-2022 [data releases](https://github.com/impresso/CLEF-HIPE-2020/tree/master/data);
- HIPE-2022 [baselines](https://github.com/hipe-eval/HIPE-2022-baseline);
- HIPE evaluation campaigns [zenodo community](https://zenodo.org/communities/hipe-eval/?page=1&size=20).

## References

**Participant teams Working Notes papers**

_to be completed._

**About HIPE-2022**

- M. Ehrmann, M. Romanello, A. Doucet, and S. Clematide, S. (2022). [Introducing the HIPE 2022 Shared Task: Named Entity Recognition and Linking in Multilingual Historical Documents](https://doi.org/10.1007/978-3-030-99739-7_44). In: Advances in Information Retrieval. ECIR 2022. Lecture Notes in Computer Science, vol 13186. Springer, Cham (link to [postprint](https://github.com/hipe-eval/HIPE-2022/blob/main/assets/pdf/HIPE2022_ECIR_shortpaper_postprint.pdf)).

## Installation

```
git clone --recurse-submodules git@github.com:hipe-eval/HIPE-2022-eval.git
cd HIPE-2022-eval
python3 -mvenv venv
source venv/bin/activate
pip install -r requirements.txt
( cd HIPE-scorer && pip install -r requirements.txt && python setup.py install )

# if submodule HIPE-scorer is updated, the following might be needed

git submodule update 
( cd HIPE-scorer && pip install -r requirements.txt && python setup.py install )
```

## How-To
```
make eval-full   # Creates all evaluation steps
# in case you want to start from scratch and refresh all derived files
make eval-full-refresh
```

```
make eval-system-bundles
make ranking-alldatasets-alllanguages
make generate-rankings-summary
make generate-rankings-summary  rankings-summary-ToC

```

## Licenses

- The test data is released under different licenses, check the [data repository](https://github.com/impresso/CLEF-HIPE-2020/tree/master/data) for more information.
- HIPE-2022 evaluation code is released under [to be completed]. Copyright (c) 2022 HIPE-2022 team.
