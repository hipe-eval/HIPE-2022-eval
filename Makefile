SHELL:=/bin/bash
.SECONDARY:

help:
	# make eval-full           # build everything
	# make eval-full-refresh   # clean all derived files, then build everything from scratch


############################################################################################
# CONFIGURATION PART
############################################################################################

# emit additional diagnostics output on the matched files
DEBUG ?= 0

# force build
# set to -B to force the recursive make builds
FORCE_BUILD ?=

# currently set to provisional (until the full test data is available from the repository)
RELEASE_DIR ?= HIPE-2022-data-provisional/data
VERSION ?= v2.1
GROUND_TRUTH_DIR ?= $(RELEASE_DIR)/$(VERSION)

SCORER_DIR?=HIPE-scorer
EVAL_DIR?=evaluation
#:
#EVALUATION_N_BEST_OPTION ?= --n_best 1,3,5
EVALUATION_N_BEST_OPTION ?= --n_best 1,3,5

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



############################################################################################
# Main evaluation build goals
############################################################################################

#: Build everything
eval-full: prepare-eval eval-system-bundles ranking-alldatasets-alllanguages rankings-summary

#: Build completely from scratch
eval-full-refresh: eval-clean
	$(MAKE) eval-full

#: Build all system submission evaluation outputs per dataset with all details
eval-system-bundles: \
	eval-system-bundles-hipe2020 \
	eval-system-bundles-newseye \
	eval-system-bundles-sonar \
	eval-system-bundles-letemps \
	eval-system-bundles-topres19th \
	eval-system-bundles-ajmc

#: Build called in the recursive build process
eval-system-bundle: build-gold-histonorm-files build-submission-histonorm-files build-evaluation-nonorm-done-files build-evaluation-histonorm-done-files

#: Recursive build that instantiates all bundle dataset combinations
eval-system-bundles-%: prepare-eval
	$(MAKE) -k eval-system-bundle BUNDLE=1 DATASET=$* $(FORCE_BUILD)
	$(MAKE) -k eval-system-bundle BUNDLE=2 DATASET=$* $(FORCE_BUILD)
	$(MAKE) -k eval-system-bundle BUNDLE=3 DATASET=$* $(FORCE_BUILD)
	$(MAKE) -k eval-system-bundle BUNDLE=4 DATASET=$* $(FORCE_BUILD)
	$(MAKE) -k eval-system-bundle BUNDLE=5 DATASET=$* $(FORCE_BUILD)

