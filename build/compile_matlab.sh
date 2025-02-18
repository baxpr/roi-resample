#!/bin/sh
#
# Compile the matlab code so we can run it without a matlab license. To create a 
# linux container, we need to compile on a linux machine. That means a VM, if we 
# are working on OS X.
#
# We require on our compilation machine:
#     Matlab R2023a, including compiler, with license
#     Installation of SPM12, https://www.fil.ion.ucl.ac.uk/spm/software/spm12/
#
# The matlab version matters. If we compile with R2023a, it will only run under 
# the R2023a Runtime.
#
# The SPM12 version also matters. The compilation code is written for r7771.


# Working dir
WD=$(pwd)

# Where to find SPM12 on our compilation machine
SPM_PATH="${WD}"/external/spm12_r7771

# Add Matlab to the path on the compilation machine
export MATLABROOT=~/MATLAB/R2023a
export PATH=${MATLABROOT}/bin:${PATH}

# We use SPM12's standalone tool, but adding our own code to the compilation path
matlab -nodisplay -nodesktop -nosplash -sd "${WD}" -r \
    "spm_make_standalone_local('${SPM_PATH}','${WD}/../bin','${WD}/../src'); exit"

# We grant lenient execute permissions to the matlab executable and runscript so
# we don't have hiccups later.
chmod go+rx "${WD}"/../bin/spm12
chmod go+rx "${WD}"/../bin/run_spm12.sh

