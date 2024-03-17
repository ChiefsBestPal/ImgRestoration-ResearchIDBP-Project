function IDBP(index)

    % Write to output file
    fileID = fopen('../MATLAB Drive/Phase1/images/output_log.txt', 'w');
    
    % Choose which dataset to use
    datasets = {'classics','BSD68'};
    which_dataset = datasets{index};
    
    % Get array of all data paths and their names
    img_paths = fullfile('..', 'MATLAB Drive', 'Phase1', 'test_sets', which_dataset);
    img_struct = dir(fullfile(img_paths, '*.png'));
    img_names = {img_struct.name};
    img_full_paths = fullfile(img_paths, img_names);
    img_array = [img_names', img_full_paths'];
    
    % Initialize number of images and number of scenarios
    num_of_imgs = size(img_array, 1);
    num_of_scenarios = 3;
    
    % 2D array for PSNR and SSIM results
    PSNRs = zeros(3, num_of_imgs);
    SSIMs = zeros(3, num_of_imgs);
    
    % Producing observed images: adding noise + removing pixels in images
    % Running IDBP algorithm on these observed images
    for scenario=1:1:num_of_scenarios
        for img=1:1:num_of_imgs
            
            % Get image
            img_name = img_array(img, 1);
            % x is the original image
            % Find the index of img_name in img_names
            idx = find(strcmp(img_array(:, 1), img_name));
            img_full_path = img_array{idx, 2};
            x = imread(img_full_path);
            
            % Check that intensity level is 0 to 255 else abort
            if max(x(:)) > 255
                error('Maximum pixel value exceeds 255.');
            end
            % Convert to grayscale
            if ndims(x) == 3
                x = rgb2gray(x);
            end
            
            % 3_peppers256.png has a border issue where the first rows and
            % columns are black and the last rows and columns are white so
            % we want to remove these
            if strcmp(img_name, '3_peppers256.png')
                x = x(2:end-1, 2:end-1); 
            end
            
            % Total num of pixels
            num_of_pixels = numel(x);
            % Determine number of missing pixels | 50% for BSD68 | 80% for classic
            num_of_missing_pixels = floor(0.8 * num_of_pixels); 
            if strcmp(datasets, 'BSD68') 
                num_of_missing_pixels = floor(0.5 * num_of_pixels); 
            end

            % Needed for high precision computations
            x = double(x);
            
            % Depending on scenario change the parameters
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
            
            % Create missing pixels
            % Ensures that same sequence of random numbers will be generated each time the code is executed
            rand('seed', 0);
            missing_pixels_ind = randperm(num_of_pixels, num_of_missing_pixels);
            og_img = x;
            og_img(missing_pixels_ind) = 0;
            
            % Adding random noise + missing pixels again after the random noise
            noise = imnoise(zeros(size(og_img)), 'gaussian', 0, sigma_e);
            obs_img = og_img + noise;
            obs_img(missing_pixels_ind) = 0;
            
            % IDBP algorithm
            % Using median transformation for missing pixels for
            % initialization
            unknown_signal = median_inpainting(obs_img, missing_pixels_ind);
            observed_img = unknown_signal;
            sigma_alg = sigma_e + delta;
            
            for k=1:1:iteration_max
                
                % Estimate unknown_signal (x_k)
                [~, unknown_signal] = BM3D(0, observed_img, sigma_alg, 'np', 0);     
                % Check if intensity is 0-1, if so convert to 0-255
                if max(unknown_signal(:)) <= 1
                    unknown_signal = unknown_signal * 255; 
                end
                
                % Estimate observed_img (y_k)
                observed_img = obs_img;
                observed_img(missing_pixels_ind) = unknown_signal(missing_pixels_ind);
                
                % PSNR
                % Ensure that intensities is 0-255
                unknown_signal_255 = min(max(unknown_signal, 0), 255);
                MSE = mean((x(:) - unknown_signal_255(:)).^2);
                PSNR = 10 * log10(255^2 / MSE);
                disp(sprintf('Iteration: %d | PSNR: %.4f', k, PSNR));
                fprintf(fileID, 'Iteration: %d | PSNR: %.4f \n', k, PSNR);
            end
            
            %  PSNR for no noise because sigma_e == 0
            if sigma_e == 0
                unknown_signal_255 = min(max(observed_img, 0), 255);
                MSE = mean((x(:) - unknown_signal_255(:)).^2);
                PSNR = 10 * log10(255^2 / MSE);
                disp(sprintf('Iteration: %d | PSNR: %.4f', k, PSNR));
                fprintf(fileID, 'Iteration: %d | PSNR: %.4f \n', k, PSNR);
            end
            
            % Results
            PSNRs(scenario, img) = PSNR;
            SSIM = ssim(double(unknown_signal_255) / 255, double(x) / 255);
            SSIMs(scenario, img) = SSIM;
            disp(sprintf('Scenario: %d | Image: %d | PSNR: %.4f | SSIM: %.4f', scenario, img, PSNR, SSIM));
            fprintf(fileID, 'Scenario: %d | Image: %d | PSNR: %.4f | SSIM: %.4f \n', scenario, img, PSNR, SSIM);
    
            % Display original image
            figure;
            subplot(1, 3, 1);
            imshow(uint8(x));
            title('Original Image');
            
            % Display observed image
            subplot(1, 3, 2);
            imshow(uint8(obs_img));
            title('Observed Image');
            
            % Display inpainted image
            subplot(1, 3, 3);
            imshow(uint8(unknown_signal));
            title('Inpainted Image');
            
            % Image file paths
            folder_path = '../MATLAB Drive/Phase1/images/';
    
            % Save original image
            original_image_path = fullfile(folder_path, ['original_image(' num2str(scenario) ',' num2str(img) ').png']);
            imwrite(uint8(x), original_image_path);
            
            % Save observed image
            observed_image_path = fullfile(folder_path, ['observed_image(' num2str(scenario) ',' num2str(img) ').png']);
            imwrite(uint8(obs_img), observed_image_path);
            
            % Save inpainted image
            inpainted_image_path = fullfile(folder_path, ['inpainted_image(' num2str(scenario) ',' num2str(img) ').png']);
            imwrite(uint8(unknown_signal), inpainted_image_path);
    
        end
    end
    
    fclose(fileID);

end

