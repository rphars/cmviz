ui <- fluidPage(
  titlePanel("Censoring App"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("censoring",
                  "Censoring threshold (from above):",
                  min = 0,
                  max = 1,
                  value = 1,
                  step = 1
      ),
      actionButton("toggle_regression", "Toggle Regression Line")
    ),
    mainPanel(
      plotOutput("regressionPlot"),
      verbatimTextOutput("betas")
    )
  )
)
