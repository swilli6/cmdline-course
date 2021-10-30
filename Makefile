BOOKS=alice christmas_carol dracula frankenstein heart_of_darkness life_of_bee moby_dick modest_propsal pride_and_prejudice tale_of_two_cities ulysses

FREQLISTS=$(BOOKS:%=results/%.freq.txt)
SENTEDBOOKS=$(BOOKS:%=results/%.sent.txt)
MAKENOMD=$(BOOKS:%=results/%.no_md.txt)
ALLFREQ=results/all.freq.txt
ALLSENT=results/all.sent.txt

all: $(FREQLISTS) $(SENTEDBOOKS) $(MAKENOMD) $(ALLSENT) $(ALLFREQ)

clean:
	rm -f results/* data/*no_md.txt

%.no_md.txt: %.txt
	python3 src/remove_gutenberg_metadata.py $< $@

results/%.freq.txt: data/%.no_md.txt
	src/freqlist.sh $< $@

results/%.sent.txt: data/%.no_md.txt
	src/sent_per_line.sh $< $@

results/%.no_md.txt: data/%.txt
	python src/remove_gutenberg_metadata.py $< $@

data/all.no_md.txt: results/*no_md.txt
	cat $^ > $@

results/all.freq.txt: results/all.sent.txt
	src/freqlist.sh $< $@

results/all.sent.txt: results/*sent.txt
	cat $^ > $@
