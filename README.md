# HIPE-2022 Evaluation Toolkit

The HIPE-2022 Evaluation Toolkit contains the **results of the HIPE-2022 [shared task](https://hipe-eval.github.io/HIPE-2022/)** on NE processing of historical documents, as well as the necessary material for **replicating** them, namely:

- the test data;
- the submitted system responses;
- the [HIPE-scorer](https://github.com/hipe-eval/HIPE-scorer) (as a submodule, commit [6605770](https://github.com/hipe-eval/HIPE-scorer/commit/66057705c26e662081ebb5dd576d323858e22ef0));
- a Makefile to run the whole evaluation process.

**For more information, also have a look at:**

- :checkered_flag: HIPE-2022 results in [HIPE_2022_evaluation_results.md](https://github.com/hipe-eval/HIPE-2022-eval/blob/main/HIPE_2022_evaluation_results.md) and on the [website](https://hipe-eval.github.io/HIPE-2022/results).
- :computer: HIPE-2022 [website](https://hipe-eval.github.io/HIPE-2022/);
- :open_file_folder: Official HIPE-2022 [data releases](https://github.com/impresso/CLEF-HIPE-2020/tree/master/data);
- :low_brightness: HIPE-2022 [baselines](https://github.com/hipe-eval/HIPE-2022-baseline);
- :books: HIPE evaluation campaigns [zenodo community](https://zenodo.org/communities/hipe-eval/?page=1&size=20).


## Installation and Usage

**To install the module:**

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

**To run the evaluation:**

```
make eval-full   # Creates all evaluation steps
# in case you want to start from scratch and refresh all derived files
make eval-full-refresh
```

If you want to build the targets incrementally:

```
make eval-system-bundles
make ranking-alldatasets-alllanguages
make generate-rankings-summary
make generate-rankings-summary  rankings-summary-ToC 

```

## References

**Participant Working Notes papers**

_to be completed in Sept 2022._

**About HIPE-2022**

- M. Ehrmann, M. Romanello, A. Doucet, and S. Clematide, S. (2022). [Introducing the HIPE 2022 Shared Task: Named Entity Recognition and Linking in Multilingual Historical Documents](https://doi.org/10.1007/978-3-030-99739-7_44). In: Advances in Information Retrieval. ECIR 2022. Lecture Notes in Computer Science, vol 13186. Springer, Cham (link to [postprint](https://github.com/hipe-eval/HIPE-2022/blob/main/assets/pdf/HIPE2022_ECIR_shortpaper_postprint.pdf)).

```
@inproceedings{ehrmann_introducing_2022,
  title = {Introducing the {{HIPE}} 2022 Shared {{Task}}:{{Named}} Entity Recognition and Linking in Multilingual Historical Documents},
  booktitle = {Proceedings of the 44\textsuperscript{d} European Conference on {{IR}} Research ({{ECIR}} 2022)},
  author = {Ehrmann, Maud and Romanello, Matteo and Clematide, Simon and Doucet, Antoine},
  year = {2022},
  publisher = {{Lecture Notes in Computer Science, Springer}},
  address = {{Stavanger, Norway}},
  url = {https://link.springer.com/chapter/10.1007/978-3-030-99739-7_44}
}
```


## Licenses

- The test data is released under different licenses, check the [data repository](https://github.com/impresso/CLEF-HIPE-2020/tree/master/data) for more information.
- HIPE-2022 evaluation code is released under [to be completed]. Copyright (c) 2022 HIPE-2022 team.
