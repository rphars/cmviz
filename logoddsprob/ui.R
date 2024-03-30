ui <- fluidPage(
  titlePanel("Logistic Regression: log odds/odds/probability"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("B", "Strength of Relationship (B)", min = -10, max = 10, value = 1, step = 0.1),
      sliderInput("selectedX", "Select x value", min = -3, max = 3, value = 0, step = 0.01),
      helpText("Note: We don't include a constant, so the baseline odds are 1:1.")
    ),
    mainPanel(
      plotOutput("combinedPlot")
    )
  )
)