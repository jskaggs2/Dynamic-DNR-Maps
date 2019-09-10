## Map species distributions using DNR Biotics shapefiles
## Jon Skaggs
## initiated 12 April 2019


# Prereqs -----------------------------------------------------------------

# Set working directory to source file location
getwd()

# Install and load packages
library(ggplot2)
library(rgdal)


# Load species data -------------------------------------------------------

speciesdata <- "cyprinella_xaenura_huc10_range-2019-03-18"


# Generate map ------------------------------------------------------------

unzip(paste(speciesdata, ".zip", sep = ""))

# Load spatial data
range <- ggplot2::fortify(rgdal::readOGR(dsn = ".", layer = speciesdata))
map.ga <- ggplot2::fortify(rgdal::readOGR(dsn = ".", layer = "ga"))
map.county <- ggplot2::fortify(rgdal::readOGR(dsn = ".", layer = "county"))

# Plot range map
ggplot() + 
  geom_polygon(data = range, mapping = aes(x = long, y = lat, group = group), fill = NA, color = "black") +
  geom_polygon(data = map.county, mapping = aes(x = long, y = lat, group = group), fill = NA, color = "grey70") +
  scale_fill_continuous(name = "", na.value = "white") +
  ggtitle(paste(speciesdata), subtitle = paste("created: ", Sys.Date(), sep="")) +
  coord_fixed(1.2) 

# Save map to "maps" folder
ggsave(filename = (paste(speciesdata, ".jpeg", sep = "")), path = "maps", device = "jpeg")