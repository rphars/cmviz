library(shiny)
library(ggplot2)

server <- function(input, output, session) {
  set.seed(123)
  n <- 100
  x <- runif(n, min = 1, max = 5)
  y <- reactive({200 * x + rnorm(n, sd = 25)})
  
  observe({
    updateSliderInput(session, "censoring",
                      min = round(min(y()), 0),
                      max = round(max(y()), 0),
                      value = round(max(y()), 0),
                      step = 1)
  })
  
  y_censored <- reactive({
    censoring <- input$censoring
    pmin(y(), censoring)
  })
  
  show_regression <- reactiveVal(FALSE)
  
  observeEvent(input$toggle_regression, {
    show_regression(!show_regression())
  })
  
  output$regressionPlot <- renderPlot({
    data <- data.frame(x = x, y_censored = y_censored())
    model <- lm(y_censored() ~ x, data = data)
    
    plot <- ggplot(data, aes(x = x, y = y_censored())) +
      geom_point() +
      labs(title = "Regression with Censoring",
           x = "X",
           y = "Y (censored)") +
      theme_minimal() +
      coord_cartesian(ylim = range(y()))
    
    if (show_regression()) {
      plot <- plot + geom_abline(aes(intercept = coef(model)[1], slope = coef(model)[2]), color = "red")
    }
    
    plot
  })
  
  output$betas <- renderText({
    data <- data.frame(x = x, y_censored = y_censored())
    model <- lm(y_censored() ~ x, data = data)
    
    paste("True population beta:", 200,
          "\nEstimated beta (censored data):", round(coef(model)[2], 4))
  })
}

