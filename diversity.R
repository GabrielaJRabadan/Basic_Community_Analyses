#################################################################################
############################# Taxonomic Diversity #############################
#################################################################################

# 1. Load and install the necessary packages.

install.packages("iNEXT", "iNEXT4steps") # to install the libraries 

# Load the packages

library(ggplot2) # for graphics
library(tidyverse) # for data managements
library(iNEXT) # for taxonomic diversity analysis
library(iNEXT.4steps) # updated version of iNEXT package

# 2. Loading the bird database "aves.csv"
# Remember to set your working directory (Steps in RStudio: Session > Set Working Directory > Choose Directory)

aves <- read.csv("aves.csv")

# 3. Set the variable SITIO as the name of the rows in the database
row.names(aves) <- aves$SITIO

# 4. Delete the first column. If it is not deleted, it is not possible to perform the analysis.

aves <- aves[,-1] # indicates that we are going to delete the first column of the birds object.

# 3. Transpose the matrix

# The function we will use works with matrices where
# rows = species; columns = sites
# Therefore we have to transpose the original matrix

df.comp <- t(aves)

###############################################################     
#   SAMPLE COMPLETENESS
###############################################################

# Always before doing diversity analysis it is necessary to know how complete is our sample.
# The iNEXT4steps function allows us, among other things, to obtain the completeness of our sample.

# 1. Calculate, among other things, the sample completeness for q 0, 1 and 2.

analisis_iNEXT <- iNEXT4steps(df.comp, nboot = 30, details = TRUE)

# 2. Save completeness results in the object “completitud”.
completitud <- as.data.frame(analisis_iNEXT$summary$`STEP 1. Sample completeness profiles`)

# display completeness values
print(completitud) 

# In the completeness object we have:
# Assemblage = name of our sites
# q = 0: completeness of order 0. Usually it is low due to the complexity of detecting all the diversity
       # present at a site or in a region in a relatively short sampling period
# q = 1: completeness of order 1. It is the probability of finding a species not previously sampled, 
       #if the sample would be expanded by one individual. Best values are >80.
# q = 2: completeness of order 2. Indicates whether the most abundant species were fully sampled
      # is usually close to 1 because most abundant species are usually captured

# If we see that any of our values are low (< 40), it means that our sampling 
# is not complete, and that we need to sample more individuals.

# 3. Save completeness results 

write.csv(completitud, "completitud.csv")

###############################################################     
#   TAXONOMIC DIVERSITY ANALYSIS USING iNEXT
###############################################################

# 1. Perform diversity analysis with the iNEXT function.

# the first argument is the database we generated earlier (df.comp), 
# the second argument is the three diversity orders 0, 1 and 2
# the third argument specifies the type of data we have (abundance)

resultados <- iNEXT(df.comp, q = c(0, 1, 2), datatype="abundance")

# 2. Obtain the true diversity estimates
# The output of the function is a list, from which we are going to obtain the element “AsyEst”.

diversidad <- resultados$AsyEst 

# The “diversity” object contains the statistical estimate of the three orders of diversity for each site.
# Assemblage: is the name of our sites
# Diversity: is the type of estimated diversity 
            #Species richness: is the number of species 
            #Simpson diversity: is the diversity of common species 
            #Shannon diversity: is the diversity of abundant species 
# Observed: is the value of the estimated diversity.
# s.e.: standard error of the estimation
# LCL: lower confidence interval
# UCL: upper confidence interval

# 3. Graphing the results

grafica <- ggiNEXT(resultados, type=1, facet.var="Order.q", color.var="None", se=TRUE)+
  theme_classic()+ 
  theme(strip.text = element_text(face = "bold", 
                                  color = "black",
                                  vjust = 0, size = 15),
        strip.background = element_blank())+
  labs(x="Número de individuos", y="Diversidad de especies")+
  theme(legend.position="bottom")

print(grafica)

# 4. Saving the results of tables and graphs

#Save the diversity estimate
write.csv(diversidad, "Diversidad.csv") 

#Save the diversity graph
ggsave("GraficaDiversidad.tiff", plot = grafica, # specify the name of the object where the graph was stored
       width = 15, height = 12, #the dimensions of your graph
       units = "cm", #units of these dimensions (10 cm)
       dpi = 600) #graphic quality, usually 600 dpi is good quality.

#################################################
############# Useful references ################
#################################################

# What we saw in this script is just a glance of all the results obtained with the iNEXT and iNEXT4steps library.
# Here are references and links that you can take advantage of 
# Info about the library: 
# https://drive.google.com/file/d/1Z9T6xMD7IOSo1SqyF2BQou7Fez5evlhj/view
# https://cran.r-project.org/web/packages/iNEXT/vignettes/Introduction.pdf
# https://www.researchgate.net/publication/304568004_iNEXT_An_R_package_for_rarefaction_and_extrapolation_of_species_diversity_Hill_numbers

# Books on biological diversity:
# https://www.researchgate.net/profile/Carlos-Cultid-Medina/publication/340104672_Pautas_para_la_estimacion_y_comparacion_estadistica_de_la_diversidad_biologica_qD/links/5e78f049a6fdcceef972655b/Pautas-para-la-estimacion-y-comparacion-estadistica-de-la-diversidad-biologica-qD.pdf