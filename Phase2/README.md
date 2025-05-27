# TODO: WIP
**TODO:** FINISH THIS YEAR OLD README ABOUT PHASE2+3+Final Paper + Codes \
[...]
# Project Phase 2, and Phase 1 IDBP Antoine Cantin 40211205 and Ryan Li 40214839

> NB: In code documents and README as below, “Phase 2” refers to Phase 2 AND Phase 3. It means the second/final part of the code
# Phase 2 addition#1: IDBP changes
One of the changes we made to the MatLab source code is a reduction from 80% missing pixels to 50% missing pixels for the Smartphone Image Denoising Dataset. This results in a better application and reflection of reality as digital images taken for smartphones are more likely to have less than 80% missing pixels. Even 50% is still an edge case, but for the purpose of measuring and comparing IDBP’s performance it was kept at this percentage.
We have also downsampled Smartphone Image Denoising Dataset images to a width of 600 pixels while dynamically adjusting height to keep aspect ratios. Most images were originally around 4000 pixels in width with a bit depth of 24. This downsampling was required to save computation time while keeping most of the finer details of the original image. A width of 600 pixels produces a good diminishing return in denoising performance and computational time.
Note that the Smartphone Image Denoising Dataset are colored images.IDBP works with grayscale images. To correct this, we converted the image to grayscale before inpainting and denoising.
<br>
**For more information, Read the Final Report document ! It has all the information about parameters, code, datasetss and results/findings !**

# Phase 2 addition#2: Matlab SIDD parameters interface

**Make Sure to add all paths (folders and subfolders) in both matlab online and desktop for the paths to find the necessary images and scripts**

## VIDEO DEMO OF THE MATLAB INTERFACE CODE
<video controls src="DEMO_of_SIDD_CLI_interface2.mp4" title="DEMO OF THE MATLAB INTERFACE CODE"></video>
> DEMO_of_SIDD_CLI_interface2.mp4
## Description
For our phase 2, we have used specifically selected samples of the SIDD dataset to test multiple image acquisition conditions, parameters, settings and setups. <br>
This tool presents a very useful data filtering, viewing and sampling command-line interface that allows users to enter filters to find images in the SIDD dataset that matches their needs for analysis and processing; and it presents them as well as their properties in a matlab interface.<br>

## Interface

### CLI to enter parameters
- scene_number
- smartphone_type
- iso_level
- shutter_speed
- illuminant_temperature
- brightness

These are the parameters that can be filtered. The CLI will display cells with various values that repesent all the possible values that a user can enter for the specific parameter (one of the above). <br>
user can enter 4 different inputs:
- List e.g. 432,12,2,1,6  or G4,N6,GP
- range e.g. 1:8, 2:2:10
- single value e.g. 234   or G4
- Just press enter, enter no value to ignore and not filter for this parameter e.g. for smartphone_type, that means match all images taken by any smartphone and that fit the other parameters. 
<br>
The viewer should launch once inputs/skips for each parameters are entered. It should print paths in the command line console to allow user to directly copy paste the path of images and paste them manually in our IDBP driver to test the algorithm for inpainting on it. 


### Viewer
3 buttons in the viewer:
- Prev image: See the previous matched image
- Next image: See the next matched image
- Show parameters: Show info about image current displayed


## Code files

- SIDD_CLI_interface2.m
- ImageData.m : dataclass that represents an image and its specified SIDD properties
- ImageDataset.m : dataclass that represents a datastructure collection ImageData objects and that provdes methods to use and filter certain ImageData based on parameters
- test_sets/SIDD_Small_sRGB-dataset/Data: is where data should be sorted in folders with each 2 images in them (Ground truths and noisy)
