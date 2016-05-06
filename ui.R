# Shiny UI to display a Bayesian Network example
# This is just the really simple version, hoping it will evolve as I learn
# Needs two packages
# 1. A package for managing the mathematics of a Bayesian Network
# 2. A package for an interactive visual display of the network
library(bnlearn)
library(visNetwork)
source("descriptions.R")

# UI is a fluid page (which reflows with different sizes so good for small and large devices)
# It contains 3 sub-panels: the title, a side panel and a main panel
shinyUI(fluidPage(
  titlePanel("Bayesian Network with visNetwork Example"),
  
  sidebarLayout(
    
    sidebarPanel(
          
# the next panel shows the CPT for selected node, so include only if there is one selected           
 #     conditionalPanel( 
  #      condition = "input.network_selected > 0",
        textOutput("networkID") ,
        tableOutput("cpt")
   #   )
     
    ),
    
    mainPanel( 
      tabsetPanel(
        tabPanel("Graph", 
                 visNetworkOutput("network"), # Network graph
                 # Textual description
                 h1("Description"),
                 p(para.1),
                 p(para.2),
                 p(para.3),
                 tags$ol(
                   tags$li(list.1),
                   tags$li(list.2),
                   tags$li(list.3)
                 ),
                 p(para.4),
                 h1("Status"),
                 p(para.5),
                 p(para.6),
                 p(para.7),
                 p(para.8,
                   tags$a(href="https://github.com/EricLawtonCA/BayesNet", "https://github.com/EricLawtonCA/BayesNet") 
                   ),
                 p(para.9),
                 p(para.10),
                 p(para.11, 
                   tags$a(href="https://twitter.com/Eric0Lawton", "Eric0Lawton"),
                   "hashtag #BayesNetR"
                 )
             ) ,
       
        tabPanel("Table",  dataTableOutput('datatable'))
      )
     
    )
  )
))