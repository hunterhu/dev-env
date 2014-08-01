#!/bin/bash

# -o : boolean OR operator

#replace it with your linux kernel directory
LNX=$HOME/projects/1030tpc-dev/sunxi-bsp/linux-sunxi
cd / 	
find  $LNX \
	    -path "$LNX/arch/*" ! -path "$LNX/arch/arm*" -prune -o \
        -path "$LNX/arch/arm/*" ! -path "$LNX/arch/arm/mach-sun*"  ! -path "$LNX/arch/arm/plat-sun*" -prune -o \
		-path "$LNX/drivers/*" ! -path "$LNX/drivers/input*" -prune -o \
		-path "$LNX/scripts/*" -prune -o \
		-name "*.[chxsS]" -print >$LNX/cscope.files

#note: 
# 1> add drivers' code as needed

