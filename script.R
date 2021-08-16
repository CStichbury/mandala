setwd("~/Desktop/brainblots/mandala")

library(ggplot2)
library(dplyr)
library(deldir)
library(colourlovers)
library(rlist)
library(wesanderson)
library(RColorBrewer)
library(ggsci)
library(awtools)


# Parameters
iter=3 # Number of iterations (depth)
points=16 # Number of points
radius=1.07 # Factor of expansion/compression

#1 - 4,10,1.95
#2 - 3,14,1.77
#3 - 2,20,0.95
#4 - 5,8,2.20
#5 - 3,18,1.14
#6 - 3,12,0.65
#7 - 4,9,1.25
#8 - 3,16,1.07


# Angles of points from center
angles=seq(0, 2*pi*(1-1/points), length.out = points)+pi/2
#angles=seq(0, 2*pi*(1-1/points), length.out = points)+pi/2

# Initial center
df=data.frame(x=0, y=0)

# Iterate over centers again and again
for (k in 1:iter) {
  temp=data.frame()
  for (i in 1:nrow(df))
  {
    data.frame(x=df[i,"x"]+radius^(k-1)*cos(angles), 
               y=df[i,"y"]+radius^(k-1)*sin(angles)) %>% rbind(temp) -> temp
  }
  df=temp
}

# Function to extract id, coordinates and area of each polygon
crea = function(tile) {tile %>% list.match("ptNum|x|y|area") %>% as.data.frame()}

# Generate tesselation, obtain polygons and create a dataframe with results
# This dataframe will be the input of ggplot
df %>% 
  deldir(sort = TRUE)  %>% 
  tile.list() %>% 
  list.filter(sum(bp)==0) %>% 
  list.filter(length(intersect(which(x==0), which(y==0)))==0) %>% 
  lapply(crea) %>% 
  list.rbind() ->  df_polygon

# Pick a palette
#palette <- wes_palette("Rushmore1", 80, type = "continuous")
#palette <- brewer.pal(11, "RdYlGn")
palette <- mpalette #(awtools --- a_palette, a_spalette, mpalette, ppalette, spalette)

# Draw mandala with geom_polygon. Colur depends on area
ggplot(df_polygon, aes(x = x, y = y)) +
  geom_polygon(aes(fill = area, color=area, group = ptNum),
               show.legend = FALSE, size=0)+
  scale_fill_gradientn(colors=sample(palette, length(palette))) +
  scale_color_gradientn(colors="gray30") +   
  theme_void()

# Do you like the result? You can save it (change the filename):
ggsave("mandala8.png", height=5, width=5, units='in', dpi=600)



####-----OMIT------####-----AFTER ITER / BEFORE CREA-----####
#############################################################
# # Obtain Voronoi regions
# df %>%
#   select(x,y) %>% 
#   deldir(sort=TRUE) %>% 
#   .$dirsgs -> data
# 
# # Plot regions with geom_segmen
# data %>% 
#   ggplot() +
#   geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), color="mediumpurple") +
#   scale_x_continuous(expand=c(0,0))+
#   scale_y_continuous(expand=c(0,0))+
#   coord_fixed() +
#   theme(legend.position  = "none",
#         panel.background = element_rect(fill="white"),
#         panel.border     = element_rect(colour = "black", fill=NA),
#         axis.ticks       = element_blank(),
#         panel.grid       = element_blank(),
#         axis.title       = element_blank(),
#         axis.text        = element_blank())->plot
# 
# plot  
#############################################################
####-----OMIT------####-----AFTER ITER / BEFORE CREA-----####