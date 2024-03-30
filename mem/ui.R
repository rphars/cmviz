# UI
ui <- fluidPage(
  titlePanel("Logit Model Simulation"),
  sidebarLayout(
    sidebarPanel(
      actionButton("reset", "Reset"),
      verbatimTextOutput("prob_output"),
      verbatimTextOutput("mfx_output")
    ),
    mainPanel(
      plotOutput("logit_plot", click = "plot_click")
    )
  ),
  tags$script(HTML('
    Shiny.addCustomMessageHandler("resetPlotClick", function(message) {
      Shiny.onInputChange("plot_click", null);
    });
  '))
)
