# ===============================================
# Introduction to network analysis in R
# Laura W. Dozal
# ===============================================

# ---------------
# Preparation
# ---------------

# rm(list = ls())

# Load the packages
# Please do NOT load igraph yet.
library(statnet)
library(GGally)


# Read the adjacency matrix  
adjacency <- read.csv("Karate club adj 2021_05_21.csv", 
                     header = TRUE, stringsAsFactors = FALSE, row.names = 1)

# Inspect the data 
adjacency # head(...)  shows the first rows of a dataset

# -----------------------
# Get a network object
# -----------------------

# Transform the data into network format 
karate_net <- network(adjacency, matrix.type = "adjacency", 
                      directed = TRUE, ignore.eval = TRUE)

# Look at the network object 
karate_net


# -----------------------
# Visualize the network
# -----------------------

# Simple visualization 
ggnet2(karate_net, label = TRUE)
# ?ggnet2

# Add some color
ggnet2(net = karate_net, label = TRUE, node.color = "coral2") #"blue", "green"

#### Back to presentation ####

# -------------------------------
# Explore the network structure
# -------------------------------

# Save names of club members 
club_members <- network.vertex.names(karate_net)

# Get components - how many clusters do we have?
components(karate_net)

# Find isolates
isolate <- isolates(karate_net)
club_members[isolate]

# Get densitiy
gden(karate_net, mode = "graph")

# -------------------------
# Explore actor positions
# -------------------------


# Get degree centrality
degree <- degree(karate_net, gmode = "graph")
names(degree) <- network.vertex.names(karate_net) #include names
sort(degree) #look at the number of connections

# Explore degree distribution
hist(degree, breaks = 12, main = "Degree distribution", xlab = "Degree")

# Get eigenvector centrality
#####
# Eigenvector Centrality is an algorithm that measures the transitive influence of nodes. 
# Relationships originating from high-scoring nodes contribute more to the score of a node 
# than connections from low-scoring nodes. A high eigenvector score means that a node is 
# connected to many nodes who themselves have high scores.
####
eigen <- evcent(karate_net, gmode = "graph")
names(eigen) <- network.vertex.names(karate_net)
sort(eigen)

# Get Closness centrality
close <- closeness(karate_net, gmode = "graph")
names(close) <- network.vertex.names(karate_net)
sort(close)

# Get betweenness centrality
between <- betweenness(karate_net, gmode = "graph")
names(between) <- network.vertex.names(karate_net)
sort(between)


#### Back to presentation ####

# -----------------------
# Looking at subgroups
# -----------------------
# Get an igraph object
# -----------------------

# Note on package use: We can use packages by loading them 
# and then use all the functions. This is most common. 
# However, we can also access functions when packages are 
# not loaded. For this, we write "packagename::function_name."
# This is especially useful when two packages use the same
# function names. igraph and sna use some of the same function
# names.Therefore, we will access igraph using the "::" method. 

# Get the matrix (matrix is another object type, like network object)
adjacency_matrix <- as.matrix(adjacency)

# Get igraph object (this is another type of network object)
karate_inet <- igraph::graph.adjacency(adjacency_matrix, mode = "undirected")

# Simplify igraph object
karate_inet <- igraph::simplify(karate_inet, remove.multiple = TRUE, 
                                remove.loops = TRUE)

# Look at the igraph object
karate_inet		
igraph::V(karate_inet)	# This shows you the vertex set. 
igraph::E(karate_inet)	# This shows you the edge set. 

# Plot the network
igraph::plot.igraph(karate_inet, vertex.size = 10, vertex.label.cex = 0.8)

# -----------------------
# Find cliques
# -----------------------

# Find all cliques with a minimum of three members
cliques_3 <- igraph::cliques(karate_inet, min = 3)
head(cliques_3)
length(cliques_3) # Number of cliques of size 3.  

# Find all cliques with a minimum of four members
cliques_4 <- igraph::cliques(karate_inet, min = 4)
head(cliques_4)
length(cliques_4) # Number of cliques of size 4.  

# Find all cliques with a minimum of five members
cliques_5 <- igraph::cliques(karate_inet, min = 5)
head(cliques_5)
length(cliques_5) # Number of cliques of size 5.  

# -----------------------
# Find communities
# -----------------------

# Use the Girvan-Newman approach to detect communities
communities <- igraph::edge.betweenness.community(karate_inet)

igraph::plot_dendrogram(communities)

# Visualize the network with colors according to communities
igraph::plot.igraph(karate_inet, vertex.color = communities$membership, 
                    vertex.size = 10, vertex.label.cex = 0.8)

# ----------------------------
# Visualize node attributes
# ----------------------------

# Get node attributes
faction <- read.csv("Karate club attributes 2021_05_21.csv", header = TRUE,
                    stringsAsFactors = FALSE)

# Inspect node attributes
head(faction)
tail(faction)

# Add attributes to our network object
karate_net %v% "faction" <- faction[,2] 
karate_net

# Visualize the network with colors according to attributes
# Add some color
ggnet2(net = karate_net, label = TRUE, node.color = "faction", 
       color.palette = c("1" = "dodgerblue1", "2" = "hotpink"))

# 
# corrdinates <- gplot.layout.fruchtermanreingold(karate_net, NULL)
# karate_net %V% "x" <- corrdinates[,1]
# karate_net %V% "y" <- corrdinates[,2]
