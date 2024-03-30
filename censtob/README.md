# censtob

Censtob is a shiny app that contains four sub applications, which illustrate censoring from above, below, the latent variable underlying the tobit type 1, and the cdf that the tobit type 1 uses.

## Run

To run this Shiny app locally, install the following R packages first:

```r
install.packages(c("shiny", "ggplot2","censReg"))
```

then use:

```r
shiny::runGitHub("rphars/cmviz",subdir="censtob")
```