SHELL:=/bin/bash

############################################################################################
# SYSTEM EVALUATION (START OF OPEN-SOURCE PART)
############################################################################################


SCORER_DIR?=HIPE-scorer # ME: updated
EVAL_DIR?=evaluation # ME: updated
SUB_DIR?=$(EVAL_DIR)/system-responses/submitted
SUB_TIMENORM_DIR?=$(EVAL_DIR)/system-responses/time-normalized
SUB_HISTONORM_DIR?=$(EVAL_DIR)/system-responses/histo-normalized
RES_DIR?=$(EVAL_DIR)/system-evaluations
EVAL_LOGS_DIR?=$(EVAL_DIR)/system-evaluation-logs
RANK_DIR?=$(EVAL_DIR)/system-rankings

# copy this file manually from here and remove spaces in file name:
# https://docs.google.com/spreadsheets/d/1s2BpIeiqsJIjHLsIecshrHG9UFkMBW1Nfr-h68AB2pY/edit#gid=1606475364
FILE_NEL_MAPPING?=$(SCORER_DIR)/historico-fuzzy-QID-mapping-ID-mapping.tsv

DE-GOLD-FILE?=$(RELEASE_DIR)/$(VERSION)/de/HIPE-data-$(VERSION)-test-de.tsv # ME: not sure these 3 lines are used
FR-GOLD-FILE?=$(RELEASE_DIR)/$(VERSION)/fr/HIPE-data-$(VERSION)-test-fr.tsv
EN-GOLD-FILE?=$(RELEASE_DIR)/$(VERSION)/en/HIPE-data-$(VERSION)-test-en.tsv

EVAL_NOISE_LEVEL?=0.0-0.0,0.001-0.1,0.1-0.3,0.3-1.1
EVAL_TIME_PERIOD_FR?=1790-1810,1810-1830,1830-1850,1850-1870,1870-1890,1890-1910,1910-1930,1930-1950,1950-1970,1970-1990,1990-2010,2010-2030
EVAL_TIME_PERIOD_DE?=1790-1810,1810-1830,1830-1850,1850-1870,1870-1890,1890-1910,1910-1930,1930-1950,1950-1970
EVAL_TIME_PERIOD_EN?=1790-1900,1900-1970


prepare-eval:
	mkdir -p $(SUB_DIR)
	mkdir -p $(SUB_TIMENORM_DIR)
	mkdir -p $(SUB_HISTONORM_DIR)
	mkdir -p $(RES_DIR)
	mkdir -p $(EVAL_LOGS_DIR)
	mkdir -p $(RANK_DIR)

# TEAMNAME_TASKBUNDLEID_LANG_RUNNUMBER.tsv
submission-files:=$(wildcard $(SUB_DIR)/*bundle$(BUNDLE)*.tsv)

# produce normalized version of system responses
# versions: time, historical+time
submission-timenorm-files:=$(subst $(SUB_DIR),$(SUB_TIMENORM_DIR),$(submission-files))
submission-histonorm-files:=$(subst $(SUB_DIR),$(SUB_HISTONORM_DIR),$(submission-files))

# produce normalized version of gold standard
# version: historical
gold-files:=$(wildcard $(RELEASE_DIR)/$(VERSION)/*/*test-??.tsv)
gold-histonorm-files:=$(gold-files:.tsv=_histonorm.tsv)

result-timenorm-files:=$(subst $(SUB_TIMENORM_DIR),$(RES_DIR),$(submission-timenorm-files))
result-histonorm-files:=$(subst $(SUB_HISTONORM_DIR),$(RES_DIR),$(submission-histonorm-files:.tsv=_relaxed.tsv))

eval-system-bundle: $(submission-timenorm-files) $(result-timenorm-files) $(submission-histonorm-files) $(result-histonorm-files)

eval-full: $(gold-histonorm-files) baseline-nerc eval-clean eval-system ranking-de ranking-fr ranking-en ranking-fine-de ranking-fine-fr plots-paper #rankings-summary

eval-system: prepare-eval
	$(MAKE) eval-system-bundle BUNDLE=1
	$(MAKE) eval-system-bundle BUNDLE=2
	$(MAKE) eval-system-bundle BUNDLE=3
	$(MAKE) eval-system-bundle BUNDLE=4
	$(MAKE) eval-system-bundle BUNDLE=5

# normalize NEL for historical entities in gold standard
%_histonorm.tsv: %.tsv
	python $(SCORER_DIR)/normalize_linking.py -i $< -o $@ --norm-histo -m $(FILE_NEL_MAPPING)

