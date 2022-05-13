
# for default
include Makefile


team1-submission-files := $(wildcard $(SUB_DIR)/team1*_?.tsv)
$(info team1-submission-files $(team1-submission-files))

team1-submission-fixed-files := $(team1-submission-files:.tsv=.fixed.tsv)
$(info team1-submission-fixed-files $(team1-submission-fixed-files))

team1-submission-fixed-target: $(team1-submission-fixed-files)

%.fixed.tsv: %.tsv
	perl -lane 'if (scalar(@F) == 10) {print;next;}; if (/^#|^\s*$$/) {print;} else {s/(\S+)$$/_\t\1/;print;} '  < $< > $@
	cp $@ $<


neural-submission-files := $(wildcard $(SUB_DIR)/neurbsl_bundle3_topres*_?.tsv)
$(info neural-submission-files $(neural-submission-files))

neural-submission-fixed-files := $(neural-submission-files:.tsv=.tsv.fixed)
$(info neural-submission-fixed-files $(neural-submission-fixed-files))

neural-submission-fixed-target: $(neural-submission-fixed-files)

%.tsv.fixed: %.tsv
	perl -CS -lane 'if (scalar(@F) == 10) {print;next;}; if (/^#|^\s*$$/) {print;next;};if (scalar(@F) == 9) {s/\t$$/\t_/;print;}  '  < $< > $@
	mv $@ $<

team3-submission-files := $(wildcard $(SUB_DIR)/team3*_?.tsv)
$(info team3-submission-files $(team3-submission-files))

team3-submission-fixed-files := $(team3-submission-files:.tsv=.tsv.fixed3)
$(info team3-submission-fixed-files $(team3-submission-fixed-files))

team3-submission-fixed-target: $(team3-submission-fixed-files)

%.tsv.fixed3: %.tsv
	perl -CS -lane 'if (/^#|^\s*$$/) {print;next;}; s/\s+$$//;if (scalar(@F) == 12) {s/\t\S+\t\S+$$//;print;next;};if (scalar(@F) == 9) {s/$$/\t_/;print;next};print;'  < $< > $@
	mv $@ $<


