library(shiny)
library(plotly)

server <- function(input, output, session) {
  # Variable to store the currently selected x value
  selected_x <- reactiveVal(NULL)
  
  output$regressionPlot <- renderPlotly({
    x_range <- seq(1, 20, by = 0.1)
    beta_0 <- input$beta0Input
    beta_1 <- input$beta1Input
    lambda <- exp(beta_0 + beta_1 * x_range)
    
    p <- plot_ly(x = ~x_range, y = ~log(lambda), type = 'scatter', mode = 'lines',
                 line = list(color = 'blue'), source = "regressionPlot") %>%
      layout(title = "Log(λ) as a function of x (Poisson Regression)",
             xaxis = list(title = "x"),
             yaxis = list(title = "Log(λ)"))
    
    # Add a marker for the selected point if it exists
    if (!is.null(selected_x())) {
      selected_lambda <- exp(beta_0 + beta_1 * selected_x())
      p <- add_markers(p, x = c(selected_x()), y = log(selected_lambda), 
                       marker = list(color = 'red', size = 10))
    }
    
    p
  })
  
  observeEvent(event_data("plotly_click", source = "regressionPlot"), {
    click_data <- event_data("plotly_click", source = "regressionPlot")
    if (!is.null(click_data)) {
      selected_x(click_data$x)
      output$poissonPlot <- renderPlotly({
        lambda <- exp(input$beta0Input + input$beta1Input * selected_x())
        dist_data <- rpois(1000, lambda)
        plot_ly(x = dist_data, type = "histogram", histnorm = "probability") %>%
          layout(title = paste("Poisson Distribution for λ =", round(lambda, 2)),
                 xaxis = list(title = "Outcome", range = c(0, max(dist_data) + 1)),
                 yaxis = list(title = "Probability"))
      })
    }
  })
  
  # Adjust to start with a lambda of 0.01 by default and prevent negative x-axis values
  output$poissonPlot <- renderPlotly({
    lambda <- if (is.null(selected_x())) 0.01 else exp(input$beta0Input + input$beta1Input * selected_x())
    dist_data <- rpois(1000, max(lambda, 0.01))  # Ensure lambda starts at 0.01 and is not negative
    plot_ly(x = dist_data, type = "histogram", histnorm = "probability") %>%
      layout(title = paste("Poisson Distribution for λ =", round(lambda, 2)),
             xaxis = list(title = "Outcome", range = c(0, max(dist_data) + 1)),
             yaxis = list(title = "Probability"))
  })
}