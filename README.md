![BRAPH 2](braph2banner.png)

[![BRAPH 2](https://img.shields.io/twitter/url?label=BRAPH%202&style=social&url=https%3A%2F%2Ftwitter.com%2Fbraph2software)](https://twitter.com/braph2software)
[![Website](https://img.shields.io/website?up_message=braph.org&url=http%3A%2F%2Fbraph.org%2F)](http://braph.org/)
[![DOI](https://img.shields.io/badge/DOI-10.1371%2Fjournal.pone.0178798-blue)](https://doi.org/10.1371/journal.pone.0178798)


# BRAPH 2 Composite RFE
The **BRAPH 2 Composite RFE** is a BRAPH 2 distribution designed to implement and to validate the composite recursive feature elimination approach with fMRI data.

## Software compilation

The compiled version of the software is already provided in this repository under `braph2composite_rfe` folder. However, if you would like to compile the software again (for example, after implementing new functionalities in BRAPH 2, or adding new pipelines), you simply just need to run `braph2genesis('braph2composite_rfe.m')`. This will re-generate `braph2composite_rfe` folder which can then be used as explained above. **WARNING**: To ensure a successful compilation, the folder `braph2composite_rfe` should be erased and all of its dependencies should be removed from the MATLAB path. This folder will be regenerated after a successful compilation.

