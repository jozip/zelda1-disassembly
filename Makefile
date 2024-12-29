AS=./ext/ca65
LD=./ext/ld65
SRC=$(wildcard src/Z_*.asm)
TARGET=bin/Z.nes
RAW=bin/Z.bin
OBJ=$(patsubst src/%.asm,obj/%.o,$(SRC))
ORIGINAL=ext/Original.nes

all: dat $(TARGET) verify

$(TARGET): $(RAW)
	cat OriginalNesHeader.bin $(RAW) > $(TARGET)

$(RAW): $(OBJ)
	@mkdir -p $(dir $@)
	$(LD) -o $(RAW) -C src/Z.cfg $(OBJ) --dbgfile bin/Z.dbg

obj/%.o: src/%.asm
	@mkdir -p $(dir $@)
	$(AS) $< -o $@ --debug-info --bin-include-dir ./bin

dat: src/dat/*.dat

src/dat/*.dat:
	./extract-bins.sh src/bins.xml $(ORIGINAL)

verify:
	diff $(ORIGINAL) $(TARGET)

clean:
	rm -rf obj bin src/dat/*.dat

.PHONY: clean verify dat all
