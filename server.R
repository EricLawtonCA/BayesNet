# Shiny server to manage a Bayesian Network example

# This is just the really simple version, hoping it will evolve as I learn
# For more explanation, see the pdf in the same GitHub repository as this code

library(bnlearn) # For managing the mathematics of a Bayesian Network
library(visNetwork) # For an interactive visual display of the network


# Bayesian networks are a way of simplifying the logic behind understanding lots of 
# data involving many variables. 
# This example uses a simple data set from the web site for the book 
# "Bayesian Networks: With Examples in R". 
survey <- read.table("data/survey.txt", header = TRUE)

# We have to set up two very similar representations of the network, just because
# bnlearn and visNetwork don't quite represent the same network the same way

# We will "learn" the bn structure (just the DAG) by applying a hill-climbing algorithm to the data 
dag <- hc(survey)

# "bn.graph" now has the structure of the graph: 
# - a list of nodes corresponding to the variables and
# - a list of directed arcs
# We can also find out how strong the links are in the graph
# We can use a conditional dependence test to get a p-value for arcs
# (I think this means null hypothesis is that the arc is absent)
arc.strengths <- arc.strength(dag, data = survey, criterion = "x2")

# next we'll calculate the Conditional Probability Table(CPT) for all the nodes
# this returns object of class bn.fit which has the nodes and their CPTs
bn.graph.cpt  <- bn.fit(dag,survey,method="bayes")

# From here, we set up the visNetwork matching structure: need to use numeric IDs instead
# of names, and set up some visual representation
# First the labels, shapes and other fixed decorations
visNetwork.nodes  <- data.frame(id=1:6,
                              label=c("Age","Residence","Education","Occupation","Sex","Transport") ,
                              title=c("Young,Adult or Old","Size of community","High school or uni",
                                      "Employed or Self","M or F", "Train or Car"),
                              shape="ellipse"  
)

# Now turn some of the network's characteristics into visual properties of the graph
# Make the thickness of the arcs into an indicator of the strength of the arc
# i.e. how strong the "from" variable is in predicting the "to" variable.

# since these strengths are p-values, small=good, we want to make smallest ones 
# into thick lines, so a reciprocal works, normalised so the weakest one 
# is one pixel.

edge.widths  <- max(arc.strengths$strength)/arc.strengths$strength
# Turn bnlearn "arcs" into visNetwork "nodes" by doing a lookup from names to IDs
visNetwork.edges  <- data.frame(
  from=visNetwork.nodes$id[match(arcs(bn.graph.cpt)[,'from'],visNetwork.nodes$label)],
  to=visNetwork.nodes$id[match(arcs(bn.graph.cpt)[,'to'],visNetwork.nodes$label)] , 
  arrows="to",  # define the arrow style
  width=edge.widths)


# All setup done. Now to do the rendering via the shinyServer
shinyServer(
  function(input, output) {
    
    output$network <- renderVisNetwork({
      visNetwork(visNetwork.nodes, visNetwork.edges) %>%
        visOptions(nodesIdSelection = list(enabled=TRUE,selected=1), highlightNearest = TRUE) %>% 
        visHierarchicalLayout(sortMethod = "directed")
    })
    output$networkID <- renderText({ 
  
      if (!is.null(input$network_selected) && input$network_selected != "" ){
  #      paste("Conditional Probability Table for selected variable", input$network_selected)
        paste("Conditional Probability Table for selected variable", visNetwork.nodes$label[[as.numeric(input$network_selected)]])
      }
        else {  paste("No CPT displayed because no variable selected") }
      })
    output$datatable = renderDataTable({
     head(survey)
    }) 
    output$cpt = renderTable({
      if( is.null(input$network_selected)) { 
        as.table(c(0,0))
      }
      else {bn.graph.cpt[[as.numeric(input$network_selected)]]$prob}
    }) 
    
  }
)