# Shiny server to manage a Bayesian Network example
# This is just the really simple version, hoping it will evolve as I learn
# Needs two packages
# 1. A package for managing the mathematics of a Bayesian Network
# 2. A package for an interactive visual display of the network
library(bnlearn)
library(visNetwork)
#small change!

# Bayesian networks are a way of simplifying the logic behind understanding lots of 
# data involving many variables. This example loads a simple data set from the web
# site for the book "Bayesian Networks: With Examples in R"
survey <- read.table("data/survey.txt", header = TRUE)

# First the stuff to initialise the network
# We will "learn" the network structure by applying a hill-climbing algorithm to the data 
learned.graph <- hc(survey)
# and we'll figure out how strong the links are in the graph
# We can use a conditional dependence test to get a p-value for arcs
# (I think this means null hypothesis is that the arc is absent)
arc.strengths <- arc.strength(learned.graph, data = survey, criterion = "x2")

# From here, we are turning the bnlearn graph into a visNetwork
# visNetwork needs a dataframe of nodes with their visual properties
# and a dataframe of arcs so we extract them from the bnlearn object
# nodes have to have a numeric ID 
# (unlike bnlearn, id is string, which we make into the label for the graph
nodes.df <- data.frame(id=1:6,label=nodes(learned.graph))

# Now turn some of the network's characteristics into visual properties of the graph
# Make the thickness of the arcs into an indicator of the strength of the arc
# i.e. how strong the "from" variable is in predicting the "to" variable.

edge.widths  <- max(arc.strengths$strength)/arc.strengths$strength
edges.df  <- data.frame(
  from=nodes.df$id[match(arcs(learned.graph)[,'from'],nodes.df$label)],
  to=nodes.df$id[match(arcs(learned.graph)[,'to'],nodes.df$label)] ,
  arrows="to",
  width=edge.widths)


# since these strengths are p-values, small=good, we want to make smallest ones 
# into thick lines, so a reciprocal would be good, normalised so the weakest one 
# is one pixel.

shinyServer(
  function(input, output) {
    
    output$network <- renderVisNetwork({
      visNetwork(nodes.df, edges.df) %>%
        visOptions(nodesIdSelection = TRUE) %>% 
        visHierarchicalLayout(sortMethod = "directed")
    })
    output$text1 <- renderText({ 
      paste("You have selected", input$network_selected)
    })
    output$mytable = renderDataTable({
      head(survey)
    }) 
    
  }
)