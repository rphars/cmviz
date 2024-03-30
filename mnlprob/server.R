library(shiny)
library(ggplot2)

server <- function(input, output) {
  output$mlogitPlot <- renderPlot({
    beta1 <- input$beta1
    beta2 <- input$beta2
    
    x <- seq(-10, 10, length.out = 100)
    
    exp1 <- exp(beta1 * x)
    exp2 <- exp(beta2 * x)
    exp3 <- exp(0)# Reference category's utility
    
    p1 <- exp1 / (exp1 + exp2 + exp3)
    p2 <- exp2 / (exp1 + exp2 + exp3)
    p3 <- exp3 / (exp1 + exp2 + exp3)
    
    df <- data.frame(x = rep(x, 3),
                     y = c(p1, p2, p3),
                     category = factor(rep(c("Category 1", "Category 2", "Category 3"), each = length(x))))
    
    ggplot(df, aes(x, y, color = category)) +
      geom_path(size = 1.5, alpha = 0.6) +
      labs(title = "Multinomial Logit Model Probabilities", x = "X", y = "Probability") +
      scale_y_continuous(limits = c(0, 1)) +
      theme_minimal() +
      theme(legend.title = element_blank())
  })
}

