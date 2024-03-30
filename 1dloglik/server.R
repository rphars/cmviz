library(ggplot2)
server <- function(input, output, session) {
  
  data <- reactiveVal(NULL)
  log_likelihoods <- reactiveVal(data.frame(mean = numeric(0), log_likelihood = numeric(0)))
  plot_distribution <- reactiveVal(FALSE)
  
  observeEvent(input$generate_data, {
    data(rnorm(100, mean = input$mean, sd = sqrt(input$variance)))
    plot_distribution(FALSE)
  })
  
  observeEvent(input$update_pdf, {
    plot_distribution(TRUE)
  })
  
  observeEvent(input$reset, {
    data(NULL)
    log_likelihoods(NULL)
    plot_distribution(FALSE)
  })
  
  
  output$data_plot <- renderPlot({
    if (!is.null(data())) {
      data_frame <- data.frame(x = data())
      
      plot <- ggplot() +
        geom_point(data = data_frame, aes(x = x, y = 0), size = 3) +
        theme_minimal() +
        xlab("Data") +
        ylab("") +
        ggtitle("Maximum Likelihood Estimation: Normal Distribution")
      
      if (plot_distribution()) {
        plot <- plot + stat_function(fun = dnorm, args = list(mean = input$mean, sd = sqrt(input$variance)), aes(x = ..x.., y = ..y..), color = "red", size = 1)
      }
      
      # Add a transparent blank layer with a wider y-axis range
      plot <- plot + geom_blank(data = data.frame(x = c(input$mean - 4 * sqrt(input$variance), input$mean + 4 * sqrt(input$variance)), y = c(-0.05, 1)), aes(x, y)) +
        coord_cartesian(xlim = c(input$mean - 4 * sqrt(input$variance), input$mean + 4 * sqrt(input$variance)), ylim = c(-0.05, 0.5))
      
      return(plot)
    }
  })
  
  observeEvent(list(input$mean, input$variance), {
    if (plot_distribution()) {
      current_data <- data()
      log_likelihood <- sum(dnorm(current_data, mean = input$mean, sd = sqrt(input$variance), log = TRUE))
      current_log_likelihoods <- log_likelihoods()
      current_log_likelihoods <- rbind(current_log_likelihoods, data.frame(mean = input$mean, log_likelihood = log_likelihood))
      log_likelihoods(current_log_likelihoods)
    }
  })
  
  output$log_likelihood_plot <- renderPlot({
    if (!is.null(log_likelihoods())) {
      ggplot(log_likelihoods(), aes(x = mean, y = log_likelihood)) +
        geom_line() +
        geom_point() +
        theme_minimal() +
        xlab("Mean") +
        ylab("Log-Likelihood") +
        ggtitle("Log-Likelihoods")
    }
  })
}
