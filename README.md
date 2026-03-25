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


<h1 align="center">Variant Detection in Brassica Napus</h1>

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
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#workflow">Workflow</a>
    </li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## Overview

This code was developed as part of my Master of Science by Research programme. 

The aim of this project was to create a robust and reproducible analysis pipeline that accurately filters and identifies variants in *Brassica napus* using next-generation sequencing (NGS) data. 

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With

* [![R][R]][R-url]
* [![Python][Python]][Python-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Workflow

![pipeline]

<p>Preperations</p>

* Mapping of raw reads to reference sequence
* Sorting of resulting BAM files
* Shortening of sequences to include target regions

<p>Variant Calling</p>

* Exclusion of control variants
* Separation into SNPs and INDEL files
* Removal of introns
* Both: QUAL < 30
* SNPs: Missing-data < 50%
* Removal of too common variants

## Results

![results-overview]

* In total 22 SNPs were selected for further analysis
* No INDELs passed the pipeline
* However, sequencing data did show a deletion in the FAE1 gene

[fae1-deletion]

<!-- LIMITATIONS -->
## Future Work

<p>Since the present INDEL was filtered, too stringent filters might have been used</p>
<p>The separation into SNPs and INDELs could be implemented earlier to ensure a more specific handling of different variation types</p>
<p>This might include the development of two separate analysis pipelines</p>


<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->
## Contact

Katarina Gmeiner - katarina.gmeiner@yahoo.de

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* The entire Bancroft lab for their continued support
* Dr. Zhesi He in particular, for guiding me through this project

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[pipeline]: https://github.com/katioverboard/MSc-Project/blob/main/docs/pipeline.png
[results-overview]: https://github.com/katioverboard/MSc-Project/blob/main/docs/results-overview.png
[fae1-deletion]: https://github.com/katioverboard/MSc-Project/blob/main/docs/fae1-deletion.png

[contributors-shield]: https://img.shields.io/github/contributors/github_username/repo_name.svg?style=for-the-badge
[contributors-url]: https://github.com/github_username/repo_name/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/github_username/repo_name.svg?style=for-the-badge
[forks-url]: https://github.com/github_username/repo_name/network/members
[stars-shield]: https://img.shields.io/github/stars/github_username/repo_name.svg?style=for-the-badge
[stars-url]: https://github.com/github_username/repo_name/stargazers
[issues-shield]: https://img.shields.io/github/issues/github_username/repo_name.svg?style=for-the-badge
[issues-url]: https://github.com/github_username/repo_name/issues
[license-shield]: https://img.shields.io/github/license/github_username/repo_name.svg?style=for-the-badge
[license-url]: https://github.com/github_username/repo_name/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/linkedin_username
[product-screenshot]: images/screenshot.png
<!-- Shields.io badges. You can a comprehensive list with many more badges at: https://github.com/inttter/md-badges -->
[R]: https://img.shields.io/badge/R-%23276DC3.svg?logo=r&logoColor=white
[R-url]: https://www.r-project.org/
[Python]: https://img.shields.io/badge/Python-3776AB?logo=python&logoColor=fff
[Python-url]: https://www.python.org/
[Next.js]: https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[Next-url]: https://nextjs.org/
[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[React-url]: https://reactjs.org/
