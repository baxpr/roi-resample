function resample_roi(varargin)

%% Parse inputs
P = inputParser;
addOptional(P,'roi_nii','sphere6mm_MNI_-41_+16_+54.nii');
addOptional(P,'roidefinv_nii','');
addOptional(P,'t1_nii','');
addOptional(P,'out_dir','');
parse(P,varargin{:});
inp = P.Results;
disp(inp)


%% Resample ROI image
% Warp ROI from atlas to fmri native space
clear matlabbatch
matlabbatch{1}.spm.util.defs.comp{1}.def = {inp.roidefinv_nii};
matlabbatch{1}.spm.util.defs.comp{2}.id.space = {inp.t1_nii};
matlabbatch{1}.spm.util.defs.out{1}.pull.fnames = {which(inp.roi_nii)};
matlabbatch{1}.spm.util.defs.out{1}.pull.savedir.saveusr = {inp.out_dir};
matlabbatch{1}.spm.util.defs.out{1}.pull.interp = 0;
matlabbatch{1}.spm.util.defs.out{1}.pull.mask = 0;
matlabbatch{1}.spm.util.defs.out{1}.pull.fwhm = [0 0 0];
matlabbatch{1}.spm.util.defs.out{1}.pull.prefix = '';
spm_jobman('run',matlabbatch);
mkdir(fullfile(inp.out_dir,'ROI_NATIVE'));
[~,n,e] = fileparts(inp.roi_nii);
rroi_nii = fullfile(inp.out_dir,'ROI_NATIVE',['r' n e]);
movefile(fullfile(inp.out_dir,['w' n e]),rroi_nii);


%% Convert any NaN values to zero, round values, fix scaling
V = spm_vol(rroi_nii);
Y = spm_read_vols(V);
Y(isnan(Y(:))) = 0;
V.dt(1) = spm_type('uint16');
V.pinfo(1:2) = [1 0];
spm_write_vol(V,Y);


%% Exit
if isdeployed
	exit
end

