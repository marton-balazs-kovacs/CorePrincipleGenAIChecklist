# Building a Prod-Ready, Robust Shiny Application.
#
# README: each step of the dev files is optional, and you don't have to
# fill every dev scripts before getting started.
# 01_start.R should be filled at start.
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
#
#
######################################
#### CURRENT FILE: DEPLOY SCRIPT #####
######################################

# Test your app

## Run checks ----
## Check the package before sending to prod
devtools::check()
rhub::check_for_cran()

# Deploy

## Local, CRAN or Package Manager ----
## This will build a tar.gz that can be installed locally,
## sent to CRAN, or to a package manager
devtools::build()

## RStudio ----
## If you want to deploy on RStudio related platforms
golem::add_rstudioconnect_file()
golem::add_shinyappsio_file()
golem::add_shinyserver_file()

## Docker ----
## If you want to deploy via a generic Dockerfile
golem::add_dockerfile_with_renv()

## If you want to deploy to ShinyProxy
golem::add_dockerfile_with_renv_shinyproxy()


# Deploy to Posit Connect or ShinyApps.io
# In command line.
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
d <- rsconnect::deployments(".")
app_id <- d$appId[match(desc::desc_get_field("Package"), d$name)]
rsconnect::deployApp(
  appName = desc::desc_get_field("Package"),
  appTitle = desc::desc_get_field("Package"),
  appPrimaryDoc = "app.R",
  appFiles = app_files,
  appId = app_id,
  lint = FALSE,
  forceUpdate = TRUE
)
