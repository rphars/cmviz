# nestedviz

nestedviz is a Shiny application that visualizes how nested logit models (specifically the scaling parameter) 'deals with' options that violate IIA

## Run

To run this Shiny app locally, install the following R packages first:

```r
install.packages(c("shiny", "DiagrammeR"))
```

then use:

```r
shiny::runGitHub("rphars/cmviz",subdir="nestedviz")
```