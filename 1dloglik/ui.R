
# Define UI
ui <- fluidPage(
  titlePanel("Maximum Likelihood Estimation: Normal Distribution"),
  
  sidebarLayout(
    sidebarPanel(
      actionButton("generate_data", "Generate Data"),
      sliderInput("mean", "Select Mean:", min = -10, max = 10, value = 0, step = 0.1),
      sliderInput("variance", "Select Variance:", min = 0.1, max = 10, value = 1, step = 0.1),
      actionButton("update_pdf", "Update PDF"),
      actionButton("reset", "Reset")
    ),
    
    mainPanel(
      fluidRow(
        column(6, plotOutput("data_plot")),
        column(6, plotOutput("log_likelihood_plot"))
      )
    )
  )
)