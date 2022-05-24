# ===============================================
## ResBaz Social Network Analysis Workshop
# Introduction to network analysis in R
# Laura W. Dozal
## May 2022
# ===============================================


### Follow Along Here ###


# ---------------
# Preparation
# ---------------

# rm(list = ls())

# Load the packages
# Please do NOT load igraph yet.
library(statnet)
library(GGally)


# Read the adjacency matrix  

# Inspect the data 
# head(...)  shows the first rows of a dataset

# -----------------------
# Get a network object
# -----------------------

# Transform the data into network format 


# Look at the network object 


# -----------------------
# Visualize the network
# -----------------------

# Simple visualization 
# ?ggnet2

# Add some color

#### Back to presentation ####

# -------------------------------
# Explore the network structure
# -------------------------------

# Save names of club members 

# Get components - how many clusters do we have?

# Find isolates


# Get densitiy

# -------------------------
# Explore actor positions
# -------------------------


# Get degree centrality


# Explore degree distribution

# Get eigenvector centrality
#####
# Eigenvector Centrality is an algorithm that measures the transitive influence of nodes. 
# Relationships originating from high-scoring nodes contribute more to the score of a node 
# than connections from low-scoring nodes. A high eigenvector score means that a node is 
# connected to many nodes who themselves have high scores.
####


# Get Closness centrality


# Get betweenness centrality



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

# Get igraph object (this is another type of network object)

# Simplify igraph object


# Look at the igraph object

# igraph::V(karate_inet)	# This shows you the vertex set. 
# igraph::E(karate_inet)	# This shows you the edge set. 

# Plot the network

# -----------------------
# Find cliques
# -----------------------

# Find all cliques with a minimum of three members
# Number of cliques of size 3.  

# Find all cliques with a minimum of four members
# Number of cliques of size 4.  

# Find all cliques with a minimum of five members
# Number of cliques of size 5.  

# -----------------------
# Find communities
# -----------------------

# Use the Girvan-Newman approach to detect communities


# Visualize the network with colors according to communities


# ----------------------------
# Visualize node attributes
# ----------------------------

# Get node attributes


# Inspect node attributes


# Add attributes to our network object


# Visualize the network with colors according to attributes
# Add some color


# 
# corrdinates <- gplot.layout.fruchtermanreingold(karate_net, NULL)
# karate_net %V% "x" <- corrdinates[,1]
# karate_net %V% "y" <- corrdinates[,2]
