#!/usr/bin/env bash
#
# Use FSL to create a spherical ROI at specific MNI coordinate

# -41, +16, +54 mm  maps to  65,  71 , 63 ijk  for MNI152_T1_2mm.nii.gz
#                     or to 131, 142, 126 ijk  for MNI152_T1_1mm.nii.gz

FSLOUTPUTTYPE=NIFTI

# Place a point and expand to sphere
fslmaths ${FSLDIR}/data/standard/MNI152_T1_1mm.nii.gz \
    -mul 0 -add 1 -roi 131 1 142 1 126 1 0 1 \
    -kernel sphere 6 -dilM \
    sphere6mm_MNI_-41_+16_+54
