# roi-resample

Given the name of an ROI included in the container and a participant-specific inverse warp from CAT12, transform the ROI to the participant native space.

Inputs:

    roi_nii           Name of ROI file in container (filename only, no path)
    t1_niigz          T1 image in native space
    roidefinv_niigz   Inverse warp from CAT12 or similar
    out_dir           Output directory

Outputs:

    ROI_NATIVE        Resampled ROI image as .nii.gz

Included ROIs are

    sphere6mm_MNI_-41_+16_+54.nii   Sphere at -41,16,54 mm approx 6mm radius

