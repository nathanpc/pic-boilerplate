NAME = blink
DEVICE= 12f683
PROJECT = $(NAME)-$(DEVICE)
CC = picc --chip=$(DEVICE) -m --opt=all -g
PK2 = pk2cmd -PPIC$(DEVICE)

all: $(PROJECT).hex

blink-$(DEVICE).hex: blink.c
	$(CC) blink.c -O$(PROJECT)

write:
	$(PK2) -M -F$(PROJECT).hex

on:
	$(PK2) -T

off:
	$(PK2) -W

erase:
	$(PK2) -E

clean:
	rm -f *.o *.cod *.hex *.lst *.err *.as *.cof *.d *.hxl *.map *.p1 *.pre *.sdb *.sym funclist *.obj *.rlf

