SHELL:=/bin/bash


help:
	# make prepare-eval  eval-system-bundles
    # make ranking-alldatasets-alllanguages
    # make generate-rankings-summary

all: prepare-eval  eval-system-bundles ranking-alldatasets-alllanguages rankings-summary



# emit additional diagnostics output on the matched files
DEBUG ?= 0

############################################################################################
# SYSTEM EVALUATION (START OF OPEN-SOURCE PART)
############################################################################################
# currently set to provisional (until the full test data is available from the repository)
RELEASE_DIR?=HIPE-2022-data-provisional/data
VERSION?= v2.1
GROUND_TRUTH_DIR ?= $(RELEASE_DIR)/$(VERSION)

SCORER_DIR?=HIPE-scorer
EVAL_DIR?=evaluation

SUB_DIR?=$(EVAL_DIR)/system-responses/submitted
SUB_TIMENORM_DIR?=$(EVAL_DIR)/system-responses/time-normalized
SUB_HISTONORM_DIR?=$(EVAL_DIR)/system-responses/histo-normalized

RES_DIR?=$(EVAL_DIR)/system-evaluations
EVAL_LOGS_DIR?=$(EVAL_DIR)/system-evaluation-logs
RANK_DIR?=$(EVAL_DIR)/system-rankings

BUNDLEIDS ?= 1 2 3 4 5
# default bundle for testing
BUNDLE ?= 1

DATASETS ?= hipe2020 letemps newseye topres19th sonar ajmc

# The current dataset we are evaluating for
# default dataset for testing
DATASET ?= hipe2020

MICRO_RANKING_COLUMNS ?= 1,2,3,4,5,6,10,11,12


ifeq ($(DATASET),ajmc)
FILE_NEL_MAPPING?=$(SCORER_DIR)/ajmc-alternatives-QID-mapping-ID-mapping.tsv
endif

# copy this file manually from here and remove spaces in file name:
# https://docs.google.com/spreadsheets/d/1s2BpIeiqsJIjHLsIecshrHG9UFkMBW1Nfr-h68AB2pY/edit#gid=1606475364
FILE_NEL_MAPPING?=$(SCORER_DIR)/historico-fuzzy-QID-mapping-ID-mapping.tsv

#EVAL_NOISE_LEVEL?=--noise-level 0.0-0.0,0.001-0.1,0.1-0.3,0.3-1.1
EVAL_TIME_PERIOD_FR?=
EVAL_TIME_PERIOD_DE?=
EVAL_TIME_PERIOD_EN?=


#: create evaluation directories
prepare-eval:
	mkdir -p $(SUB_DIR) $(SUB_TIMENORM_DIR) $(SUB_HISTONORM_DIR) $(RES_DIR) $(EVAL_LOGS_DIR) $(RANK_DIR)

# TEAMNAME_TASKBUNDLE_DATASET_LANG_RUN.tsv
# e.g. evaluation/system-responses/submitted/team2_bundle1_hipe2020_fr_2.tsv
# $(info submission-files-wildcard $(SUB_DIR)/*bundle$(BUNDLE)_$(DATASET)*.tsv)