# normalize NEL for time mentions in system responses
$(SUB_TIMENORM_DIR)/%.tsv: $(SUB_DIR)/%.tsv
	python $(SCORER_DIR)/normalize_linking.py -i $< -o $@ --norm-time

# normalize NEL for historical entities and time mentions in system responses
$(SUB_HISTONORM_DIR)/%.tsv: $(SUB_DIR)/%.tsv
	python $(SCORER_DIR)/normalize_linking.py -i $< -o $@ --norm-time --norm-histo -m $(FILE_NEL_MAPPING)


# standard evaluation
# with dirty runtime hacks to conditionally evaluate on a particular language and bundle
# the language is also used to determine the time buckets conditionally
$(RES_DIR)/%.tsv: $(SUB_TIMENORM_DIR)/%.tsv $(gold-files)
	@$(eval LANG_ABBR=$(shell echo $< | grep -Po '(?<=_)[a-z]{2}(?=_[0-3])'))
	@$(eval PERIOD=$(shell if [ "en" == $(LANG_ABBR) ]; then echo $(EVAL_TIME_PERIOD_EN); elif [ "de" == $(LANG_ABBR) ]; then echo $(EVAL_TIME_PERIOD_DE); else echo $(EVAL_TIME_PERIOD_FR); fi))

ifeq ($(BUNDLE),1)
	python $(SCORER_DIR)/clef_evaluation.py --ref $(RELEASE_DIR)/$(VERSION)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR).tsv --pred $< --task nerc_coarse --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nerc_coarse.log) --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
	python $(SCORER_DIR)/clef_evaluation.py --ref $(RELEASE_DIR)/$(VERSION)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR).tsv --pred $< --task nerc_fine --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nerc_fine.log) --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
	python $(SCORER_DIR)/clef_evaluation.py --ref $(RELEASE_DIR)/$(VERSION)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR).tsv --pred $< --task nel --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
else ifeq ($(BUNDLE),2)
	python $(SCORER_DIR)/clef_evaluation.py --ref $(RELEASE_DIR)/$(VERSION)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR).tsv --pred $< --task nerc_coarse --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nerc_coarse.log) --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
	python $(SCORER_DIR)/clef_evaluation.py --ref $(RELEASE_DIR)/$(VERSION)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR).tsv --pred $< --task nel --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
else ifeq ($(BUNDLE),3)
	python $(SCORER_DIR)/clef_evaluation.py --ref $(RELEASE_DIR)/$(VERSION)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR).tsv --pred $< --task nerc_coarse --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nerc_coarse.log) --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
	python $(SCORER_DIR)/clef_evaluation.py --ref $(RELEASE_DIR)/$(VERSION)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR).tsv --pred $< --task nerc_fine --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nerc_fine.log) --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
else ifeq ($(BUNDLE),4)
	python $(SCORER_DIR)/clef_evaluation.py --ref $(RELEASE_DIR)/$(VERSION)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR).tsv --pred $< --task nerc_coarse --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nerc_coarse.log) --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
else ifeq ($(BUNDLE),5)
	python $(SCORER_DIR)/clef_evaluation.py --ref $(RELEASE_DIR)/$(VERSION)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR).tsv --pred $< --task nel --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
endif

# NEL evaluation on historically normalized system and gold datasets
$(RES_DIR)/%_relaxed.tsv: $(SUB_HISTONORM_DIR)/%.tsv $(gold-histonorm-files)
	@$(eval LANG_ABBR=$(shell echo $< | grep -Po '(?<=_)[a-z]{2}(?=_[0-3])'))
	@$(eval PERIOD=$(shell if [ "en" == $(LANG_ABBR) ]; then echo $(EVAL_TIME_PERIOD_EN); elif [ "de" == $(LANG_ABBR) ]; then echo $(EVAL_TIME_PERIOD_DE); else echo $(EVAL_TIME_PERIOD_FR); fi))

ifeq ($(BUNDLE),1)
	python $(SCORER_DIR)/clef_evaluation.py --ref $(RELEASE_DIR)/$(VERSION)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR)_histonorm.tsv --pred $< --task nel --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --suffix relaxed --n_best 1,3,5 --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
else ifeq ($(BUNDLE),2)
	python $(SCORER_DIR)/clef_evaluation.py --ref $(RELEASE_DIR)/$(VERSION)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR)_histonorm.tsv --pred $< --task nel --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --suffix relaxed --n_best 1,3,5 --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
