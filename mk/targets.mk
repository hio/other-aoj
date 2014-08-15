
include ../../mk/config-default.mk
include ../../mk/config.mk

.PHONY: all build run check clean show
.PHONY: run-all build-all show-all clean-all check-all

all:   build
build: build-all
run:   run-all
check: check-all
clean: clean-all
show:  show-all

.PHONY: $(ALL_LANGS)
$(ALL_LANGS):
	$(MAKE) run-all TARGET_LANGS=$@

run-all: build-all
	for lang in $(TARGET_LANGS); \
	do \
		x=_build/$$lang/run-$(proj_name); \
		echo "+ $$x < data/input.1.txt" >&2; \
		$$x < data/input.1.txt || exit $$?; \
	done


check-all: build-all
	for lang in $(TARGET_LANGS); \
	do \
		for i in `seq 1 $(num_test_data)`; \
		do \
			x=_build/$$lang/run-$(proj_name); \
			echo "+ $$x < data/input.$$i.txt" >&2; \
			$$x < data/input.$$i.txt > _build/$$lang/output.$$i.txt || exit $$?; \
			diff -u data/result.$$i.txt _build/$$lang/output.$$i.txt || exit $$?; \
			echo "OK"; \
		done \
	done

show-all:
	more \
		$(proj_name).c    \
		$(proj_name).cpp  \
		$(ProjName).java  \
		$(ProjName).scala \
		$(ProjName).clj   \
		$(ProjName).cs    \
		$(proj_name).rb   \
		$(proj_name).py   \
		$(proj_name).php  \
		$(proj_name).js   \
		$(ProjName).hs    \
		$(proj_name).ml   \
		| cat

clean-all:
	rm -rf _build $(ProjName).cmi $(ProjName).cmo


# -----------------------------------------------------------------------------
# build.
#
_build: ; mkdir $@
$(TARGET_LANGS:%=_build/%): | _build; mkdir $@

build-all: $(TARGET_LANGS:%=_build/%/run-$(proj_name))

_build/c/run-$(proj_name): $(proj_name).c | _build/c
	gcc -Wall -Werror -g -O0 $^ -o $@.tmp
	mv -f $@.tmp $@

_build/cpp/run-$(proj_name): $(proj_name).cpp | _build/cpp
	g++ -Wall -Werror -g -O0 $^ -o $@.tmp
	mv -f $@.tmp $@

_build/java/run-$(proj_name): $(ProjName).java | _build/java
	javac -d _build/java $^
	echo "#! /bin/sh" > $@.tmp
	echo "set -x" >> $@.tmp
	echo "java -classpath \`dirname \$$0\` $(ProjName)" >> $@.tmp
	chmod 755 $@.tmp
	mv $@.tmp $@

_build/scala/run-$(proj_name): $(ProjName).scala | _build/scala
	JAVACMD="$(JAVA)" $(SCALAC) -d _build/scala $^
	echo "#! /bin/sh" > $@.tmp
	echo "set -x" >> $@.tmp
	echo "JAVACMD=\"$(JAVA)\" $(SCALA) -classpath \`dirname \$$0\` $(ProjName)" >> $@.tmp
	chmod 755 $@.tmp
	mv $@.tmp $@

_build/clojure/run-$(proj_name): $(proj_name).pl | _build/clojure
	$(MAKE) FILE=$@ INTERP="$(JAVA) -classpath $(CLOJURE) clojure.main" EXT=clj gen-script

_build/csharp/run-$(proj_name): $(ProjName).cs | _build/csharp
	gmcs $^ -out:_build/csharp/$(ProjName).exe
	echo "#! /bin/sh" > $@.tmp
	echo "set -x" >> $@.tmp
	echo "mono \`dirname \$$0\`/$(ProjName).exe" >> $@.tmp
	chmod 755 $@.tmp
	mv $@.tmp $@

_build/perl/run-$(proj_name): $(proj_name).pl | _build/perl
	perl -c $^ < /dev/null
	$(MAKE) FILE=$@ INTERP=perl EXT=pl gen-script

_build/ruby/run-$(proj_name): $(proj_name).rb | _build/ruby
	ruby -c $^ < /dev/null
	$(MAKE) FILE=$@ INTERP=ruby EXT=rb gen-script

_build/python/run-$(proj_name): $(proj_name).py | _build/python
	$(MAKE) FILE=$@ INTERP=python EXT=py gen-script

_build/php/run-$(proj_name): $(proj_name).php | _build/php
	$(MAKE) FILE=$@ INTERP=php EXT=php gen-script

_build/javascript/run-$(proj_name): $(proj_name).js | _build/javascript
	$(MAKE) FILE=$@ INTERP=$(NODE) EXT=js gen-script

_build/haskell/run-$(proj_name): $(ProjName).hs | _build/haskell
	ghc --make -odir _build/haskell -hidir _build/haskell \
		$^ -main-is $(ProjName).main -o $@.tmp
	mv -f $@.tmp $@

_build/ocaml/run-$(proj_name): $(proj_name).ml | _build/ocaml
	$(OCAMLC) $< -o $@.tmp
	mv -f $(proj_name).cmi $(proj_name).cmo $(@D)/
	mv -f $@.tmp $@

_build/erlang/run-$(proj_name): $(proj_name).ml | _build/erlang
	$(MAKE) FILE=$@ INTERP=$(ESCRIPT) EXT=escript gen-script


gen-script:
	echo "#! /bin/sh" > $(FILE).tmp
	echo "set -x" >> $(FILE).tmp
	echo "$(INTERP) $(proj_name).$(EXT)" >> $(FILE).tmp
	chmod 755 $(FILE).tmp
	mv $(FILE).tmp $(FILE)
