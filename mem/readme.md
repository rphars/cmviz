# MEM

MEM is a Shiny application that visualizes the marginal effects at the mean. As the increase in X become smaller (i.e. approaches an instantaneous change),
the increase in p(y=1) approaches the marginal effect at the mean (MEM)

## Run

To run this Shiny app locally, install the following R packages first:

```r
install.packages(c("shiny", "ggplot2","mfx"))
```

then use:

```r
shiny::runGitHub("rphars/cmviz",subdir="MEM")
```