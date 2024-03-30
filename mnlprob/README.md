# mnlprob

mnlprob is a Shiny application that visualizes how the probability of multiple categories (here 3) in a multinomial logit is interrelated, and dependent on beta and x values.

## Run

To run this Shiny app locally, install the following R packages first:

```r
install.packages(c("shiny", "ggplot2"))
```

then use:

```r
shiny::runGitHub("rphars/cmviz",subdir="mnlprob")
```