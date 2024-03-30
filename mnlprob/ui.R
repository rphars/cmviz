ui <- fluidPage(
  titlePanel("Multinomial Logit Model Visualization"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("beta1", "Beta 1 (Category 1 vs. Category 3):", min = -5, max = 5, value = 0, step = 0.1),
      sliderInput("beta2", "Beta 2 (Category 2 vs. Category 3):", min = -5, max = 5, value = 0, step = 0.1)
    ),
    mainPanel(
      plotOutput("mlogitPlot")
    )
  )
)
