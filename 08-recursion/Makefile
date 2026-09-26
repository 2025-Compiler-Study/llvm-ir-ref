TARGETS = factorial is_odd is_odd_noopt

.PHONY: all clean

all: $(TARGETS)

%: %.ll
	clang $< -o $@

clean:
	rm -f $(TARGETS)