submission-files := $(wildcard $(SUB_DIR)/*bundle$(BUNDLE)_$(DATASET)*.tsv)
ifeq ($(DEBUG),1)
$(info )
$(info # INFO: submission-files: $(submission-files))
$(info )
endif

# produce normalized version of system responses
# versions: time, historical+time
submission-timenorm-files:=$(subst $(SUB_DIR),$(SUB_TIMENORM_DIR),$(submission-files))
submission-histonorm-files:=$(subst $(SUB_DIR),$(SUB_HISTONORM_DIR),$(submission-files))


gold-files:=$(foreach dataset,$(DATASETS),$(wildcard $(GROUND_TRUTH_DIR)/*-$(dataset)-test-??.tsv))
ifeq ($(DEBUG),1)
$(info )
$(info # INFO: gold-files: $(gold-files))
$(info )
endif

# produce normalized version of gold standard
# version: historical
gold-histonorm-files:=$(gold-files:.tsv=_histonorm.tsv)

result-nonorm-files:=$(subst $(SUB_DIR),$(RES_DIR),$(submission-files))
ifeq ($(DEBUG),1)
$(info )
$(info result-nonorm-files: $(result-nonorm-files))
$(info )
endif
result-timenorm-files:=$(subst $(SUB_TIMENORM_DIR),$(RES_DIR),$(submission-timenorm-files))
result-histonorm-files:=$(subst $(SUB_HISTONORM_DIR),$(RES_DIR),$(submission-histonorm-files:.tsv=_relaxed.tsv))


build-gold-histonorm-files: $(gold-histonorm-files)
clean-gold-histonorm-files:
	rm -fv $(gold-histonorm-files)

#:
eval-system-bundle: $(result-nonorm-files) # $(submission-timenorm-files) $(result-timenorm-files) $(submission-histonorm-files) $(result-histonorm-files)

eval-full: $(gold-histonorm-files) baseline-nerc eval-clean eval-system ranking-de ranking-fr ranking-en ranking-fine-de ranking-fine-fr plots-paper #rankings-summary


eval-system-bundles: \
	eval-system-bundles-hipe2020 \
	eval-system-bundles-newseye \
	eval-system-bundles-sonar \
	eval-system-bundles-letemps \
	eval-system-bundles-topres19th \
	eval-system-bundles-ajmc

eval-system-bundles-%: prepare-eval
	$(MAKE) -k eval-system-bundle BUNDLE=1 DATASET=$* $(MAKEFLAGS)
	$(MAKE) -k eval-system-bundle BUNDLE=2 DATASET=$* $(MAKEFLAGS)
	$(MAKE) -k eval-system-bundle BUNDLE=3 DATASET=$* $(MAKEFLAGS)
	$(MAKE) -k eval-system-bundle BUNDLE=4 DATASET=$* $(MAKEFLAGS)
	$(MAKE) -k eval-system-bundle BUNDLE=5 DATASET=$* $(MAKEFLAGS)

# normalize NEL for historical entities in gold standard
%_histonorm.tsv: %.tsv
	python3 $(SCORER_DIR)/normalize_linking.py -i $< -o $@ --norm-histo -m $(FILE_NEL_MAPPING)

# normalize NEL for time mentions in system responses
$(SUB_TIMENORM_DIR)/%.tsv: $(SUB_DIR)/%.tsv
	python3 $(SCORER_DIR)/normalize_linking.py -i $< -o $@ --norm-time

# normalize NEL for historical entities and time mentions in system responses
$(SUB_HISTONORM_DIR)/%.tsv: $(SUB_DIR)/%.tsv
	python3 $(SCORER_DIR)/normalize_linking.py -i $< -o $@ --norm-time --norm-histo -m $(FILE_NEL_MAPPING)

# Raw evaluation without any modifications
# e.g. evaluation/system-responses/submitted/team2_bundle1_hipe2020_en_2.tsv
# ground truth  HIPE-2022-v2.1-hipe2020-test-en.tsv
$(RES_DIR)/%.tsv: $(SUB_DIR)/%.tsv
ifeq ($(BUNDLE),1)
	# NERC-Coarse  BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nerc_coarse --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
		--pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nerc_coarse.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt --hipe_edition hipe-2022
	# NERC-Fine    BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nerc_fine --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
		--pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nerc_fine.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt --hipe_edition hipe-2022
	# NEL-end-to-end BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nel --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
	    --pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt  --hipe_edition hipe-2022
else ifeq ($(BUNDLE),2)
	# NERC-Coarse  BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nerc_coarse --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
		--pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nerc_coarse.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt --hipe_edition hipe-2022
	# NEL-end-to-end BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nel --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
	    --pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt  --hipe_edition hipe-2022
else ifeq ($(BUNDLE),3)
	# NERC-Coarse  BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nerc_coarse --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
		--pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nerc_coarse.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt --hipe_edition hipe-2022
	python3 $(SCORER_DIR)/clef_evaluation.py --task nerc_fine --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
		--pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nerc_fine.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt --hipe_edition hipe-2022
else ifeq ($(BUNDLE),4)
	# NERC-Coarse  BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nerc_coarse --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
		--pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nerc_coarse.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt --hipe_edition hipe-2022
else ifeq ($(BUNDLE),5)
	# NEL-only BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nel --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
	    --pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt  --hipe_edition hipe-2022
endif


# standard evaluation
# with dirty runtime hacks to conditionally evaluate on a particular language and bundle
# the language is also used to determine the time buckets conditionally
$(RES_DIR)/%.tsv: $(SUB_TIMENORM_DIR)/%.tsv $(gold-files)
	@$(eval LANG_ABBR=$(shell echo $< | grep -Po '(?<=_)[a-z]{2}(?=_[0-3])'))
	@$(eval PERIOD=$(shell if [ "en" == $(LANG_ABBR) ]; then echo $(EVAL_TIME_PERIOD_EN); elif [ "de" == $(LANG_ABBR) ]; then echo $(EVAL_TIME_PERIOD_DE); else echo $(EVAL_TIME_PERIOD_FR); fi))

ifeq ($(BUNDLE),1)
	python3 $(SCORER_DIR)/clef_evaluation.py --hipe_edition hipe-2022 --ref $(GROUND_TRUTH_DIR)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR).tsv --pred $< --task nerc_coarse --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nerc_coarse.log) --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
	python3 $(SCORER_DIR)/clef_evaluation.py --hipe_edition hipe-2022 --ref $(GROUND_TRUTH_DIR)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR).tsv --pred $< --task nerc_fine --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nerc_fine.log) --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
	python3 $(SCORER_DIR)/clef_evaluation.py --hipe_edition hipe-2022 --ref $(GROUND_TRUTH_DIR)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR).tsv --pred $< --task nel --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
else ifeq ($(BUNDLE),2)
	python3 $(SCORER_DIR)/clef_evaluation.py --hipe_edition hipe-2022 --ref $(GROUND_TRUTH_DIR)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR).tsv --pred $< --task nerc_coarse --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nerc_coarse.log) --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
	python3 $(SCORER_DIR)/clef_evaluation.py --hipe_edition hipe-2022 --ref $(GROUND_TRUTH_DIR)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR).tsv --pred $< --task nel --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
else ifeq ($(BUNDLE),3)
	python3 $(SCORER_DIR)/clef_evaluation.py --hipe_edition hipe-2022 --ref $(GROUND_TRUTH_DIR)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR).tsv --pred $< --task nerc_coarse --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nerc_coarse.log) --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
	python3 $(SCORER_DIR)/clef_evaluation.py --hipe_edition hipe-2022 --ref $(GROUND_TRUTH_DIR)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR).tsv --pred $< --task nerc_fine --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nerc_fine.log) --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
else ifeq ($(BUNDLE),4)
	python3 $(SCORER_DIR)/clef_evaluation.py --hipe_edition hipe-2022 --ref $(GROUND_TRUTH_DIR)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR).tsv --pred $< --task nerc_coarse --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nerc_coarse.log) --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
else ifeq ($(BUNDLE),5)
	python3 $(SCORER_DIR)/clef_evaluation.py --hipe_edition hipe-2022 --ref $(GROUND_TRUTH_DIR)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR).tsv --pred $< --task nel --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
endif

# NEL evaluation on historically normalized system and gold datasets
$(RES_DIR)/%_relaxed.tsv: $(SUB_HISTONORM_DIR)/%.tsv $(gold-histonorm-files)
	@$(eval LANG_ABBR=$(shell echo $< | grep -Po '(?<=_)[a-z]{2}(?=_[0-3])'))
	@$(eval PERIOD=$(shell if [ "en" == $(LANG_ABBR) ]; then echo $(EVAL_TIME_PERIOD_EN); elif [ "de" == $(LANG_ABBR) ]; then echo $(EVAL_TIME_PERIOD_DE); else echo $(EVAL_TIME_PERIOD_FR); fi))

ifeq ($(BUNDLE),1)
	python3 $(SCORER_DIR)/clef_evaluation.py --hipe_edition hipe-2022 --ref $(GROUND_TRUTH_DIR)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR)_histonorm.tsv --pred $< --task nel --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --suffix relaxed --n_best 1,3,5 --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
else ifeq ($(BUNDLE),2)
	python3 $(SCORER_DIR)/clef_evaluation.py --hipe_edition hipe-2022 --ref $(GROUND_TRUTH_DIR)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR)_histonorm.tsv --pred $< --task nel --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --suffix relaxed --n_best 1,3,5 --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
else ifeq ($(BUNDLE),5)
	python3 $(SCORER_DIR)/clef_evaluation.py --hipe_edition hipe-2022 --ref $(GROUND_TRUTH_DIR)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR)_histonorm.tsv --pred $< --task nel --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --suffix relaxed --n_best 1,3,5 --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
endif

#: Per language; datasets via recursive make
ranking-dataset-$(DATASET)-%:
	$(MAKE) -k ranking-$* DATASET=$(DATASET) $(MAKEFLAGS)


ranking-alldatasets-alllanguages:
	$(MAKE) -k $(foreach lng,de fr en,ranking-ajmc-$(lng)) DATASET=ajmc $(MAKEFLAGS)
	$(MAKE) -k $(foreach lng,de fr en,ranking-hipe2020-$(lng)) DATASET=hipe2020 $(MAKEFLAGS)
	$(MAKE) -k $(foreach lng,de,ranking-sonar-$(lng)) DATASET=sonar $(MAKEFLAGS)
	$(MAKE) -k $(foreach lng,en,ranking-topres19th-$(lng)) DATASET=topres19th $(MAKEFLAGS)
	$(MAKE) -k $(foreach lng,de en fr fi sv,ranking-newseye-$(lng)) DATASET=newseye $(MAKEFLAGS)
	$(MAKE) -k $(foreach lng,fr,ranking-letemps-$(lng)) DATASET=letemps $(MAKEFLAGS)
	# RANKING FINE
	$(MAKE) -k $(foreach lng,de fr,ranking-hipe2020-fine-$(lng)) DATASET=hipe2020 $(MAKEFLAGS)
	$(MAKE) -k $(foreach lng,de fr en,ranking-ajmc-fine-$(lng)) DATASET=ajmc $(MAKEFLAGS)
	$(MAKE) -k $(foreach lng,fr,ranking-letemps-fine-$(lng)) DATASET=letemps $(MAKEFLAGS)
	$(MAKE) -k $(foreach lng,de en fr fi sv,ranking-newseye-fine-$(lng)) DATASET=newseye $(MAKEFLAGS)

# More specific rule must come first
ranking-$(DATASET)-fine-%: #$(result-nonorm-files) #$(result-norm-files) $(gold-norm-files) $(normalized-files)
	cat $(RES_DIR)/*_$(DATASET)_$*_*.tsv | head -n 1 | cut -f $(MICRO_RANKING_COLUMNS) > header.tmp
	grep -Phs '(NE-FINE|NE-NESTED).*micro-fuzzy.*ALL' $(RES_DIR)/*_$(DATASET)_$*_*.tsv | cut -f $(MICRO_RANKING_COLUMNS) | sort -u -t$$'\t' -k2 | sort -t$$'\t' -k3,3 -k6,6r -k2,2 -k1,1 | (cat header.tmp && cat) > $(RANK_DIR)/ranking-$(DATASET)-$*-fine-micro-fuzzy-all.tsv
	grep -Phs '(NE-FINE|NE-NESTED).*micro-strict.*ALL' $(RES_DIR)/*_$(DATASET)_$*_*.tsv| cut -f $(MICRO_RANKING_COLUMNS) | sort -u -t$$'\t' -k2 | sort -t$$'\t' -k3,3 -k6,6r -k2,2 -k1,1 | (cat header.tmp && cat) > $(RANK_DIR)/ranking-$(DATASET)-$*-fine-micro-strict-all.tsv
	rm header.tmp



# produce rankings per language, task, sorted by F1-score of micro fuzzy across labels
# bundle 5 goes into separate table as they have gold annotations
# English has no fine annotation, other than German and French
ranking-$(DATASET)-%: #$(result-nonorm-files) #$(result-norm-files) $(gold-norm-files) $(normalized-files)
	cat $(RES_DIR)/*_$(DATASET)_$*_*.tsv | head -n 1 | cut -f $(MICRO_RANKING_COLUMNS)  > header.tmp
	grep -hs 'NE-COARSE.*micro-fuzzy.*ALL'  $(RES_DIR)/*_$(DATASET)_$*_*.tsv                      | sort -u -t$$'\t' -k2 | sort -t$$'\t' -k3,3 -k6,6r -k2,2 -k1,1 | cut -f $(MICRO_RANKING_COLUMNS) | (cat header.tmp && cat) > $(RANK_DIR)/ranking-$(DATASET)-$*-coarse-micro-fuzzy-all.tsv
	grep -hs 'NE-COARSE.*micro-strict.*ALL' $(RES_DIR)/*_$(DATASET)_$*_*.tsv                      | sort -u -t$$'\t' -k2 | sort -t$$'\t' -k3,3 -k6,6r -k2,2 -k1,1 | cut -f $(MICRO_RANKING_COLUMNS) | (cat header.tmp && cat) > $(RANK_DIR)/ranking-$(DATASET)-$*-coarse-micro-strict-all.tsv
	grep -hs 'NEL.*micro-fuzzy' $(RES_DIR)/*_bundle{1..4}_$(DATASET)_$*_*.tsv | grep -v 'relaxed' | sort -u -t$$'\t' -k2 | sort -t$$'\t' -k3,3 -k6,6r -k2,2 -k1,1 | cut -f $(MICRO_RANKING_COLUMNS) | (cat header.tmp && cat) > $(RANK_DIR)/ranking-$(DATASET)-$*-nel-micro-fuzzy-all.tsv
	grep -hs 'NEL.*micro-fuzzy' $(RES_DIR)/*_bundle5_$(DATASET)_$*_*.tsv | grep -v 'relaxed'      | sort -u -t$$'\t' -k2 | sort -t$$'\t' -k2,2 -k6,6r -k2,2 -k1,1 | cut -f $(MICRO_RANKING_COLUMNS) | (cat header.tmp && cat) > $(RANK_DIR)/ranking-$(DATASET)-$*-nel-only-micro-fuzzy-all.tsv
#NOT YET IMPLEMENTED	grep -hs 'NEL.*micro-fuzzy' $(RES_DIR)/*_bundle{1..4}_$(DATASET)_$*_?_relaxed.tsv | sort -t$$'\t' -k2,2 -k6,6r | (cat header.tmp && cat) > $(RANK_DIR)/ranking-$(DATASET)-$*-nel-micro-fuzzy-relaxed.tsv
#NOT YET IMPLEMENTED	grep -hs 'NEL.*micro-fuzzy' $(RES_DIR)/*_bundle5_$(DATASET)_$*_?_relaxed.tsv | sort -t$$'\t' -k2,2 -k6,6r | (cat header.tmp && cat) > $(RANK_DIR)/ranking-$(DATASET)-$*-nel-only-micro-fuzzy-relaxed.tsv
	rm header.tmp


# produce the plots of the system performance on noisy and diachronic data also shown in the paper
plots-paper: ranking-de ranking-fr ranking-en
	python3 lib/eval_robustness.py --input-dir $(RANK_DIR) --output-dir $(EVAL_DIR)/robustness --log-file eval_robustness.log

eval-clean:
	rm -f $(RANK_DIR)/*
	rm -f $(SUB_TIMENORM_DIR)/*
	rm -f $(SUB_HISTONORM_DIR)/*
	rm -f $(RES_DIR)/*tsv
	rm -f $(EVAL_LOGS_DIR)/*
	rm -f $(gold-histonorm-files)

############################################################################################
# END OF OPEN-SOURCE PART
############################################################################################

############################################################################################
### Generate a detailed Markdown summary of rankings
############################################################################################

rankings-summary: generate-rankings-summary rankings-summary-ToC

generate-rankings-summary:
	python3 lib/format_rankings_summary.py --input-dir=$(RANK_DIR) --output-dir=$(RANK_DIR) --submissions-dir=$(SUB_DIR)
	# open $(RANK_DIR)/ranking_summary.md for viewing the results

# requires https://github.com/ekalinin/github-markdown-toc
rankings-summary-ToC:
	cd $(RANK_DIR); gh-md-toc --no-backup ./ranking_summary.md ./ranking_summary.md


############################################################################################
### Aggregate system responses to improve gold standard
############################################################################################

aggr-responses-all: aggr-responses-de.txt aggr-responses-fr.txt aggr-responses-en.txt
aggr-responses-%.txt:
	python3 lib/aggregate_system_responses.py --input_dir $(SUB_DIR) --gold_file $(GROUND_TRUTH_DIR)/$*/HIPE-data-$(VERSION)-test-$*.tsv --log $(EVAL_DIR)/$@ --threshold 0.5

# IMPORTANT: Do not indent the first line; whitespace will be kept
define submission_lang
$(strip $(foreach l,en de fr sv fi,$(filter $l,$(subst _, ,$1))))
endef

#$(info submission_lang-test $(call submission_lang,evaluation/system-responses/submitted/team2_bundle1_hipe2020_en_2.tsv))
#$(info submission_lang-test $(call submission_lang,evaluation/system-responses/submitted/team2_bundle1_hipe2020_fr_2.tsv))


####
# feedback
####define


create-feedback-zips-nerc:
	rm -fr feedback-phase-1.d && mkdir -p feedback-phase-1.d
	for team in team1 team2 team3 team4 ; do \
    zip feedback-phase-1.d/evaluation-data-$${team}.zip  \
     evaluation/system-evaluation-logs/$${team}*.log \
	evaluation/system-evaluations/$${team}_*{nerc_fine,nerc_coarse}*.{json,tsv} \
     evaluation/system-responses/submitted/$${team}*.tsv ;\
  	done


create-feedback-zips-linking:
	rm -fr feedback-phase-2.d && mkdir -p feedback-phase-2.d
	for team in team2 team5 ; do \
    zip feedback-phase-2.d/evaluation-data-$${team}.zip  \
     evaluation/system-evaluation-logs/$${team}*nel.log \
	 evaluation/system-evaluations/$${team}_*nel.{json,tsv} \
     evaluation/system-responses/submitted/$${team}*.tsv ;\
  	done
#  include ranking? evaluation/system-rankings/ranking-{hipe2020,newseye,sonar,letemps}*coarse*all.tsv ;\
