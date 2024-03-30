# Load required packages
library(shiny)
library(ggplot2)
library(mfx)

server <- function(input, output, session) {
  # Simulate data
  set.seed(666)
  x1 <- rnorm(1000)
  x2 <- rnorm(1000)
  z <- 1 + 2 * x1 + 3 * x2
  pr <- 1 / (1 + exp(-z))
  y <- rbinom(1000, 1, pr)
  
  # Estimate the logit model
  df <- data.frame(y = y, x1 = x1, x2 = x2)
  m1 <- glm(y ~ x1, data = df, family = "binomial")
  df$pred <- predict(m1, type = "response")
  
  # Store the click event information in a reactive value
  plot_click <- reactiveVal(NULL)
  
  observeEvent(input$plot_click, {
    plot_click(input$plot_click)
  })
  
  # Generate the logit plot
  output$logit_plot <- renderPlot({
    base_plot <- ggplot(df, aes(x = x1, y = pred)) +
      geom_point() +
      geom_vline(aes(xintercept = mean(x1)), color = "blue", linetype = "dashed") +
      labs(x = "x1", y = "Predicted Probability (y = 1)")
    
    if (!is.null(plot_click()$x)) {
      base_plot <- base_plot +
        geom_vline(aes(xintercept = plot_click()$x), color = "red", linetype = "dashed")
    }
    
    base_plot
  })
  
  # Calculate probabilities and marginal effects
  output$prob_output <- renderText({
    if (is.null(plot_click()$x)) {
      return(NULL)
    }
    user_x <- plot_click()$x
    mean_x <- mean(df$x1)
    prob_mean <- predict(m1, newdata = data.frame(x1 = mean_x), type = "response")
    prob_user <- predict(m1, newdata = data.frame(x1 = user_x), type = "response")
    diff_prob <- prob_user - prob_mean
    paste(" P(y = 1) at mean x1:", round(prob_mean, 4),"\n",
          "P(y = 1) at selected x1:", round(prob_user, 4),"\n",
          "Difference:", round(diff_prob, 4),"\n",
          "Scaled to 1 unit change", round(diff_prob/(user_x-mean_x),4))
    
    
  })
  
  output$mfx_output <- renderText({
    mfx_res <- logitmfx(y ~ x1, data = df)
    paste("MEM", round(mfx_res$mfxest[, "dF/dx"], 4))
  })
  
  
}