# Paths.
MPLABDIR = "/opt/microchip/mplabx/v5.10/mplab_platform/bin"
MPCCDIR = "/opt/microchip/xc8/v2.00"

# Utilities.
RM = rm -f
MV = mv
MKDIR = mkdir -p

# Compilers and flags.
CC = xc8-cc
FIXDEPS = $(MPLABDIR)/fixDeps
CFLAGS = $(MPLAB_CFLAGS)
LDFLAGS = $(MPLAB_LDFLAGS)

# MPLAB X defaults.
MPLAB_CFLAGS = -fno-short-double -fno-short-float -O0 -fasmfile -maddrqual=ignore -xassembler-with-cpp -Wa,-a -msummary=-psect,-class,+mem,-hex,-file -ginhx032 -Wl,--data-init -mno-keep-startup -mno-osccal -mno-resetbits -mno-save-resetbits -mno-download -mno-stackcall -mno-stackcall -std=c99 -gdwarf-3 -mstack=compiled:auto:auto
MPLAB_LDFLAGS = -Wl,-Map=$(DISTDIR)/$(PROJECT).map -Wl,--defsym=__MPLAB_BUILD=1 -Wl,--memorysummary,$(DISTDIR)/memoryfile.xml

# File directories.
SRCDIR = src
OBJDIR = build
DISTDIR = dist

# Project.
NAME = blink
DEVICE = 12F683
PROJECT = $(NAME)-$(DEVICE)
SRC = blink.c
OBJ = $(patsubst %.c,$(OBJDIR)/%.p1,$(SRC))

all: $(DISTDIR)/$(PROJECT).hex

$(OBJDIR)/%.p1: $(SRCDIR)/%.c
	$(MKDIR) "$(OBJDIR)" 
	$(RM) $@ $@.d
	$(CC) -mcpu=$(DEVICE) -c $(CFLAGS) -o $@ $<
	$(MV) $(OBJDIR)/$*.d $@.d
	$(FIXDEPS) $(OBJDIR)/$*.d $(SILENT) -rsi $(MPCCDIR)

$(DISTDIR)/$(PROJECT).hex: $(OBJ)
	$(MKDIR) "$(DISTDIR)"
	$(CC) -mcpu=$(DEVICE) $(CFLAGS) $(LDFLAGS) -o $(DISTDIR)/$(PROJECT).hex $(OBJ)

clean:
	$(RM) -r $(OBJDIR)/
	$(RM) -r $(DISTDIR)/

#write:
#	$(PK2) -M -F$(PROJECT).hex
#
#on:
#	$(PK2) -T
#
#off:
#	$(PK2) -W
#
#erase:
#	$(PK2) -E

