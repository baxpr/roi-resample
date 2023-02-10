#!/usr/bin/env bash
#
# Main entrypoint for roi resample

# Initialize defaults
export roi_nii=sphere6mm_MNI_-41_+16_+54.nii
export t1_niigz=/INPUTS/t1.nii.gz
export roidefinv_niigz=/INPUTS/iy_t1.nii.gz
export out_dir=/OUTPUTS

# Parse input options
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in      
        --roi_nii)            export roi_nii="$2";          shift; shift ;;
        --t1_niigz)           export t1_niigz="$2";         shift; shift ;;
        --roidefinv_niigz)    export roidefinv_niigz="$2";  shift; shift ;;
        --out_dir)            export out_dir="$2";          shift; shift ;;
        *) echo "Input ${1} not recognized"; shift ;;
    esac
done

# Prep files
export t1_nii="${out_dir}"/t1.nii
gunzip -c "${t1_niigz}" > "${t1_nii}"

export roidefinv_nii="${out_dir}"/iy_t1.nii
gunzip -c "${roidefinv_niigz}" > "${roidefinv_nii}"

# Most of the work is done in matlab
run_spm12.sh ${MATLAB_RUNTIME} function resample_roi \
    roi_nii "${roi_nii}" \
    t1_nii "${t1_nii}" \
    roidefinv_nii "${roidefinv_nii}" \
    out_dir "${out_dir}"

# Finally, zip images
gzip "${out_dir}"/ROI_NATIVE/*.nii

