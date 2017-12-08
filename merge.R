setwd('~/goship/')
files_list_1994 <- list.files('1994')
files_list_2007 <- list.files('2007')
files_list_2016 <- list.files('2016')
files_list <- list(
  "1994" = files_list_1994[substr(files_list_1994, 1, 3) == "new"],
  "2007" = files_list_2007[substr(files_list_2007, 1, 3) == "new"],
  "2016" = files_list_2016[substr(files_list_2016, 1, 3) == "new"]
)

lat_lon <- read.csv('lat_lon.csv', TRUE, stringsAsFactors = FALSE)

files_1994 <- NULL
for(f in files_list[['1994']]) {
  csv <- read.csv(paste0('1994/', f), FALSE)
  csv <- csv[, c(1,3,5,7)]
  names(csv) <- c('pres', 'temp', 'sal', 'oxy')
  lat <- lat_lon$lat[lat_lon$file == substr(f, 5, 1000)]
  lon <- lat_lon$lon[lat_lon$file == substr(f, 5, 1000)]
  csv <- cbind(csv, lat, lon)
  files_1994 <- rbind(files_1994, csv)
}
year <- 1994
files_1994 <- cbind(files_1994, year)

files_2007 <- NULL
for(f in files_list[['2007']]) {
  csv <- read.csv(paste0('2007/', f), FALSE)
  csv <- csv[, c(1,3,5,7)]
  names(csv) <- c('pres', 'temp', 'sal', 'oxy')
  lat <- lat_lon$lat[lat_lon$file == substr(f, 5, 1000)]
  lon <- lat_lon$lon[lat_lon$file == substr(f, 5, 1000)]
  csv <- cbind(csv, lat, lon)
  files_2007 <- rbind(files_2007, csv)
}
year <- 2007
files_2007 <- cbind(files_2007, year)

files_2016 <- NULL
for(f in files_list[['2016']]) {
  csv <- read.csv(paste0('2016/', f), FALSE)
  csv <- csv[, c(1,3,5,7)]
  names(csv) <- c('pres', 'temp', 'sal', 'oxy')
  lat <- lat_lon$lat[lat_lon$file == substr(f, 5, 1000)]
  lon <- lat_lon$lon[lat_lon$file == substr(f, 5, 1000)]
  csv <- cbind(csv, lat, lon)
  files_2016 <- rbind(files_2016, csv)
}
year <- 2016
files_2016 <- cbind(files_2016, year)

# merging
ctd <- rbind(files_1994, files_2007, files_2016)

library(leaflet)
library(KernSmooth)
library(data.table)

kde <- bkde2D(ctd[ ,list(lon, lat)],
              bandwidth=c(.0045, .0068), gridsize = c(100,100))
CL <- contourLines(kde$x1 , kde$x2 , kde$fhat)

LEVS <- as.factor(sapply(CL, `[[`, "level"))
NLEV <- length(levels(LEVS))

## CONVERT CONTOUR LINES TO POLYGONS
pgons <- lapply(1:length(CL), function(i)
  Polygons(list(Polygon(cbind(CL[[i]]$x, CL[[i]]$y))), ID=i))
spgons = SpatialPolygons(pgons)

## Leaflet map with polygons
leaflet(spgons) %>% addTiles() %>% 
  addPolygons(color = heat.colors(NLEV, NULL)[LEVS])