#: Empty all derived data material (removes also material under git revision)
eval-clean:
	rm -f $(RANK_DIR)/*
	rm -f $(SUB_TIMENORM_DIR)/*
	rm -f $(SUB_HISTOTIMENORM_DIR)/*
	rm -f $(RES_DIR)/*
	rm -f $(EVAL_LOGS_DIR)/*
	rm -f $(gold-histonorm-files)

#: Remove the .done file stamps only for a less intrusive cleaning
done-clean:
	rm -vf $(evaluation-nonorm-done-files) $($(evaluation-timenorm-done-files) $(evaluation-histonorm-done-files)

############################################################################################
# Main ranking build goals
############################################################################################

#: Build the specific main ranking files by recursive make calls
ranking-alldatasets-alllanguages: eval-system-bundles
	# RANKING COARSE
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


#: create evaluation directories
prepare-eval:
	mkdir -p $(SUB_DIR) $(SUB_TIMENORM_DIR) $(SUB_HISTOTIMENORM_DIR) $(RES_DIR) $(EVAL_LOGS_DIR) $(RANK_DIR)


############################################################################################
# Groundtruth files and their automatically generated normalized variants
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

############################################################################################
# Dealing with submissions and derived variants
#   - TEAMNAME_TASKBUNDLE_DATASET_LANG_RUN.tsv
############################################################################################

#: List of submitted runs
submission-files := $(wildcard $(SUB_DIR)/*bundle$(BUNDLE)_$(DATASET)*.tsv)
ifeq ($(DEBUG),1)
$(info )
$(info  # INFO: submission-files: $(submission-files))
$(info )
endif

# produce normalized version of system responses
#: List of variant submission run files to be generated by time normalization (NOT USED in 2022)
submission-timenorm-files := $(subst $(SUB_DIR),$(SUB_TIMENORM_DIR),$(submission-files))

# normalize NEL for time mentions in system responses
$(SUB_TIMENORM_DIR)/%.tsv: $(SUB_DIR)/%.tsv
	python3 $(SCORER_DIR)/normalize_linking.py -i $< -o $@ --norm-time -e hipe-2022
	@echo "TIMENORM CHANGED LINES in $< $$(diff -wy --suppress-common-lines $@ $< | wc -l)" | tee  $@.log

# produce normalized version of system responses
#: List of variant run files to be generated by QID normalization/relaxation
submission-histonorm-files := $(subst $(SUB_DIR),$(SUB_HISTOTIMENORM_DIR),$(submission-files))
ifeq ($(DEBUG),1)
$(info )
$(info submission-histonorm-files: $(submission-histonorm-files))
$(info )
endif

#: Build historically normalized version of submission files in $(SUB_HISTOTIMENORM_DIR)
build-submission-histonorm-files: $(submission-histonorm-files)

clean-submission-histonorm-files:
	rm -fv $(clean-submission-histonorm-files)

# normalize NEL for historical entities and time mentions in system responses
$(SUB_HISTOTIMENORM_DIR)/%.tsv: $(SUB_DIR)/%.tsv
	python3 $(SCORER_DIR)/normalize_linking.py -i $< -o $@ --norm-time --norm-histo -m $(FILE_NEL_MAPPING) -e hipe-2022
	@echo "HISTOTIMENORM CHANGED LINES in $< $$(diff -wy --suppress-common-lines $@ $< | wc -l)" | tee  $@.log

############################################################################################
# Creating evaluation output for submitted runs
#  - a bundle can produce several evaluation files (ner_coarse, ner_fine, nel, ...) therefore a .done file guides the process
#
############################################################################################

#: the evaluation done files
# Each .done-file stamp confirms that all bundle-specific evaluation files have been produced.
evaluation-nonorm-done-files := $(subst $(SUB_DIR),$(RES_DIR),$(submission-files:.tsv=.done))
ifeq ($(DEBUG),1)
$(info )
$(info evaluation-nonorm-done-files: $(evaluation-nonorm-done-files))
$(info )
endif

build-evaluation-nonorm-done-files: $(evaluation-nonorm-done-files)
clean-evaluation-nonorm-done-files:
	rm -fv $(evaluation-nonorm-done-files)


# Raw evaluation without any modifications depending on BUNDLE variable
$(RES_DIR)/%.done: $(SUB_DIR)/%.tsv
ifeq ($(BUNDLE),1)
	# NERC-Coarse  BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nerc_coarse --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
		--pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.done=.nerc_coarse.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt --hipe_edition hipe-2022
	# NERC-Fine    BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nerc_fine --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
		--pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.done=.nerc_fine.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt --hipe_edition hipe-2022
	# NEL-end-to-end BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nel --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
	    --pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.done=.nel.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt  --hipe_edition hipe-2022
	touch $@
else ifeq ($(BUNDLE),2)
	# NERC-Coarse  BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nerc_coarse --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
		--pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.done=.nerc_coarse.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt --hipe_edition hipe-2022
	# NEL-end-to-end BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nel --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
	    --pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.done=.nel.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt  --hipe_edition hipe-2022
	touch $@
else ifeq ($(BUNDLE),3)
	# NERC-Coarse  BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nerc_coarse --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
		--pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.done=.nerc_coarse.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt --hipe_edition hipe-2022
	python3 $(SCORER_DIR)/clef_evaluation.py --task nerc_fine --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
		--pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.done=.nerc_fine.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt --hipe_edition hipe-2022
	touch $@
else ifeq ($(BUNDLE),4)
	# NERC-Coarse  BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nerc_coarse --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
		--pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.done=.nerc_coarse.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt --hipe_edition hipe-2022
	touch $@
else ifeq ($(BUNDLE),5)
	# NEL-only BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nel --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F)).tsv \
	    --pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.done=.nel.log) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt  --hipe_edition hipe-2022
	touch $@
endif

############################################################################################
# Creating time-normalized evaluation (NOT USED in 2022)
############################################################################################

#: Fix time NEL only. Actually not relevant for hipe-2022 submissions
evaluation-timenorm-done-files := $(subst $(SUB_TIMENORM_DIR),$(RES_DIR),$(submission-timenorm-files:.tsv=.done))
ifeq ($(DEBUG),1)
$(info )
$(info evaluation-timenorm-done-files: $(evaluation-timenorm-done-files))
$(info )
endif

build-evaluation-timenorm-done-files: $(evaluation-timenorm-done-files)


############################################################################################
# Creating histo-time-normalized evaluation
############################################################################################

#: Normalized time and historical QID variants (relevant in NEL only)
# The histo-normalized submission evaluations used for the separate relaxed NEL evaluation
evaluation-histonorm-done-files := $(subst $(SUB_HISTOTIMENORM_DIR),$(RES_DIR),$(submission-histonorm-files:.tsv=_relaxed.done))
ifeq ($(DEBUG),1)
$(info )
$(info evaluation-histonorm-done-files: $(evaluation-histonorm-done-files))
$(info )
endif


build-evaluation-histonorm-done-files: $(evaluation-histonorm-done-files)

clean-evaluation-histonorm-done-files:
	rm -fv $(evaluation-histonorm-done-files)

# More specific rule must come first
build-fine-ranking-$(DATASET)-%: \
	$(RANK_DIR)/ranking-$(DATASET)-%-fine-micro-fuzzy-all.tsv \
	$(RANK_DIR)/ranking-$(DATASET)-%-fine-micro-strict-all.tsv
	# $@ Done

# NEL evaluation on historically normalized system and gold datasets
$(RES_DIR)/%_relaxed.done: $(SUB_HISTOTIMENORM_DIR)/%.tsv
	# STARTING RELAXED EVALUTAION $@
ifeq ($(BUNDLE),1)
	# Relaxed NEL-end-to-end BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nel --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F))_histonorm.tsv \
	    --pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.done=.nel.log) --suffix relaxed $(EVALUATION_N_BEST_OPTION) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt  --hipe_edition hipe-2022
	touch $@
else ifeq ($(BUNDLE),2)
	# Relaxed NEL-end-to-end BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nel --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F))_histonorm.tsv \
	    --pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.done=.nel.log) --suffix relaxed $(EVALUATION_N_BEST_OPTION) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt  --hipe_edition hipe-2022
	touch $@
#	python3 $(SCORER_DIR)/clef_evaluation.py --hipe_edition hipe-2022 --ref $(GROUND_TRUTH_DIR)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR)_histonorm.tsv --pred $< --task nel --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --suffix relaxed $(EVALUATION_N_BEST_OPTION) --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
else ifeq ($(BUNDLE),5)
	# Relaxed NEL-only BUNDLE $(BUNDLE) DATASET $(DATASET)
	python3 $(SCORER_DIR)/clef_evaluation.py --task nel --ref $(GROUND_TRUTH_DIR)/HIPE-2022-$(VERSION)-$(DATASET)-test-$(call submission_lang,$(<F))_histonorm.tsv \
	    --pred $< --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.done=.nel.log) --suffix relaxed $(EVALUATION_N_BEST_OPTION) --tagset $(SCORER_DIR)/tagset-hipe2022-all.txt  --hipe_edition hipe-2022
	touch $@
#	python3 $(SCORER_DIR)/clef_evaluation.py --hipe_edition hipe-2022 --ref $(GROUND_TRUTH_DIR)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR)_histonorm.tsv --pred $< --task nel --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --suffix relaxed $(EVALUATION_N_BEST_OPTION)  --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
endif
	# Not applicable for BUNDLE $(BUNDLE)


############################################################################################
# Ranking the systems based on their evaluation files
# - only the most relevant analytics are used
# - more detailed information can be found in the runs
############################################################################################

$(RANK_DIR)/ranking-$(DATASET)-%-fine-micro-fuzzy-all.tsv:
	cat $(RES_DIR)/*_$(DATASET)_$*_*.tsv | head -n 1 | cut -f $(MICRO_RANKING_COLUMNS) > $@
	grep -Ehs '(NE-FINE|NE-NESTED).*micro-fuzzy.*ALL' $(RES_DIR)/*_$(DATASET)_$*_*.tsv | cut -f $(MICRO_RANKING_COLUMNS) | sort -u -t$$'\t' -k2 | sort -t$$'\t' -k3,3 -k6,6r -k2,2 -k1,1 >> $@

$(RANK_DIR)/ranking-$(DATASET)-%-fine-micro-strict-all.tsv:
	cat $(RES_DIR)/*_$(DATASET)_$*_*.tsv | head -n 1 | cut -f $(MICRO_RANKING_COLUMNS) > $@
	grep -Ehs '(NE-FINE|NE-NESTED).*micro-strict.*ALL' $(RES_DIR)/*_$(DATASET)_$*_*.tsv| cut -f $(MICRO_RANKING_COLUMNS) | sort -u -t$$'\t' -k2 | sort -t$$'\t' -k3,3 -k6,6r -k2,2 -k1,1 >> $@



# produce rankings per language, task, sorted by F1-score of micro fuzzy across labels
# bundle 5 goes into separate table as they have gold annotations
# English has no fine annotation, other than German and French
build-ranking-$(DATASET)-%:  \
		$(RANK_DIR)/ranking-$(DATASET)-%-coarse-micro-fuzzy-all.tsv \
		$(RANK_DIR)/ranking-$(DATASET)-%-coarse-micro-strict-all.tsv \
		$(RANK_DIR)/ranking-$(DATASET)-%-nel-micro-fuzzy-all.tsv \
		$(RANK_DIR)/ranking-$(DATASET)-%-nel-only-micro-fuzzy-all.tsv \
		$(RANK_DIR)/ranking-$(DATASET)-%-nel-micro-fuzzy-relaxed-all.tsv \
		$(RANK_DIR)/ranking-$(DATASET)-%-nel-only-micro-fuzzy-relaxed-all.tsv
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

$(RANK_DIR)/ranking-$(DATASET)-%-nel-micro-fuzzy-relaxed-all.tsv:
	cat $(RES_DIR)/*_$(DATASET)_$*_*.tsv | head -n 1 | cut -f $(MICRO_RANKING_COLUMNS)  > $@
	grep -hs 'NEL.*micro-fuzzy' $(RES_DIR)/*_bundle{1..4}_$(DATASET)_$*_?_nel_relaxed.tsv  | sort -u -t$$'\t' -k2 | sort -t$$'\t' -k2,2 -k6,6r -k2,2 -k1,1 | cut -f $(MICRO_RANKING_COLUMNS) >> $@

$(RANK_DIR)/ranking-$(DATASET)-%-nel-only-micro-fuzzy-relaxed-all.tsv:
	cat $(RES_DIR)/*_$(DATASET)_$*_*.tsv | head -n 1 | cut -f $(MICRO_RANKING_COLUMNS)  > $@
	grep -hs 'NEL.*micro-fuzzy' $(RES_DIR)/*_bundle5_$(DATASET)_$*_?_nel_relaxed.tsv        | sort -u -t$$'\t' -k2 | sort -t$$'\t' -k2,2 -k6,6r -k2,2 -k1,1 | cut -f $(MICRO_RANKING_COLUMNS) >> $@

############################################################################################
# Legacy material from 2022
############################################################################################

# produce the plots of the system performance on noisy and diachronic data also shown in the paper
plots-paper: ranking-de ranking-fr ranking-en
	python3 lib/eval_robustness.py --input-dir $(RANK_DIR) --output-dir $(EVAL_DIR)/robustness --log-file eval_robustness.log



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
