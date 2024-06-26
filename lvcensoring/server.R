#todo: add slider for x values to calcualte p(cross treshold) at that value. Perhaps add red dot? 

# Load necessary libraries
library(shiny)
library(ggplot2)

# Define server
server <- function(input, output) {
  generate_data <- reactive({
    x <- seq(-10, 10, length.out = 100)
    y <- input$B * x + rnorm(length(x), mean = 0, sd = 1)
    data.frame(x = x, y = y)
  })
  
  generate_normal_cutouts <- function(x_val, B) {
    mu <- B * x_val
    range <- mu + c(-3, 3)
    seq <- seq(range[1], range[2], length.out = 100)
    data.frame(
      x = -1 * dnorm(seq, mean = mu) + x_val,
      y = seq,
      grp = x_val
    )
  }
  
  output$olsPlot <- renderPlot({
    data <- generate_data()
    cutout_data <- do.call(rbind, lapply(seq(-10, 10, length.out = 10), generate_normal_cutouts, B = input$B))
    
    plot <- ggplot() +
      geom_hline(yintercept = input$y_value, linetype = "dashed", color = "red") +
      coord_cartesian(ylim = c(-15, 15)) +
      theme_minimal() +
      theme(legend.position = "none") +
      labs(x = "X", y = "Y*", title = "OLS, censoring from above, and Tobit")
    
    if (input$show_regression_line) {
      plot <- plot + geom_line(data = data, aes(x = x, y = input$B * x), color = "blue", size = 1)
    }
    
    if (input$show_data_points) {
      plot <- plot + geom_point(data = data, aes(x = x, y = y, alpha = ifelse(y < input$y_value, 1, 0.3)), color = "black")
    }
    
    if (input$show_normal_overlay) {
      plot <- plot +
        geom_path(data = cutout_data, aes(x = x, y = y, group = grp)) +
        geom_polygon(data = cutout_data, aes(y = scales::oob_squish(y, c(input$y_value, Inf)), x = x, group = grp), fill = "gray", alpha = 0.5)
    }
    
    plot + scale_alpha_continuous(range = c(0.3, 1), guide = "none")
    return(plot)
  })
  
 
}


