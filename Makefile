DIRS = 01-hello 02-echo 03-arithmetic 04-expression \
       05-conditional 06-loop 07-function 08-recursion

.PHONY: all clean

all:
	@for d in $(DIRS); do \
		echo "=== $$d ==="; \
		$(MAKE) -C $$d; \
	done

clean:
	@for d in $(DIRS); do \
		$(MAKE) -C $$d clean; \
	done
