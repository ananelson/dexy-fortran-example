# ============================================================================
#  Program:     dexy-fortran-example
#  Created:     2013-6-26
# ============================================================================
#  Available rules:
#  Available rules:"
#    all - Build execubtable"
#    dexy-fortran-example - Build main executable
#    clean - Deletes local objects
#    new - Runs the "clean" and default targets
#    help - Prints this help message
# ============================================================================
# Basic MAKE settings
SHELL = /bin/sh
INSTALL_PROGRAM ?= $(INSTALL)
INSTALL_DATA ?= $(INSTALL) -m 644
MOD_DIR = ./include

# ============================================================================
# Compiler settings and flags
FC ?= gfortran
LINK ?= $(FC)

FFLAGS ?= -W -Wall -fcheck=all -pedantic-errors -Wunderflow -ffpe-trap=invalid,zero,overflow -g
LFLAGS ?= $(FFLAGS)
ALL_INCLUDE ?= -I. -I$(MOD_DIR)
ifdef INCLUDE
	ALL_INCLUDE += -I$(INCLUDE)
endif
ifeq ($(FC),gfortran)
	ALL_INCLUDE += -J$(MOD_DIR)
else ifeq ($(FC),ifort)
	ALL_INCLUDE += -module $(MOD_DIR)
endif
ALL_FFLAGS = -g $(ALL_INCLUDE) $(FFLAGS)
ALL_LFLAGS = $(ALL_INCLUDE) $(LFLAGS)
EXECUTABLE = dexy-fortran-example

# ============================================================================
# Fortran rules and file suffixes
.SUFFIXES:
.SUFFIXES: .f90 .mod .o
%.o : %.f90 ; $(FC) -c -o $@ $(ALL_FFLAGS) $<
%.o : %.f   ; $(FC) -c -o $@ $(ALL_FFLAGS) $<

# ============================================================================
# Source lists
SRC = f77_example.f main.f90
MOD_SRC = awesome_module.f90 other_module.f90
MODULES = awesome_module other_module

# ============================================================================
# Object and module lists
OBJ = $(subst .f,.o, $(subst .f90,.o, $(SRC)))
MOD_OBJ = $(subst .f90,.o, $(MOD_SRC))
MOD_FILES = $(addprefix $(MOD_DIR)/, $(addsuffix .mod, $(MODULES)))

# ============================================================================
# Targets
.PHONY.: all, clean, new, help

all: $(EXECUTABLE)

$(EXECUTABLE): $(MOD_OBJ) $(MOD_FILES) $(OBJ)
	$(LINK) $(MOD_OBJ) $(OBJ) -o $(EXECUTABLE) $(ALL_LFLAGS)

clean:
	-rm -f $(OBJ) $(MOD_OBJ) $(MOD_FILES) $(EXECUTABLE)

new: clean
	$(MAKE)

help:
	@echo "Available rules:"
	@echo "  all = Build execubtable"
	@echo "  "$(EXECUTABLE)" = Build main executable"
	@echo "  clean = Deletes local objects"
	@echo "  help = Prints this help message"

### DO NOT remove this line - make depends on it ###