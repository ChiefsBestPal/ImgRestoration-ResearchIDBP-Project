function filled_img = median_initialization(observed_img, missing_idx)
    
    % Initialization
    missing_img = observed_img;
    missing_img(missing_idx) = NaN;

    % Dynamic kernel size starts at 1
    kernel_size = 1;

    % Until no more NaN
    while any(isnan(missing_img), 'all')
        previous_img = missing_img;
        [R, C] = find(isnan(missing_img));
        [M, N] = size(observed_img);
        
        % Fill NaNs
        for idx = 1:numel(R)
            % Fill with median value, use nanmedian instead of median
            % to improve time significantly
            kernel_values = previous_img(max(1, R(idx) - kernel_size):min(M, R(idx) + kernel_size), max(1, C(idx) - kernel_size):min(N, C(idx) + kernel_size));
            median_value = nanmedian(kernel_values(:));
            missing_img(R(idx), C(idx)) = median_value;
        end

        kernel_size = kernel_size + 1;

    end

    filled_img = missing_img;
end
