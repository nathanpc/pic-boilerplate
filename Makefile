#####################################################
# Microchip PIC Makefile boilerplate.               #
#                                                   #
# Author: Nathan Campos <nathan@innoveworkshop.com> #
#####################################################

# Project definitions.
NAME = blink
DEVICE = 12F683
PROJECT = $(NAME)-$(DEVICE)
SRC = main.c

# IPE flags. (For more information run "make ipe_help")
TOOL = PPK3
IPEFLAGS = -W

# Paths to MPLAB X and the XC compiler.
MPLABDIR = /opt/microchip/mplabx/v5.10/mplab_platform/bin
IPEDIR = /opt/microchip/mplabx/v5.10/mplab_platform/mplab_ipe
MPCCDIR = /opt/microchip/xc8/v2.00

# Program definitions.
CC = xc8-cc
RM = rm -f
MV = mv
MKDIR = mkdir -p
FIXDEPS = $(MPLABDIR)/fixDeps
IPE = java -jar $(IPEDIR)/ipecmd.jar

# Compiler flags.
CFLAGS = $(MPLAB_CFLAGS)
LDFLAGS = $(MPLAB_LDFLAGS)
OBJ = $(patsubst %.c,$(OBJDIR)/%.p1,$(SRC))

# MPLAB X defaults.
MPLAB_CFLAGS = -fno-short-double -fno-short-float -O0 -fasmfile -maddrqual=ignore -xassembler-with-cpp -Wa,-a -msummary=-psect,-class,+mem,-hex,-file -ginhx032 -Wl,--data-init -mno-keep-startup -mno-osccal -mno-resetbits -mno-save-resetbits -mno-download -mno-stackcall -mno-stackcall -std=c99 -gdwarf-3 -mstack=compiled:auto:auto
MPLAB_LDFLAGS = -Wl,-Map=$(DISTDIR)/$(PROJECT).map -Wl,--defsym=__MPLAB_BUILD=1 -Wl,--memorysummary,$(DISTDIR)/memoryfile.xml

# File directories.
SRCDIR = src
OBJDIR = build
DISTDIR = dist

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
	$(RM) log.0 MPLABXLog.xml

write:
	-$(IPE) -M -P$(DEVICE) -T$(TOOL) $(IPEFLAGS) -F"$(DISTDIR)/$(PROJECT).hex"
	$(RM) log.0 MPLABXLog.xml

erase:
	-$(IPE) -E -P$(DEVICE) -T$(TOOL) $(IPEFLAGS)
	$(RM) log.0 MPLABXLog.xml

verify:
	-$(IPE) -Y -P$(DEVICE) -T$(TOOL) $(IPEFLAGS)
	$(RM) log.0 MPLABXLog.xml

blank_check:
	-$(IPE) -C -P$(DEVICE) -T$(TOOL) $(IPEFLAGS)
	$(RM) log.0 MPLABXLog.xml

id:
	-$(IPE) -I -P$(DEVICE) -T$(TOOL) $(IPEFLAGS)
	$(RM) log.0 MPLABXLog.xml

on:
	-$(IPE) -W -P$(DEVICE) -T$(TOOL) $(IPEFLAGS)
	$(RM) log.0 MPLABXLog.xml

off:
	-$(IPE) -P$(DEVICE) -T$(TOOL)
	$(RM) log.0 MPLABXLog.xml

ipe_help:
	-$(IPE) -?
	$(RM) log.0 MPLABXLog.xml

