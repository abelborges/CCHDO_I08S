setwd('~/goship/')

ll1994 <- read.table('lat_lon_1994.txt', TRUE)
ll2007 <- read.table('lat_lon_2007.txt', TRUE)
ll2016 <- read.table('lat_lon_2016.txt', TRUE)

# just add the year of each file and then merge (with r- and c-bind)
year <- c(rep(1994, nrow(ll1994)), rep(2007, nrow(ll2007)), rep(2016, nrow(ll2016)))
lat_lon <- cbind(rbind(ll1994, ll2007, ll2016), year)

# run only once
# write.csv(x = lat_lon, file = 'lat_lon.csv', row.names = FALSE)

