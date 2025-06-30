# load libraries

library(shiny)
library(bslib)
library(bsicons)
library(DT)

# source preprocessing script

source(here::here("scripts/preprocessing.R"))

# session id

session_id <- paste0(sample(c(letters, 0:9), 15, replace = TRUE), collapse = "")

# create ui

ui <- bslib::page_fluid(
  titlePanel("MER Quality Analysis"),
  sidebarLayout(
    sidebarPanel(
      fixedPanel(textOutput("progress")),
      hr(),
      actionButton("previous", "Previous"),
      actionButton("next", "Next"),
      downloadButton("download", "Download CSV of responses"),
      hr(),
      bslib::card(
      span(
          p(icon('info-circle'), strong("Additional info")),
        textOutput("additional_info"),
      ),
      bslib::accordion( 
        bslib::accordion_panel(
          "About this data quality dimension",
          textOutput("dq_defs"),
        )
      )
      )
    ),
    mainPanel(
      bslib::input_dark_mode(),
      htmlOutput("heading"),
      textOutput("prompt"),
      uiOutput("ui"),
      DTOutput("editable_table")
      
    ),
  )
)

server <- function(input, output, session) {
  
  
  # track prompt index
  this_prompt <- reactiveVal(1)
  
  output$additional_info <- renderText({
    label <- generate_defs(
      paste(prompt[this_prompt()]),
      definitions,
      ""
    )
    return(label)
  })
  output$dq_defs <- renderText({
      label <- generate_defs(
        paste(heading[this_prompt()]),
        definitions_dq,
        "There is nothing to display for this page."
      )
    return(label)
  })
  # prepare reactive dataframe for storing responses
  responses <- reactiveValues(
    data = data.frame(
      prompt = character(),
      response = character(),
      rating = numeric(),
      rater = character(),
      dataset = character(),
      prompt_number = character(),
      timestamp = character(),
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
           # this code is very verbose...
           selected = ifelse( # if no value was previously selected:
             is.null(tail(responses$data$rating[responses$data$prompt_number == this_prompt()], 1)),
             NA,  # then select NA (corresponding to "none selected" option)
             tail( #otherwise, select previously selected value *IF* not blank.
             responses$data$rating[
               responses$data$prompt_number == this_prompt()][
                 responses$data$rating[
                   responses$data$prompt_number == this_prompt()] != ""], 
             n = 1)
           ),
           inline = TRUE),
        textAreaInput(
          "response",
          strong("Comments:"), 
          width = '300%', 
          height = '1000%',
          value = tail(
            responses$data$response[responses$data$response != "" & 
                                      responses$data$prompt_number == this_prompt()], 
            n = 1)
          )
      )
      # expandable textbox for text-only responses (e.g., datasheet items)
    }  else if (this_prompt() %in% ind_textbox) {
      tagList(
        textAreaInput(
          "response", 
          strong("Comments:"), 
          width = '300%', 
          height = '1000%',
          value = tail(
            responses$data$response[responses$data$response != "" & 
                                      responses$data$prompt_number == this_prompt()], 
            n = 1)
        ),
      )
      # small textbox for tracking initials of rater.
    }  else if (this_prompt() %in% ind_rater) {
      tagList(
      )
    } else if (this_prompt() %in% ind_fc) {
      tagList(
        selectInput(
          "response",
          label = "Respond here:",
          choices = ind_fc_options[[as.character(this_prompt())]],
          selected = tail(
            responses$data$response[responses$data$response != "" & 
                                      responses$data$prompt_number == this_prompt()], 
            n = 1)
        )
      )
    } else if (this_prompt() %in% ind_mc) {
      tagList(
        checkboxGroupInput(
          "response",
          label = "Respond here:",
          choices = ind_mc_options[[as.character(this_prompt())]],
          inline = TRUE,
          selected = NA
        )
      )
    } else if (this_prompt() %in% ind_final) {
      output$editable_table <- DT::renderDT(
        width = "0%", height = "0%",
        outputId = "editable_table",
        expr = datatable(
          responses$data, #|>
          #  dplyr::group_by(dataset, rater, prompt_number, prompt) |>
           # dplyr::summarize(rating = dplyr::last(rating), response = dplyr::last(response)),
          editable = TRUE
        )
      )
    } 
  })
  

  # when user advances in survey, save columns based on response type
  observeEvent(input[["next"]], {
    
    if(this_prompt() == ind_final) {
    # Observe cell edits and update the reactiveVal
    observeEvent(input$editable_table_cell_edit, {
      info <- input$editable_table_cell_edit
      updated <- responses$data
      updated[info$row, info$col] <- DT::coerceValue(info$value, updated[info$row, info$col])
      responses$data <- updated
    })
    } else {
      responses$data <- rbind(
        responses$data, 
        data.frame(
          # store prompt
          prompt = prompt[this_prompt()],
          # store response if question has textbox
          response = ifelse(
            this_prompt() %in% c(
              ind_textbox, 
              ind_rating, 
              ind_fc, 
              ind_mc
            ), 
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
          prompt_number = this_prompt(),
          timestamp = date()
        ))
    }
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
    if (this_prompt() < length(prompt)) {
      this_prompt(this_prompt() + 1)
    }
  })
  
  # previous question
  observeEvent(input[["previous"]], {
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
        prompt_number = this_prompt(),
        timestamp = date()
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
