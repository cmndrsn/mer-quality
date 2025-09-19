library(gmailr)

dotenv::load_dot_env()

gm_auth_configure(path = "secrets.json")
sender <- stringr::str_split_1(Sys.getenv("SENDER_EMAIL"), ",")
receivers <- stringr::str_split_1(Sys.getenv("RECEIVER_EMAILS"), ",")
names <- stringr::str_split_1(Sys.getenv("RECEIVER_NAMES"), ",")

codenames <- c("parrot", "blackbird", "zebra", "gopher", "elephant")

write_email <- function(name, codename) {
  paste0(
    "Dear ", name, ",",
    "\n\nThis email contains your anonymous ID which you can use for the MER Quality Dataset Documentation Project.\n\n
Please enter this ID in the 'Codename' field when providing ratings using the Shiny app and refrain from sharing it with others.\n\n
Note: This email was generated with code, so I am also unaware of which codename you have been assigned.\n\n
Your codename is: ",
    codename
  )
  
}

send_codenames <- function() {
  # shuffle codenames so they are randomized
  codenames <- sample(codenames)
  for(i in 1:length(names)) {
      gm_mime() |>
      gm_to(receivers[i]) |>
      gm_from(sender) |>
      gm_subject(paste0("MER Quality Project: Your secret codename is ", codenames[i])) |>
      gm_text_body(write_email(names[i], codenames[i])) |>
      gm_send_message()
  }
  
}

# this next line of code sends the actual codenames (commented out to avoid accidental sending)

#send_codenames()

# Now retrieve check the "Sent" folder for these messages and delete them
results <- gm_messages(
  search = "subject:MER Quality Project: Your secret codename is",
  label_ids = "SENT",
  num_results = 5
)

# Extract message IDs from list
message_list <- results[[1]]$messages
# delete them sequentially
sapply(1:5,function(i) gm_delete_message(message_list[[i]]$id))





