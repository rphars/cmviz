
# Define UI
ui <- fluidPage(
  titlePanel("OLS Simulation with Normal Distributions"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("B", "Set OLS Coefficient (B):", min = -2, max = 2, value = 0, step = 0.1),
      sliderInput("y_value", "Set Threshold:", min = -15, max = 15, value = 15, step = 0.1),
      checkboxInput("show_data_points", "Show Data Points", value = TRUE),
      checkboxInput("show_normal_overlay", "Show Normal Distribution Overlay", value = FALSE),
      checkboxInput("show_regression_line", "Show Regression Line", value = FALSE)
    ),
    mainPanel(
      plotOutput("olsPlot")
      
    )
  )
)