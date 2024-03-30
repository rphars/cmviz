# lvcensoring

This is a Shiny application that gives some intuition for tobit models. It shows  Y* (latent variable), and shows what happens to the probability of crossing the treshold at higher y values, building intuition for cdf's.

## Run

To run this Shiny app locally, install the following R packages first:

```r
install.packages(c("shiny", "ggplot2"))
```

then use:

```r
shiny::runGitHub("rphars/cmviz",subdir="lvcensoring")
```