library(shiny)
library(ggplot2)
library(patchwork)

server <- function(input, output, session) {
  # Generate data for logistic regression
  generate_data <- reactive({
    set.seed(42)
    n <- 100
    x <- rnorm(n, mean = 0, sd = 1.5)
    B <- input$B
    z <- B * x
    p <- 1 / (1 + exp(-z))
    y <- rbinom(n, 1, p)
    odds <- exp(z)
    data.frame(x = x, y = y, log_odds = z, probability = p, odds = odds)
  })
  
  output$combinedPlot <- renderPlot({
    selected_x <- input$selectedX
    B <- input$B
    
    # Calculate log odds, odds, and probability for the selected x value
    z_selected_x <- B * selected_x
    odds_selected_x <- exp(z_selected_x)
    p_selected_x <- 1 / (1 + exp(-z_selected_x))
    selected_data <- data.frame(x = selected_x, log_odds = z_selected_x, odds = odds_selected_x, probability = p_selected_x)
    
    logOddsPlot <- ggplot(data = generate_data(), aes(x = x, y = log_odds)) +
      geom_line() +
      geom_point(data = selected_data, aes(x = x, y = log_odds), color = "red", size = 3) +
      coord_cartesian(xlim = c(-3, 3), ylim = c(min(generate_data()$log_odds) - 1, max(generate_data()$log_odds) + 1))
    
    oddsPlot <- ggplot(data = generate_data(), aes(x = x, y = odds)) +
      geom_line() +
      geom_point(data = selected_data, aes(x = x, y = odds), color = "red", size = 3) +
      coord_cartesian(ylim = c(min(generate_data()$odds) - 1, max(generate_data()$odds) + 1))
    
    probabilityPlot <- ggplot(data = generate_data(), aes(x = x, y = probability)) +
      geom_line() +
      geom_point(data = selected_data, aes(x = x, y = probability), color = "red", size = 3) +
      coord_cartesian(ylim = c(0, 1))
    
    (logOddsPlot + oddsPlot + probabilityPlot) + plot_layout(ncol = 3)
  })
}

