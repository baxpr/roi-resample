#!/usr/bin/env bash

# Binarize
export FSLOUTPUTTYPE=NIFTI
fslmaths KimAGsphere10mm_orig -bin KimAGsphere10mm
fslmaths Aboud2016AGsphere10mm_orig -bin Aboud2016AGsphere10mm

# Resample
#flirt \
#    -in KimAGsphere10mm_orig.nii \
#    -ref ${FSLDIR}/data/standard/MNI152_T1_1mm.nii.gz \
#    -usesqform \
#    -applyxfm \
#    -interp nearestneighbour \
#    -o KimAGsphere10mm.nii

