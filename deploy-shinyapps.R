# Deploy to shinyapps.io with an explicit file set so rsconnect does not scan
# dev/tests/data-raw (avoids false deps: attachment, covrpage, spelling, etc.).
#
# From the package root:
#   source("deploy-shinyapps.R")

stopifnot(
  file.exists("DESCRIPTION"),
  file.exists("app.R")
)

if (!file.exists("R/sysdata.rda")) {
  stop(
    "Missing R/sysdata.rda (internal checklist data). Source data-raw/questions.R first.",
    call. = FALSE
  )
}

r_dir_files <- list.files(
  "R",
  pattern = "\\.(R|r|rda|RData)$",
  full.names = TRUE,
  recursive = TRUE
)

app_files <- c(
  "app.R",
  "DESCRIPTION",
  "NAMESPACE",
  r_dir_files,
  list.files("inst", full.names = TRUE, recursive = TRUE)
)

# Optional: removes renv snapshot warning for the package itself
# renv::install(".", prompt = FALSE)

rsconnect::deployApp(
  appDir = ".",
  appFiles = app_files,
  appPrimaryDoc = "app.R",
  appName = "CorePrincipleGenAIChecklist",
  appTitle = "CorePrincipleGenAIChecklist",
  lint = FALSE,
  forceUpdate = TRUE
)
