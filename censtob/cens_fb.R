cens_fb_serv <- function(input, output, session) {
  set.seed(123)
  n <- 100
  x_unscaled <- runif(n, min = 1, max = 5)
  x_mean <- mean(x_unscaled)
  x <- x_unscaled - x_mean
  donation_amount <- reactive({150 * x + rnorm(n, sd = 50)})

  observe({
    updateSliderInput(session, "censoring",
                      min = -500,
                      max = 500,
                      value = -500,
                      step = 10)
  })

  donation_censored <- reactive({
    censoring <- input$censoring
    pmax(donation_amount(), censoring)
  })

  show_regression <- reactiveVal(FALSE)

  observeEvent(input$toggle_regression, {
    show_regression(!show_regression())
  })

  output$regressionPlot <- renderPlot({
    data <- data.frame(x = x, donation_censored = donation_censored())
    model <- lm(donation_censored() ~ x, data = data)

    plot <- ggplot(data, aes(x = x, y = donation_censored())) +
      geom_point() +
      labs(title = "Regression with Censoring",
           x = "x",
           y = "Y(censored)") +
      theme_minimal() +
      coord_cartesian(ylim = range(donation_amount()))

    if (show_regression()) {
      plot <- plot + geom_abline(aes(intercept = coef(model)[1], slope = coef(model)[2]), color = "red")
    }

    plot
  })

  output$betas <- renderText({
    data <- data.frame(x = x, donation_censored = donation_censored())
    model <- lm(donation_censored() ~ x, data = data)

    paste("True population beta:", 150,
          "\nEstimated beta (censored data):", round(coef(model)[2], 4))
  })
}
cens_fb_ui <- function(id) {
  ns <- NS(id)
  ui <- fluidPage(
    titlePanel("Censoring from below"),
    sidebarLayout(
      sidebarPanel(
        sliderInput(ns("censoring"),
                    "Censoring threshold (from below):",
                    min = -500,
                    max = 500,
                    value = -500,
                    step = 10
        ),
        actionButton(ns("toggle_regression"), "Toggle Regression Line")
      ),
      mainPanel(
        plotOutput(ns("regressionPlot")),
        verbatimTextOutput(ns("betas"))
      )
    )
  )
}

