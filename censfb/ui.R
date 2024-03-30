ui <- fluidPage(
  titlePanel("Donation Censoring App"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("censoring",
                  "Censoring threshold (from below):",
                  min = -500,
                  max = 500,
                  value = -500,
                  step = 10
      ),
      actionButton("toggle_regression", "Toggle Regression Line")
    ),
    mainPanel(
      plotOutput("regressionPlot"),
      verbatimTextOutput("betas")
    )
  )
)
