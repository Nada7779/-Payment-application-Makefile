# set Shell
SHELL = /bin/bash

# variable for clean
RM = rm -rf

# set Compiler
CC = gcc

# set Flags
CFLAGS =  -O -Wall -Wextra -gdwarf-2
LDFLAGS = -lm
CPPFLAGS = -I$(INCDIR)

# set bin & build directory
BUILDDIR = build
BINDIR = bin

# Source files
SRCS = $(shell find . -name '*.c' -type f)
# Header files
HDRS = $(shell find . -name '*.h' -type f)
# Object files
OBJS = $(patsubst %.c,$(BUILDDIR)/%.o,$(notdir $(SRCS)))

# Target name
TARGET = $(BINDIR)/$(lastword $(subst /, ,$(CURDIR)))


.PHONY: all run clean cleanall

all: $(BINDIR) $(BUILDDIR) $(TARGET)

$(BUILDDIR)/%.o: %.c
	@mkdir -p $(BUILDDIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(TARGET): $(OBJS)
	@mkdir -p $(BINDIR)
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@

run: $(TARGET)
	./$(TARGET)

clean:
	$(RM) $(OBJS)
	$(RM) $(TARGET)

cleanall:
	$(RM) $(BUILDDIR)
	$(RM) $(BINDIR)