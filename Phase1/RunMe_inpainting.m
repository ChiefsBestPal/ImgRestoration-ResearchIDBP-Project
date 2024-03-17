%%  IDBP for inpainting

% Reference: "Image Restoration by Iterative Denoising and Backward Projections"
% Authors: Tom Tirer and Raja Giryes
% Journal: IEEE Transactions on Image Processing (accepted 2018)

clear;


denoiser_choice_index = 1;
dataset_choice_index = 1;

denoiser_options = {'BM3D'}; % These are two denoisers used in the TIP paper.
                                     % You can add your preferred denoiser, with the required support in the "Denoising_operation" file.
dataset_options = {'classics','BSD68'};


denoiser_choice = denoiser_options{denoiser_choice_index};
dataset_choice = dataset_options{dataset_choice_index};

images_folder = ['../MATLAB Drive/Phase1/test_sets/' dataset_choice];
ext = {'*.jpg','*.png','*.bmp'};
images_list = [];
for i = 1 : length(ext)
    images_list = cat(1,images_list,dir(fullfile(images_folder, ext{i})));
end
N_images = size(images_list,1);


all_results_PSNR = zeros(3,N_images);
all_results_ssim = zeros(3,N_images);

fileID = fopen('../MATLAB Drive/Phase1/images/output_log.txt', 'w');

for scenario_ind=1:1:3
    for image_ind=1:1:N_images
        %% prepare observations
        
        img_name = images_list(image_ind).name;
        X0 = imread(fullfile(images_folder,img_name));
        
        % converts to grayscale
        assert(max(X0(:))<=255);    % check that intensity level is 0 to 255
        if size(X0,3)>1             
            X0 = rgb2ycbcr(X0);     
            X0 = X0(:,:,1);
        end
        
        % intensity issue with this  classic png
        if strcmp(img_name,'3_peppers256.png')
            X0 = X0(2:end-1,2:end-1); % remove defective intensity values
        end
        
        % initialize parameters
        [M,N] = size(X0);
        n = N*M; % total num of pixels
        p = floor(0.8*n); if strcmp(dataset_options,'BSD68'); p = floor(0.5*n); end; % num of missing pixels | 50% for BSD68 | 80% for classic
        X0 = double(X0);
        
        switch scenario_ind
            case 1
                sig_e = 0;
                maxIter = 150;
                % for sig_e=0, delta=1-2 is the best, but then IDBP requires more iterations
                delta = 5;
            case 2
                sig_e = 10;
                maxIter = 75;
                delta = 0;
            case 3
                sig_e = 12;
                maxIter = 75;
                delta = 0;
        end
        
        % create missing pixels
        rand('seed', 0); % ensures that same sequence of random numbers will be generated each time the code is executed
        randn('seed', 0);
        
        missing_pixels_ind = randperm(n,p);
        Y_clean = X0;
        Y_clean(missing_pixels_ind) = 0;
        
        % adding random noise + missing pixels again after the random noise
        noise = sig_e * randn(M,N);
        Y = Y_clean + noise;
        Y(missing_pixels_ind) = 0;
        
        
        %% run IDBP inpainting
        
        % initialization by median scheme, feel free to check other options
        X_median_init = median_inpainting(Y,missing_pixels_ind); % custom function to inpaint with median
        Y_tilde = X_median_init;
        X_tilde = X_median_init;
        sigma_alg = sig_e + delta;
        
        for k=1:1:maxIter
            
            % estimate X_tilde
            % note that "Denoising_operation" is written for treating the denoiser as a "black box"
            % and not for the fastest performance (e.g. it may load the same DNN and copy between CPU and GPU in each iteration)
            [~, X_tilde] = BM3D(0, Y_tilde, sigma_alg, 'np', 0);         
            if max(X_tilde(:))<=1; X_tilde = X_tilde*255; end;
            
            % estimate Y_tilde
            Y_tilde = Y;
            Y_tilde(missing_pixels_ind) = X_tilde(missing_pixels_ind);
            
            % compute PSNR
            X_tilde_clip = X_tilde; X_tilde_clip(X_tilde<0) = 0; X_tilde_clip(X_tilde>255) = 255;
            PSNR = 10*log10(255^2/mean((X0(:)-X_tilde_clip(:)).^2));
            disp(['IDBP: finished iteration ' num2str(k) ', PSNR for X_tilde = ' num2str(PSNR)]);
            fprintf(fileID, ['IDBP: finished iteration ' num2str(k) ', PSNR for X_tilde = ' num2str(PSNR) '\n']);
        end
        
        if sig_e == 0 % i.e. if scenario_ind==1
            % in the noiseless case, take the last Y_tilde as the estimation
            X_tilde = Y_tilde;
            X_tilde_clip = X_tilde; X_tilde_clip(X_tilde<0) = 0; X_tilde_clip(X_tilde>255) = 255;
            PSNR = 10*log10(255^2/mean((X0(:)-X_tilde_clip(:)).^2));
            disp(['IDBP (noiseless case): finished iteration ' num2str(k) ', PSNR for X_tilde = ' num2str(PSNR)]);
            fprintf(fileID, ['IDBP (noiseless case): finished iteration ' num2str(k) ', PSNR for X_tilde = ' num2str(PSNR) '\n']);
        end
        
        
        %% collect results
        
        all_results_PSNR(scenario_ind,image_ind) = PSNR;
        ssim_res = ssim(double(X_tilde_clip)/255,double(X0)/255); % we use MATLAB R2016a function
        all_results_ssim(scenario_ind,image_ind) = ssim_res;
        disp(['scenario_ind=' num2str(scenario_ind) ', image_ind=' num2str(image_ind) ', PSNR=' num2str(PSNR) ', SSIM=' num2str(ssim_res)]);
        fprintf(fileID, ['scenario_ind=' num2str(scenario_ind) ', image_ind=' num2str(image_ind) ', PSNR=' num2str(PSNR) ', SSIM=' num2str(ssim_res) '\n']);

        % Display original, observed, and inpainted images
        figure;
        subplot(1, 3, 1);
        imshow(uint8(X0));
        title('Original Image');

        subplot(1, 3, 2);
        imshow(uint8(Y));
        title('Observed Image');

        subplot(1, 3, 3);
        imshow(uint8(X_tilde));
        title('Inpainted Image');

        % Define folder path
        folder_path = '../MATLAB Drive/Phase1/images/';

        % Save original image
        original_image_path = fullfile(folder_path, ['original_image(' num2str(scenario_ind) ',' num2str(image_ind) ').png']);
        imwrite(uint8(X0), original_image_path);
        
        % Save observed image
        observed_image_path = fullfile(folder_path, ['observed_image(' num2str(scenario_ind) ',' num2str(image_ind) ').png']);
        imwrite(uint8(Y), observed_image_path);
        
        % Save inpainted image
        inpainted_image_path = fullfile(folder_path, ['inpainted_image(' num2str(scenario_ind) ',' num2str(image_ind) ').png']);
        imwrite(uint8(X_tilde), inpainted_image_path);

    end
end

fclose(fileID);



