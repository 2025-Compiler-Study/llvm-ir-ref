TARGET = hello
SRC    = hello.ll

.PHONY: all run clean

all: $(TARGET)

$(TARGET): $(SRC)
	clang $(SRC) -o $(TARGET)

run: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(TARGET)
