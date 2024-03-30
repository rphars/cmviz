library(DiagrammeR)
# Define UI
ui <- fluidPage(
  titlePanel("Nested Logit Model"),
  sidebarLayout(
    sidebarPanel(
      #this example restricts U(rebus) to be same as U(bluebus), just to make examples/calcs more easily followable
      textInput("utility_redbus", "Utility of either bus:", value = "5"),
      textInput("utility_car", "Utility of Car:", value = "5"),
      sliderInput("scaling_parameter", "Scaling Parameter (λ):", min = 0.01, max = 1, value = 1, step = 0.01)
    ),
    mainPanel(
      grVizOutput("tree_output")
    )
  )
)
