# load module functions
source("cens_ab.R")
source("cens_fb.R")
source("tv.R")
source("lv.R")

ui <- fluidPage(
  titlePanel("Censoring and Tobit apps"),
  tabsetPanel(
    tabPanel("Censoring from above", cens_ab_ui("censab")),
    tabPanel("Censoring from below",cens_fb_ui("censfb")),
    tabPanel("Latent variables and p(censored)",lv_ui("lv")),
    tabPanel("Tobit type 1 CDF, illustrated",tv_ui("tv"))
  )
)
