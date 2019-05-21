#!/bin/bash

# -o : boolean OR operator

#replace it with your linux kernel directory
LNX=$HOME/projects/paydia-c0-build/linux/
cd / 	
find  $LNX \
	    -path "$LNX/arch/*" ! -path "$LNX/arch/arm*" -prune -o \
        -path "$LNX/arch/arm/*" ! -path "$LNX/arch/arm/mach-meson*"  ! -path "$LNX/arch/arm/plat-meson*" -prune -o \
		-path "$LNX/drivers/*" ! -path "$LNX/drivers/amlogic*" -prune -o \
		-path "$LNX/scripts/*" -prune -o \
		-name "*.[chxsS]" -print >$LNX/cscope.files

#note: 
# 1> add drivers' code as needed

