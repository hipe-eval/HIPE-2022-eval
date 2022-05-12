SHELL:=/bin/bash
.SECONDARY:


# histonorm: Submission and Groundtruth files are physically modified
# relaxed: Evaluation mode of the HIPE scorer; Relaxed evaluations always work on histonormalized input files in a separate folder with the _relaxed suffix

help:
	# make prepare-eval  eval-system-bundles
    # make ranking-alldatasets-alllanguages
    # make generate-rankings-summary

all: prepare-eval  eval-system-bundles ranking-alldatasets-alllanguages rankings-summary



# emit additional diagnostics output on the matched files
DEBUG ?= 0

# force build
# set to -B to force the recursive make builds
FORCE_BUILD ?=

############################################################################################
# SYSTEM EVALUATION (START OF OPEN-SOURCE PART)
############################################################################################
# currently set to provisional (until the full test data is available from the repository)
RELEASE_DIR ?= HIPE-2022-data-provisional/data
VERSION ?= v2.1
GROUND_TRUTH_DIR ?= $(RELEASE_DIR)/$(VERSION)

SCORER_DIR?=HIPE-scorer
EVAL_DIR?=evaluation
#:
#EVALUATION_N_BEST_OPTION ?= --n_best 1,3,5
EVALUATION_N_BEST_OPTION ?= --n_best 1

# SUB_DIR contains all submitted files
SUB_DIR ?= $(EVAL_DIR)/system-responses/submitted
SUB_HISTO_DIR ?= $(EVAL_DIR)/system-responses/histo-normalized
SUB_TIMENORM_DIR ?= $(EVAL_DIR)/system-responses/time-normalized
SUB_HISTOTIMENORM_DIR ?= $(EVAL_DIR)/system-responses/histo-time-normalized

#: Directory with all evaluation files
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
	mkdir -p $(SUB_DIR) $(SUB_TIMENORM_DIR) $(SUB_HISTOTIMENORM_DIR) $(RES_DIR) $(EVAL_LOGS_DIR) $(RANK_DIR)

############################################################################################
### Groundtruth files and their automatically generated normalized variants
#   - %.tsv : original files
#   - %_histonorm.tsv: Mapping of equivalent historical/modern entities data-specific
############################################################################################


