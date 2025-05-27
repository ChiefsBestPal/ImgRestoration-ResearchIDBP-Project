# Image Restoration and Deblurring using IDBP P&P algorithms, CNNs and various Denoisers

# References, Resources, Links (Papers, Codebases, Datasets)


## IDBP; main framework 
- IEEE: https://ieeexplore.ieee.org/abstract/document/8489894
- PDF: https://arxiv.org/pdf/1710.06647
- REPO: https://github.com/tomtirer/IDBP
## Related denoisers used in IDBP Framework
### IRCNN
CNN-based denoiser that enhances IDBP framework: 
	- https://github.com/cszn/IRCNN
	- https://arxiv.org/abs/1704.03264
	- https://arxiv.org/abs/2309.04782
### BM3D
3D collaborative filtering versatile denoiser used within IDBP variations and framework: 
	- https://webpages.tuni.fi/foi/GCF-BM3D/index.html
### DPIR
Plug&Play priors based image reconstruction deep denoiser:
	- https://github.com/cszn/DPIR
	- https://ieeexplore.ieee.org/abstract/document/9454311
	- https://arxiv.org/pdf/2008.13751
## Main important Datasets
> From all phases, test, training and realistic applications
### Set12
Fast testset dataset and versatile:
	- https://www.kaggle.com/datasets/leweihua/set12-231008
### SIDD
Smarphone pictures denoising realistic testset:
	- https://www.kaggle.com/datasets/rajat95gupta/smartphone-image-denoising-dataset
	- N.B: See our [*SIDD file structure and comparison info.pdf*] for our own image/file naming convention
### BSD68
Standard images to test P&P params, different algs and constructs for Image Restoration purposes:
	- https://www.kaggle.com/code/mpwolke/berkeley-segmentation-dataset-68
	- https://github.com/clausmichele/CBSD68-dataset


## Other relevant refs and works: 
> i.e. Other partially relevant image processing projects as references and partial resources from research:
> [Mostly from: IEEE Transactions on Image Processing and IEEE Conference on Computer Vision and Pattern Recognition]

- Second-order Attention Network for Single Image Super-Resolution
	- PDF: https://openaccess.thecvf.com/content_CVPR_2019/papers/Dai_Second-Order_Attention_Network_for_Single_Image_Super-Resolution_CVPR_2019_paper.pdf
	- DATASET: https://paperswithcode.com/dataset/div2k


- Cycle-Dehaze: Enhanced CycleGAN for Single Image Dehazing [Extra, More extensive work to be done for this]
	- PDF: https://openaccess.thecvf.com/content_cvpr_2018_workshops/papers/w13/Engin_Cycle-Dehaze_Enhanced_CycleGAN_CVPR_2018_paper.pdf


[...]
	*****TODO: THIS PART WILL BE COMMENT ON GIHTUB ???****

- Unrelated for future ideas off of IDBP knowledge applied to CV or Image/Signal processing fields:

		Simple Baselines for Human Pose Estimation and Tracking
		https://openaccess.thecvf.com/content_ECCV_2018/papers/Bin_Xiao_Simple_Baselines_for_ECCV_2018_paper.pdf
		https://www.kaggle.com/datasets/awsaf49/coco-2017-dataset
		https://paperswithcode.com/dataset/posetrack

		Misc:
		https://ieeexplore.ieee.org/abstract/document/8101508
		https://ieeexplore.ieee.org/abstract/document/8304597
		https://ieeexplore.ieee.org/document/6512558


