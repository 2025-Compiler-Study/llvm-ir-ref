TARGETS = arith1 arith2

.PHONY: all clean

all: $(TARGETS)

%: %.ll
	clang $< -o $@

clean:
	rm -f $(TARGETS)
