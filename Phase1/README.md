To run the function note that our function was written using the online MatLab program which causes difference in the files paths and may require you to addpath() the folders that are required.

The IDBP function takes parameter index, from 1-..., which determines which dataset to perform on. 
To add a dataset, you need to add the new dataset in the ```datasets``` folder.
Next you need to include the dataset name in the set ```matlab datasets = {'classics','BSD68'};```

The reason you we chose the "classic" and "BSD68" is because:
- These datasets contain real-world images. This better reflects real-world results.
- Images are diverse, which gives a diverse test set.
- These datasets are well-known, widely used, well understood, and ready available to/by the community. This allows other researchers to compare their own results.
- The size of these datasets are good for our purpose.


  
