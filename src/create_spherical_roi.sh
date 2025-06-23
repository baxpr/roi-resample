#!/usr/bin/env bash
#
# Use FSL to create a spherical ROI at specific MNI coordinate

# -41, +16, +54 mm  maps to  65,  71 , 63 ijk  for MNI152_T1_2mm.nii.gz
#                     or to 131, 142, 126 ijk  for MNI152_T1_1mm.nii.gz

# -30, -66, 42 mm  maps to  120,  60, 114 ijk  for MNI152_T1_1mm.nii.gz

# -36, -70, 51 mm  maps to  126,  56, 123 ijk

FSLOUTPUTTYPE=NIFTI

# Place a point and expand to sphere
fslmaths ${FSLDIR}/data/standard/MNI152_T1_1mm.nii.gz \
    -mul 0 -add 1 -roi 131 1 142 1 126 1 0 1 \
    -kernel sphere 6 -dilM \
    sphere6mm_MNI_-41_+16_+54


fslmaths ${FSLDIR}/data/standard/MNI152_T1_1mm.nii.gz \
    -mul 0 -add 1 -roi 120 1 60 1 114 1 0 1 \
    -kernel sphere 6 -dilM \
    sphere6mm_MNI_-30_-66_+42


fslmaths ${FSLDIR}/data/standard/MNI152_T1_1mm.nii.gz \
    -mul 0 -add 1 -roi 126 1 56 1 123 1 0 1 \
    -kernel sphere 6 -dilM \
    sphere6mm_MNI_-36_-70_+51
