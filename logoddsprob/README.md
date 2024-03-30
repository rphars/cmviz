# Logoddsprob

Logoddsprob is a Shiny application that visualizes the conversion between log odds, odds and probability. Note that the model does not include a constant, so baseline odds are 1:1.

## Run

To run this Shiny app locally, install the following R packages first:

```r
install.packages(c("shiny", "ggplot2"))
```

then use:

```r
shiny::runGitHub("rphars/cmviz",subdir="logoddsprob")
```
