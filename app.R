# load libraries

library(shiny)

# source preprocessing script

source(here::here("scripts/preprocessing.R"))

# session id

session_id <- Sys.time()

# create ui

ui <- bslib::page_fluid(
  titlePanel("MER Quality Analysis"),
  sidebarLayout(
    sidebarPanel(
      fixedPanel(textOutput("progress")),
      hr(),
      actionButton("previous", "Previous"),
      actionButton("next", "Next"),
      downloadButton("download", "Download CSV of responses")
    ),
    mainPanel(
      bslib::input_dark_mode(),
      htmlOutput("heading"),
      textOutput("prompt"),
      uiOutput("ui")
    ),
  )
)

server <- function(input, output, session) {
  
  # track prompt index
  this_prompt <- reactiveVal(1)
  # prepare reactive dataframe for storing responses
  responses <- reactiveValues(
    data = data.frame(
      prompt = character(),
      response = character(),
      rating = numeric(),
      rater = character(),
      dataset = character(),
      prompt_number = character(),
      stringsAsFactors = FALSE
    )
  )
  
  # render heading
  output$heading <- renderText({
    heading[this_prompt()] <- paste(
      "<h3>",
      heading[
        this_prompt()
      ],
      "</h3>"
    )
  })
  # render prompt
  output$prompt <- renderText({
    prompt[this_prompt()]
  })
  # update progress bar
  output$progress <- renderText({
    progress_bar(this_prompt(), nrow(survey_items))
  })
  
  # conditional logic for response options based on item categories:
  output$ui <- renderUI({
    # dropdown for selecting dataset
    if (this_prompt() %in% ind_dfs) {
      tagList(
        selectInput(
          "df", 
          "", 
          choices = datasets
        ),
        textInput("rater", "Please enter your initials"),
      )
      # likert-type rating scale for rating measurements, along with text
    } else if (this_prompt() %in% ind_rating) {
      tagList(
        radioButtons("rating", "Item rating:",
           c("None selected" = NA, "Strongly Disagree" = 1, "Somewhat Disagree" = 2,
             "Neither Agree Nor Disagree" = 3, "Somewhat Agree" = 4, "Strongly Agree" = 5),
           inline = TRUE),
        textAreaInput("response", "Comments:", width = '300%', height = '1000%')
      )
      # expandable textbox for text-only responses (e.g., datasheet items)
    }  else if (this_prompt() %in% ind_textbox) {
      tagList(
        textAreaInput("response", "Respond here:", width = '300%', height = '1000%'),
      )
      # small textbox for tracking initials of rater.
    }  else if (this_prompt() %in% ind_rater) {
      tagList(
        
      )
    } else if (this_prompt() %in% ind_fc) {
      tagList(
        selectizeInput(
          "response",
          label = "Respond here:",
          choices = ind_fc_options[[as.character(this_prompt())]]
        )
      )
    } else if (this_prompt() %in% ind_mc) {
      tagList(
        checkboxGroupInput(
          "response",
          label = "Respond here:",
          choices = ind_mc_options[[as.character(this_prompt())]],
          inline = TRUE
        )
      )
    } 
  })
  
  # when user advances in survey, save columns based on response type
  observeEvent(input[["next"]], {
      responses$data <- rbind(
        responses$data, 
          data.frame(
            # store prompt
            prompt = prompt[this_prompt()],
            # store response if question has textbox
            response = ifelse(
              this_prompt() %in% c(ind_textbox, ind_rating, ind_fc, ind_mc), 
              paste(input$response, collapse = ","),
              ''
            ),
            # store rating if question has rating scale
            rating = ifelse(
              this_prompt() %in% ind_rating, 
              input$rating, 
              ''
            ),
            # store 
            dataset = input$df,
            rater =  input$rater,
            prompt_number = this_prompt()
      ))
      write.csv(
        responses$data,
        file = paste0(
          'eval/',
          unique(input$rater), '_', 
          unique(input$df), '_', session_id, '.csv') |>
          tolower(),
        row.names = FALSE,
      )
      # clear input between questions
      updateTextInput(session, "response", value = "") 
      updateRadioButtons(session, "rating", selected = NA)  
      updateCheckboxGroupInput(session, "response", selected = NA) 
      updateSelectizeInput(session, "response", selected = NA)
    if (this_prompt() < length(prompt)) {
      this_prompt(this_prompt() + 1)
    }
  })
  
  # previous question
  observeEvent(input[["previous"]], {
    if (this_prompt() > 1) {
      this_prompt(this_prompt() - 1)
    }
  })
  
  # Download responses
  output$download <- downloadHandler(
    filename = function() {
      paste0(
        'merquality_',
        unique(input$rater), '_', 
        unique(input$df), '_', session_id, '.csv') |>
        tolower()
    },
    content = function(file) {
      write.csv(responses$data, file, row.names = FALSE)
    }
  )
}

questionnaire <- shinyApp(
  ui = ui, 
  server = server
)

shiny::runApp(
   questionnaire,
   host = '0.0.0.0',
   port = 3838
)
