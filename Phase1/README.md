# MatLab Code Explanation
## Ryan Li - 40214839 & Antoine Cantin - 40211205
Our MatLab function was based on the MatLab code on GitHub provided by the researchers and other nested reference links [2]. \
Note that our function was written using the online MatLab program. This may cause differences in the files paths and would require you to addpath() the folders that are required to run the function.

The IDBP function takes parameter index, from 1-..., which determines which dataset to perform on. 
To add a dataset, you need to add the new dataset in the ```datasets``` folder.
Next you need to include the dataset name in the set:
```matlab
datasets = {'classics','BSD68'};
```

The reason you we chose the "classic" and "BSD68" is because:
- These datasets contain real-world images. This better reflects real-world results.
- Images are diverse, which gives a diverse test set.
- These datasets are well-known, widely used, well understood, and ready available to/by the community. This allows other researchers to compare their own results.
- The size of these datasets are good for our purpose.
Note that under the "classic" dataset, the third image "3_peppers256" has a border issue where the first rows and columns are black and the last rows and columns are white so we want to remove these.

The reasearch paper used PSNR, Peak Signal-to-Noise Ratio, and SSIM, Structural Similarity Index, to compare the difference between the the different scenarios and images.
The PSNR is metric that compares the the mean squared root between the original image and the denoise + inpainted image. A higher PSNR score indicates a better quality image.
The SSIM is a metric that compares the structural similarity between the original image and the denoise + inpainted image.  higher SSIM score indicates a more structural similarities.
The PSNR and SSIM values are outputed in the console as well as witten into ```output_log.txt```

Once the dataset is determined and the PSNR and SSIM arrays are initialized, we start the algorithm:
```matlab
for scenario=1:1:num_of_scenarios
        for img=1:1:num_of_imgs
            ...
        end
end
```

IDBP works with grayscaled images, therefore any image with rbg channels are converted to grayscale:
```matlab
if ndims(x) == 3
      x = rgb2gray(x);
end
```
If the image has an intensity value greater than 255, then the image is invalid and the function stops.

The experiment is run under 3 scenarios for each image:
```matlab
 if scenario == 1
    iteration_max = 150;
    sigma_e = 0;
    delta = 5;
elseif scenario == 2
    iteration_max = 75;
    sigma_e = 10;
    delta = 0;
elseif scenario == 3
    iteration_max = 75;
    sigma_e = 12;
    delta = 0;
end
```
Here sigma_e is used to produce random gaussian noise for the image: 
```matlab 
noise = imnoise(zeros(size(og_img)), 'gaussian', 0, sigma_e);
```
We created 80% missing pixels(NaN) on the "classic" dataset, but only 50% missing pixels on the "BSD68" dataset. This is because as stated in the paper, 80% produced a very low average SSIM score and was not viable [1].

Now that the setup is done, we initializethe IDBP algorithm by convoluting the noisy + missing pixel image with a simple median scheme for inpainting. The median algorithm uses a dynamic median kernel, that increments in size after each iteration, to fill in all the NaN pixels. This algorithm is good for the case of inpainting because as more pixels are determined, the kernel grows to capture the local structure and feature of the image [1].

After the median algorithm the IDBP algorithm is ran until a stop condition is met, in our case it is the ```iteration_max```. \
$x^{\tilde{}}$ is estimated by using an off-the-shelf denoising operator [3][4][5]:
```matlab 
[~, unknown_signal] = BM3D(0, observed_img, sigma, 'np', 0);
```

$y^{\tilde{}}$  is estimated by replacing the original noisy + missing pixel image with $x^{\tilde{}}$  denoised pixels:
```matlab
observed_img = obs_img;
observed_img(missing_pixels_ind) = unknown_signal(missing_pixels_ind);
```

## References
1. T. Tirer and R. Giryes, "Image Restoration by Iterative Denoising and Backward Projections," in IEEE Transactions on Image Processing, vol. 28, no. 3, pp. 1220-1234, March 2019, doi: 10.1109/TIP.2018.2875569. [https://ieeexplore.ieee.org/abstract/document/8489894]
2. T. Tirer and R. Giryes, "Image Restoration by Iterative Denoising and Backward Projections," GitHub [https://github.com/tomtirer/IDBP]
3. K. Dabov, A. Foi, V. Katkovnik and K. Egiazarian, "Image Denoising by Sparse 3-D Transform-Domain Collaborative Filtering," in IEEE Transactions on Image Processing, vol. 16, no. 8, pp. 2080-2095, Aug. 2007, doi: 10.1109/TIP.2007.901238. [https://ieeexplore.ieee.org/document/4271520]
4. K. Dabov, A. Foi, V. Katkovnik and K. Egiazarian, "Image Denoising by Sparse 3-D Transform-Domain Collaborative Filtering," website and download [https://webpages.tuni.fi/foi/GCF-BM3D/index.html]
5. S. V. Venkatakrishnan, C. A. Bouman and B. Wohlberg, "Plug-and-Play priors for model based reconstruction," 2013 IEEE Global Conference on Signal and Information Processing, Austin, TX, USA, 2013, pp. 945-948, doi: 10.1109/GlobalSIP.2013.6737048. [https://ieeexplore.ieee.org/document/6737048].



