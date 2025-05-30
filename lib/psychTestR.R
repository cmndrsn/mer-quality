text_rating_page <- function(
    include_rating = TRUE,
    label, 
    prompt,
    one_line = FALSE,
    save_answer = TRUE,
    placeholder = NULL,
    button_text = "Next",
    width = "1000px",
    height = "200px", # only relevant if one_line == FALSE
    validate = function(answer, ...) {
      res <- answer[1]
      if (!is.na(res) && nchar(res) > 5) {
        TRUE
        } else {
          "Your response was less than 5 characters. 
          Did you mean to click submit?"
        }
    },
    on_complete = NULL,
    admin_ui = NULL
) {
  stopifnot(
    psychTestR:::is.scalar.character(label),
    psychTestR:::is.scalar.logical(one_line)
  )
  text_input <- shiny::textAreaInput(
    "text_input", 
    label = NULL,
    placeholder = placeholder,
    width = width
  )
  if(include_rating) {
  rating_input <- shiny::selectInput(
    "rating_input",
    label = NULL,
    choices = 1:5
    )
  }
  get_answer <- function(input, ...) {
    c(
      input$text_input,
      input$rating_input
    )
  } 
  body <- list(
    shiny::p(
      htmltools::strong(
        stringr::str_extract(
          string = prompt, 
          pattern = "(?<=\\*\\*)(.+)(?=\\*\\*)",
        )
      )
    ),
    shiny::div(
      onload = "document.getElementById('text_input').value = '';",
      psychTestR:::tagify(
        stringr::str_remove_all(
          prompt,
          pattern = "(?<=\\*\\*)(.+)(?=\\*\\*)|\\*"
        )
      ),
      text_input
    ),
    if(include_rating) {
    shiny::div(
      shiny::p("Please indicate your rating below:"),
      onload = "document.getElementByID('rating_input')",
      rating_input
    )
    }
  )
  ui <- shiny::div(
    body, 
    psychTestR::trigger_button(
      "next", 
      button_text
    )
  )
  psychTestR::page(
    ui = ui, 
    label = label, 
    get_answer = get_answer, 
    save_answer = save_answer,
    validate = validate, 
    on_complete = on_complete, 
    final = FALSE,
   admin_ui = admin_ui
 )
}


one_button_custom <- function (
    body, 
    admin_ui = NULL, 
    button_text = "Next", 
    on_complete = NULL
) {
  
  body <- list(
    shiny::p(
      htmltools::strong(
        stringr::str_extract(
          string = body, 
          pattern = "(?<=\\*\\*)(.+)(?=\\*\\*)",
        )
      )
    ),
    shiny::p(
      psychTestR:::tagify(
        stringr::str_remove_all(
          body,
          pattern = "(?<=\\*\\*)(.+)(?=\\*\\*)|\\*"
        )
      )
    )
  )
  stopifnot(
    psychTestR:::is.scalar.character(
      button_text
    )
  )
  ui <- shiny::div(
    body, 
    psychTestR::trigger_button(
      "next", 
      button_text
    )
  )
  psychTestR::page(
    ui = ui, 
    admin_ui = admin_ui, 
    on_complete = on_complete
  )
}

