TARGETS = echo1 echo2 echo3 echo4

.PHONY: all clean

all: $(TARGETS)

%: %.ll
	clang $< -o $@

clean:
	rm -f $(TARGETS)
