#Roadkill data wrangling

rk <- read.csv("records-2024-12-03.csv")
library(ggplot2)
#install.packages("mapdata")
library(mapdata)
install.packages("maps")

lat <- rk$Latitude..WGS84.
long <- rk$Longitude..WGS84.
latlong <- data.frame(lat, long)

map <- map("worldHires", "UK", col = "lightblue", fill = TRUE, xlim = c(-10, 5), ylim = c(49, 61), border = "black")

ggplot(latlong, aes(x=lat, y=long)) +
  geom_polygon(data = map, aes(x = long, y = lat, group = group), fill = "white", color = "grey") +
  geom_density2d()+
  scale_fill_gradient(low = "white", high = "red") +
  labs(x = "Longitude", y = "Latitude", title = "Example Heat Map")


ggplot(latlong, aes(x=lat, y=long)) + geom_density2d()
geom_point(data = latlong, aes(x = long, y = lat), size = 1, shape = 21)


ggplot() +
  geom_sf(data = map, fill = "gray90", color = "black") +  # UK map
  geom_bin2d(data = latlong, aes(x = long, y = lat), bins = 30) +  # Heatmap
  scale_fill_gradient(low = "blue", high = "red") +  # Color gradient
  coord_sf(xlim = c(-10, 2), ylim = c(49, 60), expand = FALSE) +  # Focus on UK
  labs(title = "Heatmap of Data Points on UK Map", x = "Longitude", y = "Latitude") +
  theme_minimal()

library(ggplot2)
install.packages("rnaturalearthdata")
library(rnaturalearth)
library(rnaturalearthdata)

# Load UK map as an sf object
uk_map <- ne_countries(scale = "medium", country = "United Kingdom", returnclass = "sf")

# Your dataset
set.seed(123)
data <- data.frame(
  lon = rnorm(1000, mean = -1, sd = 2),   # Longitude
  lat = rnorm(1000, mean = 53, sd = 2)    # Latitude
)

# Plot the map with heatmap
ggplot() +
  geom_sf(data = uk_map, fill = "gray90", color = "black") +  # Plot UK map
  geom_bin2d(data = latlong, aes(x = long, y = lat), bins = 30) +  # Heatmap
  scale_fill_gradient(low = "blue", high = "red") +  # Heatmap colors
  coord_sf(xlim = c(-10, 2), ylim = c(49, 60), expand = FALSE) +  # Focus on UK
  labs(title = "Heatmap of Data Points on UK Map", x = "Longitude", y = "Latitude") +
  theme_minimal()

ggplot() +
  geom_sf(data = uk_map, fill = "gray85", color = "white", size = 0.2) +  # Softer map colors
  geom_bin2d(data = latlong, aes(x = long, y = lat), bins = 40, alpha = 0.8) +  # Increase bins for finer detail
  scale_fill_viridis_c(option = "plasma", name = "Density") +  # Use viridis color scale
  coord_sf(xlim = c(-10, 2), ylim = c(49, 60), expand = FALSE) +  # Focus on UK
  labs(
    title = "Improved Heatmap of Data Points on UK Map",
    x = "Longitude",
    y = "Latitude"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    axis.text = element_text(size = 10),
    axis.title = element_text(size = 12),
    legend.position = "right"
  )


ggplot() +
  geom_sf(data = uk_map, fill = "gray85", color = "white", size = 0.2) +  # Base UK map
  stat_density_2d(
    data = latlong,
    aes(x = long, y = lat, fill = ..level..),
    geom = "polygon",
    alpha = 0.6
  ) +
  scale_fill_viridis_c(option = "plasma", name = "Density") +  # Color gradient
  coord_sf(xlim = c(-10, 2), ylim = c(49, 60), expand = FALSE) +  # Focus on UK
  labs(
    title = "Smoothed Density Heatmap on UK Map",
    x = "Longitude",
    y = "Latitude"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    axis.text = element_text(size = 10),
    axis.title = element_text(size = 12),
    legend.position = "right"
  )


ggplot() +
  geom_sf(data = uk_map, fill = "gray85", color = "white", size = 0.2) +  # Base UK map
  geom_hex(data = latlong, aes(x = long, y = lat), bins = 40, alpha = 0.8) +  # Hexagonal heatmap
  scale_fill_viridis_c(option = "plasma", name = "Density") +  # Smoother color scale
  coord_sf(xlim = c(-10, 2), ylim = c(49, 60), expand = FALSE) +  # Focus on UK
  labs(
    title = "Hexagonal Heatmap of Data Points on UK Map",
    x = "Longitude",
    y = "Latitude"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    axis.text = element_text(size = 10),
    axis.title = element_text(size = 12),
    legend.position = "right"
  )


