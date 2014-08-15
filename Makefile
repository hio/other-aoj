
.PHONY: all build check clean

all:
	@echo "usage: make build"
	@echo "usage: make check"
	@echo "usage: make clean"

build check clean:
	for d in vol-100/[0-9]*/; \
	do \
		make -C $$d $@ || exit $$?; \
	done
