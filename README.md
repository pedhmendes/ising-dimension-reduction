# Dimension Reduction on Ising Model - PCA

# PCA - Project
First project of my research in Machine Learning and Physics. 

Based on Wang 2016 "*Discovering Phase Transitions with Unsupervised Learning*" [[1]](https://journals.aps.org/prb/abstract/10.1103/PhysRevB.94.195105)

## Code List
- *ising_model.c*           -- Ising Model simulation using Monte Carlo (MC) method;
- *mc.h*                    -- C library with important MC functions;
- *job.sh*                  -- Bash script example to run a lot of programs at once;          
- *preprocessing.ipynb*     -- Jupyter Notebook with preprocessing data routine;
- *pca_ising.ipynb*         -- Jupyter Notebook with Ising PCA;

## Archives List
- *data*                    -- All data used in *.rar* files;
- *plots*                   -- All plots;

## C Codes and Shell
### Compile and Run

Download both the *code.c* and *mc.h*.
Put in the same folder and compile using

  <code>gcc -Wall prog.c -lm</code>

Run as showed below

  <code>./a.out TEMP</code>

where ```TEMP``` is the system temperature.
This is going to make, in the end o simulation, a datafile with this structure

  <code>data_TaLbMcEdSe.dat</code>

Where the capital letter indicates the observable and the lowercase letter indicates its value.
The observables are *Temperature*, *Lsize*, *Magnetization*, *Energy* and *Seed*.


To create lots of datafiles one can do a bash script, like the example.
Then you need to give permisson to run

  <code>chmod +x job.sh</code>

and run as a code

  <code>./job.sh</code>

This will create a series of datafiles, as in the data folder, then you can preprocess using the code.

## Python Notebooks
Upload in Google Drive and use [Colab](https://colab.research.google.com/) or download [Jupyter](https://jupyter.org/).
I recommend Colab, you don't have to install anything.

## Ising Model
The data are generate with *1e5 MCS* of transient time and *1e6 MCS* of measurement.
In measurement time are generated histograms and in the end we get the mean.
The observables are stored in the datafile name.

I simulated 131 temperatures a 100 times each temperature.
The plot of Magnetization and Energy are showed below.

<figure>
  <img src=https://github.com/pedhmendes/ising-dimension-reduction/blob/main/plots/ising_mag_L80.png>
</figure>
<figure>
  <img src=https://github.com/pedhmendes/ising-dimension-reduction/blob/main/plots/ising_ene_L80.png>
</figure>

Both of these plots are from *Lzise* = 80 and the line in *T = 2.269* represents the analytical critical temperature.


## Results
### PCA 
As explained in the paper we need to make a matrix where each row is one system and the columns are the spins sites.
I did more temperatures than the paper, but the results are similar, the matrix of each *Lsize* can be found in the data folder.
When you make the PCA the first thing is to look at the number of more important principal components.
The plot below shows the first ten principal components for *Lsizes* equals to 20, 40 and 80.

<figure>
  <img src=https://github.com/pedhmendes/ising-dimension-reduction/blob/main/plots/ising_pca_multi_evals.png>
</figure>

There is only one principal component, so we plot the projections where the first principal component is the X-axis and the second is the Y-axis.
We can see the plot below where the first is for *Lsize* 20, following *Lsize* 40 in the middle and *Lsize* 80 in the end.

<figure>
  <img src=https://github.com/pedhmendes/ising-dimension-reduction/blob/main/plots/ising_pca_components.png>
</figure>

The projections have more variation in the X-axis, the first principal component, than the Y-axis, the second.
The points are distributed and form three clusters, two of low temperature and one of high temperature.
Around the origin we can see some fluctuations because the X-value is so low that any variation in the Y-value tends to win over.

If we plot the temporal series, magnetization and energy, with this color labels we can see somenthing like this

<figure>
  <img src=https://github.com/pedhmendes/ising-dimension-reduction/blob/main/plots/ising80_mag_pca_colors_L80.png>
</figure>
<figure>
  <img src=https://github.com/pedhmendes/ising-dimension-reduction/blob/main/plots/ising80_ene_pca_colors_L80.png>
</figure>


The energy plot does not say much, but the magnetization does.
It look like as if we smashed the data points along the critical temperature and then turn around, we would get something like the PCA projections.
So one can say PCA found that the most significant variation of the data is the magnetization. 
So magnetization can be used as an indicator of the phase transition.

### Clusterization
If we fold the projections along the X-axis we obtain this plot

<figure>
  <img src=https://github.com/pedhmendes/ising-dimension-reduction/blob/main/plots/ising_pca_m_components.png>
</figure>

Doing this we reduct from three clusters to two, but we only joined together the two low temperature ones.
We want to divide this in two clusters, but not only by eye, using clusterization methods available in the [scikit](https://scikit-learn.org/stable/modules/clustering.html) lib.

The first one is [Spectral Clustering](https://scikit-learn.org/stable/modules/clustering.html#spectral-clustering).
This method requires the number of clusters.
We want to divide in before and after the critical temperature, so the number of clusters is two.
Below is the clusterization plot using Spectral Clustering of the projections of *Lsize* = 80.

<figure>
  <img src=https://github.com/pedhmendes/ising-dimension-reduction/blob/main/plots/ising_clusters_sp_L80.png>
</figure>

and plotting the magnetization with this color labels

<figure>
  <img src=https://github.com/pedhmendes/ising-dimension-reduction/blob/main/plots/ising80_mag_sp_cluster_L80.png>
</figure>

The two clusters do represent the phase transition, but there are some mixture when we are near the critical temperature.
We can also try different clusterization method, where we do not say the number of clusters, for example DBSCAN.

The [DBSCAN](https://scikit-learn.org/stable/modules/clustering.html#dbscan) method is based on Spectral Clustering, but it does contain noise.
This methos requires the *eps*, maximum distance between two points for one to be in the cluster of the other, and *min_samples*, the minimum number of point to be considered a cluster.
Here we used *eps* = 0.3 and *min_samples* = 65.
Below is the clusterization plot using DBSCAN of the projections of *Lsize* = 80.

<figure>
  <img src=https://github.com/pedhmendes/ising-dimension-reduction/blob/main/plots/ising_clusters_db_L80.png>
</figure

and plotting the magnetization with this color labels

<figure>
  <img src=https://github.com/pedhmendes/ising-dimension-reduction/blob/main/plots/ising80_mag_db_cluster.png>
</figure>

Here we can see three clusters, where one is the noise.
There is the low and high temperature clearly divided, and the noise data around the critical temperature, where is required more numerical precision.
Some points much more after the critical temperature classified as noise, this is the same reason as in the projections: the X-value is low, and a small variation in Y-value send then to other cluster.

## Conclusions
### PCA
PCA reduces our dimentionality, we started with a matrix of *Nsamples x (LxL)* and ended with one two vectors.
We also found that when reducing the dimension the more importante feature of Ising Model, by PCA analysis, is magnetization.
Looking only to the projections we can see the phase transition, because the data points are arranged along the axis in a unique way, this is confirmed by cluster analysis.
Note that network configuration is not considered, only the raw data of the spins, thus this method works irrespective of network configuration.

### Clusterization
In the clusterization we only confirmed what we saw in the PCA projections.
There are two clusters and they divide very well the data, with some flunctuation points.
