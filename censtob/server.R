library(shiny)
library(ggplot2)
library(censReg)

# load module functions
source("cens_ab.R")
source("cens_fb.R")
source("tv.R")
source("lv.R")

# Define server
server <- function(input, output, session) {
  callModule(cens_ab_serv, "censab")
  callModule(cens_fb_serv, "censfb")
  callModule(lv_serv, "lv")
  callModule(tv_serv, "tv")
}
