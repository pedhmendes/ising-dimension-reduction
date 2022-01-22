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

## Resultados
### Ising 
Esses resultados tem uma estatística melhor, os observáveis são dados pela média do tempo de análise. Agora tem mais pontos, 13100 pontos (131 T x 100 samples).

Plots dos observáveis relevantes. Nas figs abaixo temos para L80

Magnetização

| <img src=https://github.com/pedhmendes/ising-dimension-reduction/blob/main/plots/ising_mag_L80.png width="10500"> | <img src=https://github.com/pedhmendes/ising-dimension-reduction/blob/main/plots/ising_ene_L80.png width="10500"> |
|-----|-----|

<img src=https://github.com/pedhmendes/ising-dimension-reduction/blob/main/plots/ising_mag_L80.png>
<img src=https://github.com/pedhmendes/ising-dimension-reduction/blob/main/plots/ising_ene_L80.png>
