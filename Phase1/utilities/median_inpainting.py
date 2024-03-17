import numpy as np

def median_inpainting(Y, deletion_set):
    """
    Median estimator for inpainting missing pixels in an image.
    
    Parameters:
        Y (numpy.ndarray): Input image.
        deletion_set (numpy.ndarray): Indices of missing pixels.
    
    Returns:
        numpy.ndarray: Inpainted image.
    """
    M, N = Y.shape
    Y0_median = Y.copy()

    rows,cols = np.unravel_index(deletion_set, Y0_median.shape)
    Y0_median[rows,cols] = np.nan


    win_size = 0
    bitmap_NaN = np.isnan(Y0_median)
    
    while np.sum(bitmap_NaN) > 0:
        Y0_median_prev = np.copy(Y0_median)
        win_size += 1
        indices_NaN = np.where(bitmap_NaN)
        
        for i in range(len(indices_NaN[0])):
            row_nan, col_nan = indices_NaN[0][i], indices_NaN[1][i]
            row_start = max(1, row_nan - win_size)
            row_end = min(M, row_nan + win_size)
            col_start = max(1, col_nan - win_size)
            col_end = min(N, col_nan + win_size)
            
            neighbors_NaN = Y0_median_prev[row_start:row_end, col_start:col_end]
            median_val = np.nanmedian(neighbors_NaN)
            Y0_median[row_nan, col_nan] = median_val
        
        bitmap_NaN = np.isnan(Y0_median)
    
    return Y0_median