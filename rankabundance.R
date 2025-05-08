#################################################################################
######################### Rank-Abundance Curves ############################
#################################################################################

# 1. Load the required packages

#install.packages("ggplot", "tidyverse") #to install the libraries 

library(ggplot2)
library(tidyverse)

# 2. Loading the butterfly database
# Remember to set your working directory (Steps in RStudio: Session > Set Working Directory > Choose Directory)

mariposas <- read.csv("mariposas.csv")

# 3. We are going to use the functions of the tidyverse library
# operator %>% is used to indicate sequence in the lines of code

rango_abundancia <- mariposas %>%
  arrange(desc(abundancia)) %>% # Order the species from highest to lowest abundance
  mutate(rango = row_number()) # Creates a new column with the species rank 

View(rango_abundancia) # visualize the table that was just created

# 4. We are going to plot the rank-abundance curve with the ggplot function

# Define the base graph
final_plot <- ggplot(data = rango_abundancia, aes(x = rango, y = abundancia)) +
  geom_point(size = 3, col = "maroon") +   # Add points to the chart with custom size and color
  geom_line(linewidth = 1.5, col = "maroon") + # Add a line connecting the points with customized thickness and color.
  geom_text(aes(label = especie), # Add text labels to each point, slightly offsetting the labels.
            position = position_nudge(x = 0.2, y = 0.2), angle= 30,
            size = 5, family = "Times New Roman") +  # Adjusts text size
  labs(x = "Rango", y = "Abundancia") +   # Define axis labels
  theme_classic()+ # Apply a classic theme to improve aesthetics
  theme(axis.ticks.x = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_text(size = 10))   # removes the numbers on the x-axis
  

print(final_plot) #print the graphic

# 5. Save the graph with the ggsave function

ggsave("GraficaRangoAbundancia.tiff", #the name you are gonna give to your tiff file
       plot = final_plot, # specify the name of the object where the graph was stored
       width = 15, height = 12, #the dimensions of your graph
       units = "cm", #units of these dimensions (10 cm)
       dpi = 600) #graphic quality, usually 600 dpi is good quality.

