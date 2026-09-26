TARGETS = factorial sum

.PHONY: all clean

all: $(TARGETS)

%: %.ll
	clang $< -o $@

clean:
	rm -f $(TARGETS)