else ifeq ($(BUNDLE),5)
	python $(SCORER_DIR)/clef_evaluation.py --ref $(RELEASE_DIR)/$(VERSION)/$(LANG_ABBR)/HIPE-data-$(VERSION)-test-$(LANG_ABBR)_histonorm.tsv --pred $< --task nel --outdir $(RES_DIR) --log $(EVAL_LOGS_DIR)/$(@F:.tsv=.nel.log) --suffix relaxed --n_best 1,3,5 --tagset $(SCORER_DIR)/tagset.txt --noise-level $(EVAL_NOISE_LEVEL) --time-period $(PERIOD)
endif



# produce rankings per language, task, sorted by F1-score of micro fuzzy across labels
# bundle 5 goes into separate table as they have gold annotations
# English has no fine annotation, other than German and French
ranking-%: $(result-files) $(result-norm-files) $(gold-norm-files) $(normalized-files)
	head -q -n1 $(RES_DIR)/*_$*_*.tsv | head -1 > header.tmp
	grep -hs 'NE-COARSE.*micro-fuzzy.*ALL' $(RES_DIR)/*_$*_*.tsv | sort -t$$'\t' -k2,2 -k6,6r | (cat header.tmp && cat) > $(RANK_DIR)/ranking-$*-coarse-micro-fuzzy-all.tsv
	grep -hs 'NE-COARSE.*micro-strict.*ALL' $(RES_DIR)/*_$*_*.tsv | sort -t$$'\t' -k2,2 -k6,6r | (cat header.tmp && cat) > $(RANK_DIR)/ranking-$*-coarse-micro-strict-all.tsv
	grep -hs 'NEL.*micro-fuzzy' $(RES_DIR)/*_bundle{1..4}_$*_*.tsv | grep -v 'relaxed' | sort -t$$'\t' -k2,2 -k6,6r | (cat header.tmp && cat) > $(RANK_DIR)/ranking-$*-nel-micro-fuzzy.tsv
	grep -hs 'NEL.*micro-fuzzy' $(RES_DIR)/*_bundle5_$*_*.tsv | grep -v 'relaxed' | sort -t$$'\t' -k2,2 -k6,6r | (cat header.tmp && cat) > $(RANK_DIR)/ranking-$*-nel-only-micro-fuzzy.tsv
	grep -hs 'NEL.*micro-fuzzy' $(RES_DIR)/*_bundle{1..4}_$*_*_relaxed.tsv | sort -t$$'\t' -k2,2 -k6,6r | (cat header.tmp && cat) > $(RANK_DIR)/ranking-$*-nel-micro-fuzzy-relaxed.tsv
	grep -hs 'NEL.*micro-fuzzy' $(RES_DIR)/*_bundle5_$*_*_relaxed.tsv | sort -t$$'\t' -k2,2 -k6,6r | (cat header.tmp && cat) > $(RANK_DIR)/ranking-$*-nel-only-micro-fuzzy-relaxed.tsv
	rm header.tmp
ranking-fine-%: $(result-files) $(result-norm-files) $(gold-norm-files) $(normalized-files)
	head -q -n1 $(RES_DIR)/*_$*_*.tsv | head -1 > header.tmp
	grep -Phs '(NE-FINE|NE-NESTED).*micro-fuzzy.*ALL' $(RES_DIR)/*_$*_*.tsv | sort -t$$'\t' -k2,2 -k6,6r | (cat header.tmp && cat) > $(RANK_DIR)/ranking-$*-fine-micro-fuzzy-all.tsv
	grep -Phs '(NE-FINE|NE-NESTED).*micro-strict.*ALL' $(RES_DIR)/*_$*_*.tsv | sort -t$$'\t' -k2,2 -k6,6r | (cat header.tmp && cat) > $(RANK_DIR)/ranking-$*-fine-micro-strict-all.tsv
	rm header.tmp


# produce the plots of the system performance on noisy and diachronic data also shown in the paper
plots-paper: ranking-de ranking-fr ranking-en
	python lib/eval_robustness.py --input-dir $(RANK_DIR) --output-dir $(EVAL_DIR)/robustness --log-file eval_robustness.log

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
	python lib/format_rankings_summary.py --input-dir=$(RANK_DIR) --output-dir=$(RANK_DIR)

# requires https://github.com/ekalinin/github-markdown-toc
rankings-summary-ToC:
	gh-md-toc --insert $(RANK_DIR)/ranking_summary.md


############################################################################################
### Aggregate system responses to improve gold standard
############################################################################################

aggr-responses-all: aggr-responses-de.txt aggr-responses-fr.txt aggr-responses-en.txt
aggr-responses-%.txt:
	python lib/aggregate_system_responses.py --input_dir $(SUB_DIR) --gold_file $(RELEASE_DIR)/$(VERSION)/$*/HIPE-data-$(VERSION)-test-$*.tsv --log $(EVAL_DIR)/$@ --threshold 0.5