import os
import numpy as np 
import re
import matplotlib.pyplot as plt
from collections import defaultdict

file1 = "copy_compiled_output_log_scenario1.txt"
file2 = "copy_compiled_output_log_scenario2.txt"

def create_table_from_IDBP_logs(logfile_path,expected_num_of_img):
    with open(logfile_path, 'r') as f:
        lines = f.readlines()
    
    image_data = {image_num: {'FINAL_PSNR': None, 'FINAL_SSIM': None, 'ITERATIONS_PSNR': []} for image_num in range(1, expected_num_of_img + 1)}
    
    
    iteration_psnr = []

    for cnt,line in enumerate(lines,start=1):
        if 'scenario_ind=' in line:
            #assert 'IDBP' not in line

            current_image = int(line.split('image_ind=')[1].split(',')[0])
            final_psnr = float(line.split('PSNR=')[1].split(',')[0])
            final_ssim  = float(line.split('SSIM=')[1].strip())
            
        
            image_data[current_image]['FINAL_PSNR'] = final_psnr
            image_data[current_image]['FINAL_SSIM'] = final_ssim
            image_data[current_image]['ITERATIONS_PSNR'] = iteration_psnr.copy()
           
            #assert len(iteration_psnr) == expected_num_of_iterations
            
            iteration_psnr = []
            
        elif 'IDBP: finished iteration' in line:
            iteration_psnr.append(float(line.split('=')[1].strip()))
        else: 
            pass
        
    return image_data

scenario1_table = create_table_from_IDBP_logs(file1,68)

scenario2_table = create_table_from_IDBP_logs(file2,68)

#print(scenario2_table)
print(">....")


num_images = 68


image_numbers = list(range(1, num_images + 1))
final_psnr_values = [table[i]['FINAL_PSNR'] for i in image_numbers]
final_ssim_values = [table[i]['FINAL_SSIM'] for i in image_numbers]

# Plot FINAL_PSNR
plt.figure(figsize=(10, 5))
plt.plot(image_numbers, final_psnr_values, marker='o', linestyle='-')
plt.title(f'Scenario#{scenario_num}: PSNRs of BSD68 dataset')
plt.xlabel('Image Number')
plt.ylabel('TOTAL PSNR')
plt.grid(True)
plt.show()

# Plot FINAL_SSIM
plt.figure(figsize=(10, 5))
plt.plot(image_numbers, final_ssim_values, marker='o', linestyle='-')
plt.title(f'Scenario#{scenario_num}: SSIMs of BSD68 dataset')
plt.xlabel('Image Number')
plt.ylabel('TOTAL SSIM')
plt.grid(True)
plt.show()

# Plot ITERATIONS_PSNR
plt.figure(figsize=(10, 5))
for image_num in range(1, num_images + 1):
    plt.plot(table[image_num]['ITERATIONS_PSNR'], label=f'Image {image_num}')
plt.title(f'Scenario#{scenario_num}: PSNR Iteration curves of BSD68 dataset')
plt.xlabel('Iteration number k')
plt.ylabel('PSNR_k')
plt.legend(loc='upper right')
plt.grid(True)
plt.show()

# for scenario_num,_ in enumerate(range(2),start=1):
#     if scenario_num == 1:
#         table = scenario1_table
#     elif scenario_num == 2:
#         table = scenario2_table
#     else:
#         exit()
#     image_numbers = list(range(1, num_images + 1))
#     final_psnr_values = [table[i]['FINAL_PSNR'] for i in image_numbers]
#     final_ssim_values = [table[i]['FINAL_SSIM'] for i in image_numbers]

#     # Plot FINAL_PSNR
#     plt.figure(figsize=(10, 5))
#     plt.plot(image_numbers, final_psnr_values, marker='o', linestyle='-')
#     plt.title(f'Scenario#{scenario_num}: PSNRs of BSD68 dataset')
#     plt.xlabel('Image Number')
#     plt.ylabel('TOTAL PSNR')
#     plt.grid(True)
#     plt.show()

#     # Plot FINAL_SSIM
#     plt.figure(figsize=(10, 5))
#     plt.plot(image_numbers, final_ssim_values, marker='o', linestyle='-')
#     plt.title(f'Scenario#{scenario_num}: SSIMs of BSD68 dataset')
#     plt.xlabel('Image Number')
#     plt.ylabel('TOTAL SSIM')
#     plt.grid(True)
#     plt.show()

#     # Plot ITERATIONS_PSNR
#     plt.figure(figsize=(10, 5))
#     for image_num in range(1, num_images + 1):
#         plt.plot(table[image_num]['ITERATIONS_PSNR'], label=f'Image {image_num}')
#     plt.title(f'Scenario#{scenario_num}: PSNR Iteration curves of BSD68 dataset')
#     plt.xlabel('Iteration number k')
#     plt.ylabel('PSNR_k')
#     plt.legend(loc='upper right')
#     plt.grid(True)
#     plt.show()