# Shiny UI to display a Bayesian Network example
# This is just the really simple version, hoping it will evolve as I learn
# Needs two packages
# 1. A package for managing the mathematics of a Bayesian Network
# 2. A package for an interactive visual display of the network
library(bnlearn)
library(visNetwork)

# UI is a fluid page (which reflows with different sizes so good for small and large devices)
# It contains 3 sub-panels: the title, a side panel and a main panel
shinyUI(fluidPage(
  titlePanel("Bayesian Network with visNetwork Example"),
  
  sidebarLayout(
    
    sidebarPanel(
      helpText("Edit a really simple network"),
      textOutput("text1")
    ),
    
    mainPanel( 
      visNetworkOutput("network"),
      dataTableOutput('mytable')
    )
  )
))