gold-files:=$(foreach dataset,$(DATASETS),$(wildcard $(GROUND_TRUTH_DIR)/*-$(dataset)-test-??.tsv))
ifeq ($(DEBUG),1)
$(info )
$(info # INFO: gold-files: $(gold-files))
$(info )
endif

# produce normalized version of gold standard
# version: historical
gold-histonorm-files:=$(gold-files:.tsv=_histonorm.tsv)

# normalize NEL for historical entities in gold standard
$(GROUND_TRUTH_DIR)/%_histonorm.tsv: $(GROUND_TRUTH_DIR)/%.tsv
	python3 $(SCORER_DIR)/normalize_linking.py -i $< -o $@ --norm-histo -m $(FILE_NEL_MAPPING)
	@echo "HISTONORM CHANGED LINES in $< $$(diff -wy --suppress-common-lines $@ $< | wc -l)" | tee  $@.log

build-gold-histonorm-files: $(gold-histonorm-files)
clean-gold-histonorm-files:
	rm -fv $(gold-histonorm-files)


# TEAMNAME_TASKBUNDLE_DATASET_LANG_RUN.tsv
# e.g. evaluation/system-responses/submitted/team2_bundle1_hipe2020_fr_2.tsv
# $(info submission-files-wildcard $(SUB_DIR)/*bundle$(BUNDLE)_$(DATASET)*.tsv)

submission-files := $(wildcard $(SUB_DIR)/*bundle$(BUNDLE)_$(DATASET)*.tsv)
ifeq ($(DEBUG),1)
$(info )
$(info  # INFO: submission-files: $(submission-files))
$(info )
endif

#: the evaluation files (same name as submission files) of the original files again (due to legacy things in HIPE eval 2020)
evaluation-nonorm-files := $(subst $(SUB_DIR),$(RES_DIR),$(submission-files))
ifeq ($(DEBUG),1)
$(info )
$(info evaluation-nonorm-files: $(evaluation-nonorm-files))
$(info )
endif

clean-evaluation-nonorm-files:
	rm -fv $(evaluation-nonorm-files)

# produce normalized version of system responses
# versions: time, historical+time
submission-timenorm-files:=$(subst $(SUB_DIR),$(SUB_TIMENORM_DIR),$(submission-files))


# normalize NEL for time mentions in system responses
$(SUB_TIMENORM_DIR)/%.tsv: $(SUB_DIR)/%.tsv
	python3 $(SCORER_DIR)/normalize_linking.py -i $< -o $@ --norm-time -e hipe-2022
	@echo "TIMENORM CHANGED LINES in $< $$(diff -wy --suppress-common-lines $@ $< | wc -l)" | tee  $@.log


#: Fix time NEL only. Actually not relevant for hipe-2022 submissions
evaluation-timenorm-files := $(subst $(SUB_TIMENORM_DIR),$(RES_DIR),$(evaluation-timenorm-files))
ifeq ($(DEBUG),1)
$(info )
$(info evaluation-timenorm-files: $(evaluation-timenorm-files))
$(info )
endif

submission-histonorm-files:=$(subst $(SUB_DIR),$(SUB_HISTOTIMENORM_DIR),$(submission-files))

build-submission-histonorm-files : $(submission-histonorm-files)
# normalize NEL for historical entities and time mentions in system responses
$(SUB_HISTOTIMENORM_DIR)/%.tsv: $(SUB_DIR)/%.tsv
	python3 $(SCORER_DIR)/normalize_linking.py -i $< -o $@ --norm-time --norm-histo -m $(FILE_NEL_MAPPING) -e hipe-2022
	@echo "HISTOTIMENORM CHANGED LINES in $< $$(diff -wy --suppress-common-lines $@ $< | wc -l)" | tee  $@.log

clean-evaluation-histonorm-files:
	rm -fv $(evaluation-histonorm-files)

# The histonormalized submission evaluations used for the separate relaxed NEL evaluation
#: Apply historical normalization to NEL columns
evaluation-histonorm-files := $(subst $(SUB_HISTOTIMENORM_DIR),$(RES_DIR),$(submission-histonorm-files:.tsv=_relaxed.tsv))
ifeq ($(DEBUG),1)
$(info )
$(info evaluation-histonorm-files: $(evaluation-histonorm-files))
$(info )
endif


build-evaluation-timenorm-files: $(evaluation-timenorm-files)


# $(evaluation-timenorm-files)  NOT NEEDED in 2022
#:
eval-system-bundle: $(evaluation-nonorm-files) $(evaluation-histonorm-files)

eval-full: $(gold-histonorm-files) baseline-nerc eval-clean eval-system ranking-de ranking-fr ranking-en ranking-fine-de ranking-fine-fr plots-paper #rankings-summary


eval-system-bundles: \
	eval-system-bundles-hipe2020 \
	eval-system-bundles-newseye \
	eval-system-bundles-sonar \
	eval-system-bundles-letemps \
	eval-system-bundles-topres19th \
	eval-system-bundles-ajmc

eval-system-bundles-%: prepare-eval
	$(MAKE) -k eval-system-bundle BUNDLE=1 DATASET=$* $(FORCE_BUILD)
	$(MAKE) -k eval-system-bundle BUNDLE=2 DATASET=$* $(FORCE_BUILD)
	$(MAKE) -k eval-system-bundle BUNDLE=3 DATASET=$* $(FORCE_BUILD)
	$(MAKE) -k eval-system-bundle BUNDLE=4 DATASET=$* $(FORCE_BUILD)
	$(MAKE) -k eval-system-bundle BUNDLE=5 DATASET=$* $(FORCE_BUILD)

## normalize NEL for historical entities in gold standard
#$(GROUND_TRUTH_DIR)/%_histonorm.tsv: $(GROUND_TRUTH_DIR)/%.tsv
#	python3 $(SCORER_DIR)/normalize_linking.py -i $< -o $@ --norm-histo -m $(FILE_NEL_MAPPING)



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
	touch $@
else ifeq ($(BUNDLE),2)
	# NERC-Coarse  BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nerc_coarse --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
		--pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nerc_coarse.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt --hipe_edition hipe-2022
	# NEL-end-to-end BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nel --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
	    --pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt  --hipe_edition hipe-2022
	touch $@
else ifeq ($(BUNDLE),3)
	# NERC-Coarse  BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nerc_coarse --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
		--pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nerc_coarse.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt --hipe_edition hipe-2022
	python3 $(SCORER_DIR)/clef_evaluation.py --task nerc_fine --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
		--pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nerc_fine.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt --hipe_edition hipe-2022
	touch $@
else ifeq ($(BUNDLE),4)
	# NERC-Coarse  BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nerc_coarse --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
		--pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nerc_coarse.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt --hipe_edition hipe-2022
	touch $@
else ifeq ($(BUNDLE),5)
	# NEL-only BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nel --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
	    --pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt  --hipe_edition hipe-2022
	touch $@
endif


# NEL evaluation on historically normalized system and gold datasets
$(RES_DIR)/%_relaxed.tsv: $(SUB_HISTOTIMENORM_DIR)/%.tsv # $(gold-histonorm-files)
ifeq ($(BUNDLE),1)
#python3 $(SCORER_DIR)/clef_evaluation.py --hipe_edition hipe-2022 --ref $(GROUND_TRUTH_DIR)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR)_histonorm.tsv
#--pred $< --task nel --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --suffix relaxed $(EVALUATION_N_BEST_OPTION)
# --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
	# Relaxed NEL-end-to-end BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nel --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F))_histonorm.tsv \
	    --pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --suffix relaxed $(EVALUATION_N_BEST_OPTION) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt  --hipe_edition hipe-2022
	touch $@
else ifeq ($(BUNDLE),2)
	# Relaxed NEL-end-to-end BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nel --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F))_histonorm.tsv \
	    --pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --suffix relaxed $(EVALUATION_N_BEST_OPTION) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt  --hipe_edition hipe-2022
	touch $@
#	python3 $(SCORER_DIR)/clef_evaluation.py --hipe_edition hipe-2022 --ref $(GROUND_TRUTH_DIR)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR)_histonorm.tsv --pred $< --task nel --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --suffix relaxed $(EVALUATION_N_BEST_OPTION) --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
else ifeq ($(BUNDLE),5)
	# Relaxed NEL-only BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nel --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F))_histonorm.tsv \
	    --pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --suffix relaxed $(EVALUATION_N_BEST_OPTION) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt  --hipe_edition hipe-2022
	touch $@
#	python3 $(SCORER_DIR)/clef_evaluation.py --hipe_edition hipe-2022 --ref $(GROUND_TRUTH_DIR)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR)_histonorm.tsv --pred $< --task nel --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --suffix relaxed $(EVALUATION_N_BEST_OPTION)  --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
endif

#: Per language; datasets via recursive make
#ranking-dataset-$(DATASET)-%:
#	$(MAKE) -k ranking-$* DATASET=$(DATASET) $(MAKEFLAGS)


ranking-alldatasets-alllanguages: prepare-eval eval-system-bundle
	# RANKING
	$(MAKE) -k $(foreach lng,de fr en,build-ranking-ajmc-$(lng)) DATASET=ajmc
	$(MAKE) -k $(foreach lng,de fr en,build-ranking-hipe2020-$(lng)) DATASET=hipe2020
	$(MAKE) -k $(foreach lng,de,build-ranking-sonar-$(lng)) DATASET=sonar
	$(MAKE) -k $(foreach lng,en,build-ranking-topres19th-$(lng)) DATASET=topres19th
	$(MAKE) -k $(foreach lng,de en fr fi sv,build-ranking-newseye-$(lng)) DATASET=newseye
	$(MAKE) -k $(foreach lng,fr,build-ranking-letemps-$(lng)) DATASET=letemps

	# RANKING FINE
	$(MAKE) -k $(foreach lng,de fr,build-fine-ranking-hipe2020-$(lng)) DATASET=hipe2020
	$(MAKE) -k $(foreach lng,de fr en,build-fine-ranking-ajmc-$(lng)) DATASET=ajmc
	$(MAKE) -k $(foreach lng,fr,build-fine-ranking-letemps-$(lng)) DATASET=letemps
	$(MAKE) -k $(foreach lng,de en fr fi sv,build-fine-ranking-newseye-$(lng)) DATASET=newseye

# More specific rule must come first
build-fine-ranking-$(DATASET)-%: \
	$(RANK_DIR)/ranking-$(DATASET)-%-fine-micro-fuzzy-all.tsv \
	$(RANK_DIR)/ranking-$(DATASET)-%-fine-micro-strict-all.tsv
	# $@ Done

$(RANK_DIR)/ranking-$(DATASET)-%-fine-micro-fuzzy-all.tsv:
	cat $(RES_DIR)/*_$(DATASET)_$*_*.tsv | head -n 1 | cut -f $(MICRO_RANKING_COLUMNS) > $@
	grep -Phs '(NE-FINE|NE-NESTED).*micro-fuzzy.*ALL' $(RES_DIR)/*_$(DATASET)_$*_*.tsv | cut -f $(MICRO_RANKING_COLUMNS) | sort -u -t$$'\t' -k2 | sort -t$$'\t' -k3,3 -k6,6r -k2,2 -k1,1 >> $@

$(RANK_DIR)/ranking-$(DATASET)-%-fine-micro-strict-all.tsv:
	cat $(RES_DIR)/*_$(DATASET)_$*_*.tsv | head -n 1 | cut -f $(MICRO_RANKING_COLUMNS) > $@
	grep -Phs '(NE-FINE|NE-NESTED).*micro-strict.*ALL' $(RES_DIR)/*_$(DATASET)_$*_*.tsv| cut -f $(MICRO_RANKING_COLUMNS) | sort -u -t$$'\t' -k2 | sort -t$$'\t' -k3,3 -k6,6r -k2,2 -k1,1 >> $@



# produce rankings per language, task, sorted by F1-score of micro fuzzy across labels
# bundle 5 goes into separate table as they have gold annotations
# English has no fine annotation, other than German and French
build-ranking-$(DATASET)-%:  \
		$(RANK_DIR)/ranking-$(DATASET)-%-coarse-micro-fuzzy-all.tsv \
		$(RANK_DIR)/ranking-$(DATASET)-%-coarse-micro-strict-all.tsv \
		$(RANK_DIR)/ranking-$(DATASET)-%-nel-micro-fuzzy-all.tsv \
		$(RANK_DIR)/ranking-$(DATASET)-%-nel-only-micro-fuzzy-all.tsv \
		$(RANK_DIR)/ranking-$(DATASET)-%-nel-micro-fuzzy-relaxed.tsv \
		$(RANK_DIR)/ranking-$(DATASET)-%-nel-only-micro-fuzzy-relaxed.tsv
	# Target $@ done

$(RANK_DIR)/ranking-$(DATASET)-%-coarse-micro-fuzzy-all.tsv:
	cat $(RES_DIR)/*_$(DATASET)_$*_*.tsv | head -n 1 | cut -f $(MICRO_RANKING_COLUMNS)  > $@
	grep -hs 'NE-COARSE.*micro-fuzzy.*ALL'  $(RES_DIR)/*_$(DATASET)_$*_*.tsv                      | sort -u -t$$'\t' -k2 | sort -t$$'\t' -k3,3 -k6,6r -k2,2 -k1,1 | cut -f $(MICRO_RANKING_COLUMNS) >> $@

$(RANK_DIR)/ranking-$(DATASET)-%-coarse-micro-strict-all.tsv:
	cat $(RES_DIR)/*_$(DATASET)_$*_*.tsv | head -n 1 | cut -f $(MICRO_RANKING_COLUMNS)  > $@
	grep -hs 'NE-COARSE.*micro-strict.*ALL' $(RES_DIR)/*_$(DATASET)_$*_*.tsv                      | sort -u -t$$'\t' -k2 | sort -t$$'\t' -k3,3 -k6,6r -k2,2 -k1,1 | cut -f $(MICRO_RANKING_COLUMNS) >> $@

$(RANK_DIR)/ranking-$(DATASET)-%-nel-micro-fuzzy-all.tsv:
	cat $(RES_DIR)/*_$(DATASET)_$*_*.tsv | head -n 1 | cut -f $(MICRO_RANKING_COLUMNS)  > $@
	grep -hs 'NEL.*micro-fuzzy' $(RES_DIR)/*_bundle{1..4}_$(DATASET)_$*_*.tsv | grep -v 'relaxed' | sort -u -t$$'\t' -k2 | sort -t$$'\t' -k3,3 -k6,6r -k2,2 -k1,1 | cut -f $(MICRO_RANKING_COLUMNS) >> $@

$(RANK_DIR)/ranking-$(DATASET)-%-nel-only-micro-fuzzy-all.tsv:
	cat $(RES_DIR)/*_$(DATASET)_$*_*.tsv | head -n 1 | cut -f $(MICRO_RANKING_COLUMNS)  > $@
	grep -hs 'NEL.*micro-fuzzy' $(RES_DIR)/*_bundle5_$(DATASET)_$*_*.tsv | grep -v 'relaxed'      | sort -u -t$$'\t' -k2 | sort -t$$'\t' -k2,2 -k6,6r -k2,2 -k1,1 | cut -f $(MICRO_RANKING_COLUMNS) >> $@

$(RANK_DIR)/ranking-$(DATASET)-%-nel-micro-fuzzy-relaxed.tsv:
	cat $(RES_DIR)/*_$(DATASET)_$*_*.tsv | head -n 1 | cut -f $(MICRO_RANKING_COLUMNS)  > $@
	grep -hs 'NEL.*micro-fuzzy' $(RES_DIR)/*_bundle{1..4}_$(DATASET)_$*_?_nel_relaxed.tsv  | sort -u -t$$'\t' -k2 | sort -t$$'\t' -k2,2 -k6,6r -k2,2 -k1,1 | cut -f $(MICRO_RANKING_COLUMNS) >> $@

$(RANK_DIR)/ranking-$(DATASET)-%-nel-only-micro-fuzzy-relaxed.tsv:
	cat $(RES_DIR)/*_$(DATASET)_$*_*.tsv | head -n 1 | cut -f $(MICRO_RANKING_COLUMNS)  > $@
	grep -hs 'NEL.*micro-fuzzy' $(RES_DIR)/*_bundle5_$(DATASET)_$*_?_nel_relaxed.tsv        | sort -u -t$$'\t' -k2 | sort -t$$'\t' -k2,2 -k6,6r -k2,2 -k1,1 | cut -f $(MICRO_RANKING_COLUMNS) >> $@
#NOT YET IMPLEMENTED	grep -hs 'NEL.*micro-fuzzy' $(RES_DIR)/*_bundle{1..4}_$(DATASET)_$*_?_relaxed.tsv | sort -t$$'\t' -k2,2 -k6,6r | (cat header.tmp && cat) > $(RANK_DIR)/ranking-$(DATASET)-$*-nel-micro-fuzzy-relaxed.tsv
#NOT YET IMPLEMENTED	grep -hs 'NEL.*micro-fuzzy' $(RES_DIR)/*_bundle5_$(DATASET)_$*_?_relaxed.tsv | sort -t$$'\t' -k2,2 -k6,6r | (cat header.tmp && cat) >



# produce the plots of the system performance on noisy and diachronic data also shown in the paper
plots-paper: ranking-de ranking-fr ranking-en
	python3 lib/eval_robustness.py --input-dir $(RANK_DIR) --output-dir $(EVAL_DIR)/robustness --log-file eval_robustness.log

eval-clean:
	rm -f $(RANK_DIR)/*
	rm -f $(SUB_TIMENORM_DIR)/*
	rm -f $(SUB_HISTOTIMENORM_DIR)/*
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
