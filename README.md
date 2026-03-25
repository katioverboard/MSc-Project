<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a id="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->


<!-- PROJECT LOGO 
***<br />
***<div align="center">
***  <a href="https://github.com/katioverboard/MSc-Project">
***    <img src="images/logo.png" alt="Logo" width="80" height="80">
*** </a>
-->


<h1 align="center">Variant Detection in Brassica napus</h1>

  <p align="center">
    Computational pipeline to analyse variants in NGS data
    <br />
    <a href="https://github.com/katioverboard/MSc-Project/blob/main/docs/Katarina_Gmeiner_MRes_Thesis.pdf"><strong>Full Thesis »</strong></a>
    <br />
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
  <li>
    <a href="#overview">Overview</a>
    <ul>
      <li><a href="#tools--technologies">Tools & Technologies</a></li>
      <li><a href="#repository-structure">Repository Structure</a></li>
    </ul>
  </li>
  <li>
    <a href="#workflow-summary">Workflow Summary</a>
    <ul>
      <li><a href="#methods">Methods</a></li>
    </ul>
  </li>
  <li><a href="#results">Results</a></li>
  <li><a href="#future-work">Future Work</a></li>
  <ul><li><a href="#disclaimer">Disclaimer</a></li></ul>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
</ol>
</details>



<!-- ABOUT THE PROJECT -->
## Overview

This code was developed as part of my Master of Science by Research programme.

The aim of this project was to create a robust and reproducible analysis pipeline that accurately filters and identifies variants in *Brassica napus* using next-generation sequencing (NGS) data. During this project I achieved the following:

- Developed and implemented this variant calling pipeline
- Evaluated and compared different bioinformatic software
- Automated data processing and analysis using scripts in R/Python

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Tools & Technologies

#### Programming
[![Python][Python]][Python-url]
[![R][R]][R-url]

#### NGS Data Processing & Variant Calling
[![SAMtools][SAMtools]][SAMtools-url]
[![BCFtools][BCFtools]][BCFtools-url]

#### Variant Filtering & Quality Control
[![VCFtools][VCFtools]][VCFtools-url]
[![BEDtools][BEDtools]][BEDtools-url]

#### Indexing
[![Tabix][Tabix]][Tabix-url]

### Repository Structure
`/scripts`: Main scripts used for the analysis pipeline </br>
`/filtering`: Code for applying specific filters </br>
`/fasta-clustering`: Processing of fasta files to create clusters </br>
`/unused-testing`: Evaluation of different software and packages which were not implemented in the pipeline </br>

## Workflow Summary

Mapping of reads to reference genome
BAM processing and filtering
Variant calling
Variant filtering
Wet-lab validation

![pipeline]

### Methods

- Different bioinformatic software was evaluated
- Software was selected based on
  * Ability to handle specific NGS data
  * Accuracy and reproducibility
  * integrability within the pipeline
- FASTA clustering as a means of variant detection was also tested

![fasta-cluster]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Results

![results-overview]

- In total 22 SNPs were selected for further analysis
- No INDELs passed the pipeline
- However, sequencing data did show a deletion in the FAE1 gene


![fae1-deletion]

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- LIMITATIONS -->
## Future Work

- Since the observed INDEL was filtered out, this suggests that the filtering criteria may have been too stringent.</a>
  
- The separation into SNPs and INDELs could be implemented earlier to ensure a more specific handling of different variation types. This might include the development of two separate analysis pipelines.

- Alternatively, FASTA clustering could be combined with the pipeline for more precise variant calling.

#### Disclaimer
This code was written as part of my MSc by Research thesis in 2020. While this is my most elaborate project to date, I have since refined my programming skills during work and in personal projects. :)

<!-- CONTACT -->
## Contact

Katarina Gmeiner - katarina.gmeiner@yahoo.de

<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

- The entire Bancroft lab for their continued support
- Dr. Zhesi He in particular, for guiding me through this project

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[pipeline]: https://github.com/katioverboard/MSc-Project/blob/main/docs/pipeline.png
[results-overview]: https://github.com/katioverboard/MSc-Project/blob/main/docs/results-overview.png
[fasta-cluster]: https://github.com/katioverboard/MSc-Project/blob/main/docs/fasta-cluster.png
[fae1-deletion]: https://github.com/katioverboard/MSc-Project/blob/main/docs/FAE1-deletion.png
<!-- Shields.io badges. You can a comprehensive list with many more badges at: https://github.com/inttter/md-badges -->
[R]: https://img.shields.io/badge/R-%23276DC3.svg?logo=r&logoColor=white
[R-url]: https://www.r-project.org/

[Python]: https://img.shields.io/badge/Python-3776AB?logo=python&logoColor=fff
[Python-url]: https://www.python.org/

[SAMtools]: https://img.shields.io/badge/SAMtools-BAM%20Processing%20%7C%20mpileup-blue
[SAMtools-url]: http://www.htslib.org/

[BCFtools]: https://img.shields.io/badge/BCFtools-Variant%20Calling%20%7C%20Filtering-orange
[BCFtools-url]: http://www.htslib.org/

[VCFtools]: https://img.shields.io/badge/VCFtools-Variant%20Filtering%20%7C%20QC-yellow
[VCFtools-url]: https://vcftools.github.io/

[BEDtools]: https://img.shields.io/badge/BEDtools-Exon%20Filtering%20%7C%20Intersect-green
[BEDtools-url]: https://bedtools.readthedocs.io/

[Tabix]: https://img.shields.io/badge/Tabix-VCF%20Indexing-lightgrey
[Tabix-url]: http://www.htslib.org/doc/tabix.html
