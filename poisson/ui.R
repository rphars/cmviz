ui <- fluidPage(
  titlePanel("Interactive Visualization of Poisson Regression"),
  sidebarLayout(
    sidebarPanel(
      numericInput("beta0Input", "Input β₀ (Intercept):", value = 0),
      numericInput("beta1Input", "Input β₁ (Slope):", value = 0.1)
    ),
    mainPanel(
      # Wrap plotlyOutput in a div and apply style for margin
      div(plotlyOutput("poissonPlot", height = "200px"), style = "margin-bottom: 20px;"),
      div(plotlyOutput("regressionPlot", height = "200px"), style = "margin-top: 20px;")
    )
  )
)
