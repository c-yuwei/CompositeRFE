![BRAPH 2](braph2banner.png)

[![BRAPH 2](https://img.shields.io/badge/Bluesky-BRAPH%202-blue?style=social&logo=bluesky&url=https%3A%2F%2Fbraph2software.bsky.social)](https://braph2software.bsky.social)
[![BRAPH 2](https://img.shields.io/twitter/url?label=BRAPH%202&style=social&url=https%3A%2F%2Ftwitter.com%2Fbraph2software)](https://twitter.com/braph2software)
[![cite us](https://img.shields.io/badge/DOI-10.1371%2Fjournal.pone.0178798-blue)](https://doi.org/10.1371/journal.pone.0178798)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/braph-software/BRAPH-2)](https://github.com/braph-software/BRAPH-2/releases)
[![Zenodo](https://zenodo.org/badge/DOI/10.5281/zenodo.14633697.svg)](https://doi.org/10.5281/zenodo.14633697)

# BRAPH 2 Watts–Strogatz Model  

The **BRAPH 2 Watts–Strogatz Model** is a BRAPH 2 distribution that uses the **Watts–Strogatz small-world network model** to generate simulated fMRI-like data.  
The goal is to create synthetic datasets that reproduce small-world characteristics, which are widely observed in empirical brain networks.  

This distribution builds on the analytical functionalities of the standard [BRAPH 2](https://github.com/braph-software/BRAPH-2/tree/develop) distribution.  
More details on the analysis and tutorials can be found in the main BRAPH 2 repository: [Tutorials](https://github.com/braph-software/BRAPH-2/tree/develop/tutorials).  

---

## Purpose  

The Watts–Strogatz model is used here to:  
1. **Generate small-world networks** that capture key properties of brain connectivity.  
2. **Produce simulated fMRI data** based on these networks.  
3. **Validate fMRI preprocessing and analysis pipelines** by testing whether small-worldness is detected and whether user-defined brain regions of interest can be recovered.  

## Validation  

The simulated data is validated by comparing the **average path length** of generated networks with the theoretical values expected from Watts–Strogatz graphs.  
See:  
- Argun, A., et al. (2021). *Simulation of Complex Systems*. IOP Publishing. [Link](https://iopscience.iop.org/book/mono/978-0-7503-3843-1)  

In addition, the simulated dataset is applied to verify two pipelines from the BRAPH 2 standard distribution:  

- [`pipeline_functional_analysis_wu`](https://github.com/braph-software/BRAPH-2/blob/develop/braph2/pipelines/functional/pipeline_functional_analysis_wu.braph2)  
- [`pipeline_regression_cross_validation_functional_wu_measure`](https://github.com/braph-software/BRAPH-2/blob/develop/braph2/pipelines/functional%20NN/pipeline_regression_cross_validation_functional_wu_measure.braph2)  

## Software Compilation  

A compiled version of this distribution is provided in the [`braph2wattsstrogatz`](braph2wattsstrogatz) folder.  

If you need to recompile (e.g. after adding new functionalities or pipelines), run the [`braph2genesis`](https://github.com/braph-software/BRAPH-2/blob/develop/braph2genesis.m) function:  

```matlab
braph2genesis('braph2wattsstrogatz_config.m')
```
