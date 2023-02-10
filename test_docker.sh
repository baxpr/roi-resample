#!/usr/bin/env bash

docker run \
    --mount type=bind,src=`pwd -P`/INPUTS,dst=/INPUTS \
    --mount type=bind,src=`pwd -P`/OUTPUTS,dst=/OUTPUTS \
    roi-resample:test \
    --roi_nii sphere6mm_MNI_-41_+16_+54.nii \
    --roidefinv_niigz /INPUTS/iy_t1.nii.gz \
    --t1_niigz /INPUTS/t1.nii.gz \
    --out_dir /OUTPUTS
