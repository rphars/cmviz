library(shiny)


server <- function(input, output) {
  # Nested logit model probabilities
  nested_probs <- reactive({
    lambda <- as.numeric(input$scaling_parameter)
    u_redbus <- as.numeric(input$utility_redbus)
    u_car <- as.numeric(input$utility_car)
    
    exp_utility_redbus <- exp(u_redbus / lambda)
    exp_utility_bluebus <- exp(u_redbus / lambda) # Identical utility as red bus
    exp_utility_car <- exp(u_car) # Car is outside of bus nest, so no lambda
    
    # Log-sum for the bus nest
    logsum_bus_nest <- lambda*log(exp_utility_redbus + exp_utility_bluebus)
    
    # Total utility for the bus nest
    total_utility_bus_nest <- logsum_bus_nest
    
    # Denominators for the nested logit choice probabilities
    denom_bus_nest <- exp_utility_redbus + exp_utility_bluebus
    denom_nested_logit <- exp(total_utility_bus_nest) + exp_utility_car
    
    # Probabilities
    choice_prob_redbus <- (exp_utility_redbus / denom_bus_nest) * (exp(total_utility_bus_nest) / denom_nested_logit)
    choice_prob_car <- exp_utility_car / denom_nested_logit
    
    # Conditional probabilities within the bus nest
    conditional_prob_redbus <- exp_utility_redbus / denom_bus_nest
    conditional_prob_bluebus <- exp_utility_bluebus / denom_bus_nest
    
    list(
      choice_prob_redbus = choice_prob_redbus,
      choice_prob_car = choice_prob_car,
      conditional_prob_redbus = conditional_prob_redbus,
      conditional_prob_bluebus = conditional_prob_bluebus,
      logsum_bus_nest = logsum_bus_nest
    )
  })
  
  # Generating the tree diagram
  output$tree_output <- renderGrViz({
    probs <- nested_probs()
    u_redbus <- as.numeric(input$utility_redbus)
    u_car <- as.numeric(input$utility_car)
    lambda <- as.numeric(input$scaling_parameter)
    
    grViz(paste0("
      digraph transportation {
        graph [rankdir = 'TB']
        node [shape = rectangle, style = filled, fillcolor = white, fontsize = 12]
        
        Transportation -> BusNest [label = 'ln(IV) = ", round(probs$logsum_bus_nest, 2),"\\nIV=",round(exp(probs$logsum_bus_nest), 2), "\\nP(Bus Nest) = ", 1-round(probs$choice_prob_car, 4), "']
        Transportation -> Car [label = 'U(Car) = ", input$utility_car, "\\nexp(U(Car)) = ", round(exp(u_car), 2), "\\nP(Car) = ", round(probs$choice_prob_car, 4), "']
        BusNest -> RedBus [label = 'U(Red Bus) = ", input$utility_redbus, "\\nP(Red Bus) = ", round(probs$conditional_prob_redbus, 4), "']
        BusNest -> BlueBus [label = 'U(Blue Bus) = ", input$utility_redbus, "\\nP(Blue Bus) = ", round(probs$conditional_prob_bluebus, 4), "']
      }
    "))
  })
}
