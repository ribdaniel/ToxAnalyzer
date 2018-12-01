# ToxAnalyzer
![ToxAnalyzer Logo](https://raw.githubusercontent.com/ribdaniel/ToxAnalyzer/master/img/bitmap.png)
Code for the Final Project of DCC909 (Computational Modelling For Bioinformatics). This repo also includes some example data using benzene, which was used as a test compound to check ToxAnalyzer's functionality.

## What do I need to run ToxAnalyzer
You need Perl installed on your machine, as well as R and the ```ggplot2``` library. Internet access is needed for data download.

## How to use
Simply type ```perl Main.pl``` and then you will be prompted to enter a compound name (more than one compound can be used as a query, just use ```|``` between them). ToxAnalyzer will then lookup on the [Comparative Toxicogenomics Database](http://ctdbase.org/) ([Davies, A. P., et al., 2018](http://www.ncbi.nlm.nih.gov/pubmed/30247620)). If your compound is successfully found, it'll generate a .txt file and a .R file, the last one being called from Perl's ```system()``` function, which will finally generate a nice graphic contaning the compound(s) report data.

## How does it work?
Check the image below.
![ToxAnalyzer Functions](https://raw.githubusercontent.com/ribdaniel/ToxAnalyzer/master/img/howitworks.PNG)


## Are the results trustable?
The data depends solely on CTD's data, therefore ToxAnalyzer should be used with care and the graphics are just a start point for more elaborated analysis.

## What license is this code under?
A very permissive MIT license. :smiley: Enjoy!
