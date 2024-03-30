# censfb

censfb is a Shiny application that visualizes the effect of censoring (from the below)/corner solutions on regression estimates

## Run

To run this Shiny app locally, install the following R packages first:

```r
install.packages(c("shiny", "ggplot2"))
```

then use:

```r
shiny::runGitHub("rphars/cmviz",subdir="censfb")
```