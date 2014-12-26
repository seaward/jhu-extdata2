plot2 <- function(NEI = NULL) {
  source("myYearPM25.R")
  neiMelt = myYearPM25(NEI, fips="24510")
  res = dcast(neiMelt, year~variable, sum)

  png(file="figure/plot2.png",width=480, height=480)
  with(res, plot(year, Emissions/1000, ylab = 'Emissions(K)', type = 'b'))
  title(main=expression(PM[2.5] * '(Baltimore City, Maryland)'))
  dev.off()
  
}