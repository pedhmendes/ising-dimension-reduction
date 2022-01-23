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


## Ising Model

The data are generate with *1e5 MCS* of transient time and *1e6 MCS* of measurement.
In measurement time are generated histograms and in the end we get the mean.
The observables are stored in the datafile name.

I simulated 131 temperatures a 100 times each temperature.
The plot of Magnetization and Energy are showed below.

Magnetization

<figure>
  <img src=https://github.com/pedhmendes/ising-dimension-reduction/blob/main/plots/ising_mag_L80.png>
</figure>

Energy

<figure>
  <img src=https://github.com/pedhmendes/ising-dimension-reduction/blob/main/plots/ising_ene_L80.png>
</figure>

Both of these plots are from *Lzise* = 80 and the line in *T = 2.269* represents the analytical critical temperature.

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

## Results
### PCA 
As explained in the paper we need to make a matrix where each row is one system and the columns are the spins sites.
I did more temperatures than the paper, but the results are similar, the matrix of each *Lsize* can be found in the data folder.
When you make the PCA the first thing is to look at the number of more important principal components.
The plot below shows the first ten principal components for *Lsizes* equals to 20, 40 and 80.

<figure>
  <img src=https://github.com/pedhmendes/ising-dimension-reduction/blob/main/plots/ising_pca_multi_evals.png>
</figure>

There is only one principal component, so we plot the projections where the first principal component is the X axis and the second is the Y axis.
We can see the plot below where the first is for *Lsize* 20, following *Lsize* 40 in the middle and *Lsize* 80 in the end.

<figure>
  <img src=https://github.com/pedhmendes/ising-dimension-reduction/blob/main/plots/ising_pca_components.png>
</figure>

If we plot the temporal series, magnetization and energy, with this color labels we can see somenthing like this

Magnetization

<figure>
  <img src=https://github.com/pedhmendes/ising-dimension-reduction/blob/main/plots/ising80_mag_pca_colors_L80.png>
</figure>

Energy

<figure>
  <img src=https://github.com/pedhmendes/ising-dimension-reduction/blob/main/plots/ising80_ene_pca_colors_L80.png>
</figure>


The energy plot does not say much, but the magnetization does.
It look like as if we smashed the data points along the critical temperature and then turn around, we would get something like the PCA projections.
So one can say PCA found that the most significant variation of the data is the magnetization. 
So magnetization can be used as an indicator of the phase transition.

