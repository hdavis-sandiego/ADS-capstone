

library(shiny)
library(reticulate)



# Define UI for application that draws a histogram
actual_variable_names <- c('NO_AFFECTED', 'NEGLIGENCE_SCORE', 'LIKELIHOOD_SCORE',
                           'SECTION_OF_ACT_FILTERED_0', 'SECTION_OF_ACT_FILTERED_103(a)',
                           'SECTION_OF_ACT_FILTERED_103(d)', 'SECTION_OF_ACT_FILTERED_103(h)',
                           'SECTION_OF_ACT_FILTERED_104(a)', 'SECTION_OF_ACT_FILTERED_104(b)',
                           'SECTION_OF_ACT_FILTERED_104(g)(1)', 'SECTION_OF_ACT_FILTERED_109(a)',
                           'SECTION_OF_ACT_FILTERED_316(b)',
                           'SECTION_OF_ACT_FILTERED_316(b)(2)(A)',
                           'SECTION_OF_ACT_FILTERED_316(b)(2)(F)(ii)', 'MINE_TYPE_Facility',
                           'MINE_TYPE_Surface', 'MINE_TYPE_Underground', 'COAL_METAL_IND_C',
                           'COAL_METAL_IND_M')

ui <- fluidPage(
  titlePanel("30 Day Post Violation Predictions"),
  sidebarLayout(
    sidebarPanel(
      numericInput("num_variables", "Variable Inputs:", value = 19),
      uiOutput("variable_inputs"),
      actionButton("predict_button", "Predict")
    ),
    mainPanel(
      verbatimTextOutput("prediction_output")
    )
  )
)

server <- function(input, output, session) {
  output$variable_inputs <- renderUI({
    num <- input$num_variables
    inputs <- lapply(1:num, function(i) {
      tagList(
        textInput(paste0("var_name_", i), paste("Variable", i, "Name:"), value = actual_variable_names[i]),
        numericInput(paste0("var_value_", i), paste("Value for", i, ":"), value = 0)
      )
    })
    do.call(tagList, inputs)
  })
  
  observeEvent(input$predict_button, {
    num <- input$num_variables
    
    # Prepare input data for Python prediction
    input_data <- lapply(1:num, function(i) {
      name <- input[[paste0("var_name_", i)]]
      value <- as.numeric(input[[paste0("var_value_", i)]])
      list(name = name, value = value)
    })
    
    # Prepare input values for Python prediction
    input_values <- sapply(input_data, function(d) {
      if (is.logical(d$value)) {
        ifelse(d$value, "True", "False")
      } else if (is.numeric(d$value)) {
        as.integer(d$value)  # Convert to integer if numeric
      } else {
        d$value  # Use as is for other types (e.g., character)
      }
    })
    
    # Convert input values to a NumPy array
    np <- import("numpy")
    input_matrix <- matrix(c(input_values), nrow=1, byrow=TRUE)

    py <- import("joblib")
    sklearn <- import("sklearn")
    np <- import("numpy")
    pickle <- import("pickle")
    model_path <- "rf_model_30.pkl"  
    model <- py$load(model_path)
    
    # Perform prediction using the model
    python_result <- model$predict(input_matrix)
    
    # Display prediction result
    output$prediction_output <- renderPrint({
      prediction_str <- paste("Python 30 Day Model Prediction:", python_result)
      paste(prediction_str)
    })
  })
}

shinyApp(ui, server)
