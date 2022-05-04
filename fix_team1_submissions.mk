
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
