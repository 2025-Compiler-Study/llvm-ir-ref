TARGETS = is_odd factorial functions

.PHONY: all clean

all: $(TARGETS)

%: %.ll
	clang $< -o $@

clean:
	rm -f $(TARGETS)
