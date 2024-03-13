# Index terms

_Antoine Cantin 13th March 2024_

## Plug-and-Play Framework

> Replaces some manual user/human inputs of image priors with denoising operators

### P&P baselines in IDBP paper
1. **Decoupling Measurement Model and Image Prior**: The P&P framework decouples the mathematical model that describes how the image is acquired (measurement model) from the constraints or assumptions about the structure of the image (image prior). Traditionally, these two components are intertwined in inverse problem formulations.

2. **Utilizing Denoising Algorithms**: Instead of explicitly defining the image prior, the P&P framework leverages existing (empirically proven or math modeled) denoising algorithms to implicitly define the prior. By incorporating these denoisers into the optimization process, the image prior is effectively incorporated into the solution without explicit specs for it.

3. **Solving General Inverse Problems**: The P&P framework allows for solving a wide range of inverse problems in image processing. By utilizing denoising algorithms, the framework can be applied to various tasks without the need for task-specific algorithms or prior knowledge about the image.

4. **Iterative Optimization**: In practice, solving inverse problems using the P&P framework often involves iterative optimization. In each iteration and phases, the observed data is processed through a denoising operation, and the resulting image is refined/restored/enhanced to better match the observed data. This iterative process continues until a satisfactory established/thresholded solution is obtained.

5. **Parameter Tuning**: A drawback/extra step when using P&P for high quality results. The choice of denoising algorithm, the parameters of the denoiser, and other optimization parameters may need to be adjusted to optimize performance for a specific task and/or dataset.

## Inverse Problems

Refers to the task of reconstructing an approximation of an unknown initial image, measurement or scene from observed data that has undergone some form of degradation or transformation.


> e.g. estimating original set of input functions/impulses (in form of sampled data or numerical method approximates), using the response obtained from sampled inverse fourier/laplacian transforms.



## Image Restoration
Image Restoration is main generic displine here, with math/method focus on inverse problems in image processing \
Specifics: Inpainting, Enhancement, Deblurring, Denoising, Reconstruction from measurements, super-resolution

- regarding cost functions... 


## Image Denoising
Refers to the process of removing noise from an image to improve its **quality and clarity**. Noise can be introduced into images during the **acquisition process** due to various factors such as electronic interference, sensor limitations, or environmental conditions. Image denoising algorithms **aim to preserve important image features while effectively suppressing the unwanted noise.**

- **Ex P&P inverse problem solving** : IDBP proposes alternatives to P&P denoise algorithms using them and other IR CNNs as baselines. Balance noise/artifact reductions and fine/prioritized details preservation.

- **Ex Iterative Optimization Implicit image prior**: P&P framework denoise algorithms make assumptions about image prior to choose methods to apply to which classes of image. Include denoisers in IDBP optimization process. 


## Image Deblurring

Refers to the process of reducing or removing blur from an image to enhance its **clarity and sharpness**. Blur in images can occur due to various factors such as motion during image capture, defocus, or imperfections in the optical system; or even manually applied filters. Image deblurring algorithms aim to **recover the sharp details and fine structures that have been lost or obscured by the blurring**/unsharpening/smoothening** effect.


- **Ex Inverse problems**: Estimate blur kernel or point spread function
- **Ex Iterative Optimization**: Estimate sharp convolution/filter/etc phases of image by minimizing a suitable objective function that balances image fidelity and regularization

## Image Inpainting

Refers to the process of **filling in missing or damaged regions** of an image in order to reconstruct a complete and visually **plausible, coherent and integral** version of the original image. Image inpainting techniques are used to restore or repair images that have had occlusions, been corrupted or contain unwanted elements, such as scratches, text, or objects that have been intentionally removed.

- **Ex Reconstruction for completeness of image restoration**: Use information of surrounding areas or previous responses/iterations to infer content of missing regions. Example methods: Texture synthesis, specific dilatation, image extrapolation, diffusion-based techniques, etc...

- **Ex Inverse problems context**: Reconstruct original estimate data with numerical methods using context of the current observe data considered incomplete, damaged or corrupted. 

## Denoising Neural Network

- Architecture, training and learning of IRCNN refs... Better inference, minimize loss functions and capture complex patterns to improve all math models, measurements and methods.

- Integrate with optimization methods and P&P adapted denoisers