# Description text externalized
# I know there is a better way to do this, using external HTML but I'll do that later.
para.1 <- paste0("This application is a demonstration of an interactive Bayesian Network (BN)")
para.2 <- paste0("The network shows how 'machine learning' can be used to analyse a data set, ",
                 "including finding the significant correlations between variables",
          "and calculating local, conditional probability tables (CPTs) for each variable. ",
          "It then uses the visNetwork package to display the graph. Hover over a node (variable) ",
          "to see a description, and click on it to show the CPT in the left panel.",
          "The thickness of the edges show the strenght of the correlation")
para.3 <- "The main advantages of this approach are that"
list.1 <- "Network graphs are easier for humans to follow and reason about than large, numerical tables"
list.2 <- "There are computer algorithms for computing both network structures and CPTs"
list.3 <- "There are ways for both human experts and computers to collaborate on refining BNs."
para.4 <- paste0("This demonstration application uses the R packages bnlearn to do the ",
                 "BN computations and visGraph to do the interactive graphical representation")
para.5 <- "This application is my sandbox for learning this subject and developing R tools to assist."
para.6 <- paste0("So far, the interactivity is very basic. You can click on a node to do a partial ",
                 "display of its properties, including CPT, in the side bar. ",
                 "In addition, when a node is selected, its neighbourhood is highlighted.")
para.7 <- "My next steps are to allow for editing of the CPT and of the network structure. Watch this space."
para.8 <- "Source code and more description is available on GitHub at "
para.9 <- "This includes links and citations."
para.10 <- "The first few rows of the input data are shown on the 'Table' tab - just trying out tabs "
para.11 <- "If you have any feedback, please let me know on Twitter at "
