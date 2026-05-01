# Launch the ShinyApp (Do not remove this comment)
# To deploy to shinyapps.io, run from package root:
#   source("deploy-shinyapps.R")
# (Using deployApp() without appFiles bundles dev/tests and breaks dependency detection.)

pkgload::load_all(export_all = FALSE,helpers = FALSE,attach_testthat = FALSE)
options( "golem.app.prod" = TRUE)
CorePrincipleGenAIChecklist::run_app() # add parameters here (if any)
