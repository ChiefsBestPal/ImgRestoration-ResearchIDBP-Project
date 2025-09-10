# ExtendedIDBP
> Since 2024 

Reconstruct, Enhance, Deblur and Denoise degraded smartphone pictures
- **Industry use cases**: Specifically trained on brands/models of smartphones and different type of damage: optical abberations, bad compression, low quality, missing/cutoff parts and general severe artifacts
- **Open-source research, data and software**: Extends emerging publications from conferences (ICIP,CVF,CVIP), mainly IDBP & IRCNN papers (See READMEs references)
- **Multi-method**: Deep-learning networks, iteratively optimized image processing mathematical models, signal processing metrics/logging, information theory for noise classes
- **MATLAB GUI** to input smarphone images or sequences/signals to try restoration frameworks; with observability & monitoring, smartphone metadata configs, parameter tuning

## Created by 
- **Lead & Maintainer, author/dev** : <ins>Antoine Cantin @ChiefsBestPal</ins>
- **author/dev** : <ins>Ryan Li @Ryan2Li</ins>
- original peer-reviews : see cloud and papers
- OSS/Academic Contributors: [Contact @ChiefsBestPal] for full-access and info

# IDBP: Overview

## Demos 
### Example of our Inpainting IDBP-extension 
<img width="256" height="256" alt="1_Cameraman256" src="https://github.com/user-attachments/assets/dd874f90-2bff-40fa-a456-22d3fbda270e" />
<img width="256" height="256" alt="1_Cameraman256_inpainted" src="https://github.com/user-attachments/assets/c54a6184-a543-49dd-b55e-a1d387f879fe" />

### Final paper presentation
> PDF of presentation slides: [IDBP_Research_Presentation_COMP478.pdf](https://github.com/user-attachments/files/21703628/IDBP_Research_Presentation_COMP478.pdf)

<img width="1049" height="487" alt="image" src="https://github.com/user-attachments/assets/423880f4-e976-493c-be05-aafd038fce40" />
<img width="1203" height="680" alt="image" src="https://github.com/user-attachments/assets/78fd38a0-6c94-4338-b074-994a8e074b2d" />
<img width="1206" height="672" alt="image" src="https://github.com/user-attachments/assets/3ffa7528-f733-4a65-a06a-8fa8af2248c2" />


### matlab run of custom interfaces
See Phase2 videos and google drive links

## IDBP Purpose; Restoring images within a versatile and efficient framework

The Iterative Denoising and Backward Projections, IDBP in short, is a method that reconstructs the
original image by removing the unwanted signals from the artifact iteratively. It is an alternative
method that addresses the issues and difficulties when it comes to using the Plug & Play method for
denoising, inpainting, and deblurring an image
Both IDBP and P&P are numerical solutions to image restoration inverse problems. Typically, image
restoration involves cost functions that quantify the difference between the observed degraded image
and the original, clean image. The cost function is composed of two parts, the measurement mode
and the image prior. The measurement mode describes how the data is acquired or observed, while
the image prior describes assumptions and constraints of what the original image should visualize as.
For a given prior information, the goal is to minimize the cost function to find an estimate of the
original clean image.
The Plug & Play method uses a cost function as part of their optimization process. Its purpose is to
decouple its two components and define the image prior using off-the-shelf denoising operators
instead of having human exclusive input constraints. While this method generally pulls this off, there
are some drawbacks. The P&P method’s parameter tuning is very burdensome which requires time
and effort to find proper adjustment. The method also uses the ADMM algorithm that runs iteratively to
find convergence. An issue with this iterative algorithm is that it may take a large amount of iterations,
thus losing computation time. In addition to the ADMM algorithm and its convergence, its components
must be convex, closed, and proper. These properties are not ideal because most prior functions with
off-the-shelf denoisers are non-convex and unclear.
Key index terms for P&P / Paper’s baseline: Decoupling measure models and priors, Denoisers,
Solving general inverse problems, Iterative Optimization, Parameter Tuning
The Iterative Denoising and Backward Projections method aims to address all of these problems
when denoising, inpainting, or deblurring a degraded image. It transforms the cost function into an
optimization problem and proposes an efficient minimization scheme for the prior term using P&P
properties. Finally, it proposes an automatic tuning mechanism for parameters that vary between
noisy inpainting problems and deblurring automatic parameters.

## Quick overview of Key concepts and Index terms

1. Concepts and Key Image Processing theory: See [IndexTerms_notes.md]
2. Math and Formal theory: See [IDBP_math_research_notes.ipynb]

## Our Final Paper
Applied to phone cameras and real world applications \
URL: [478 Final Report.pdf](https://github.com/user-attachments/files/21703633/478.Final.Report.pdf)


# Results and compiled training logs/data
Phase2(&3+Final paper): https://drive.google.com/drive/u/0/folders/1B4dDQso_TP_I8qZJWxpy9UYYNGxIquGY

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


