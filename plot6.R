"Reading data file summarySCC_PM25.rds is time consuming.
 We can read it first, then call plot1, plot2 ... with parameter,
 it can save time."
plot6 <- function(NEI = NULL) {
  source("myYearPM25.R")
  neiMelt = myYearPM25(NEI, fips="24510", type="motor")
  resBal = dcast(neiMelt, year~variable, sum)
  resBal$City = "Baltimore"

  neiMelt = myYearPM25(NEI, fips="06037", type="motor")
  resLos = dcast(neiMelt, year~variable, sum)
  resLos$City = "Los Angeles"
  
  res = rbind(resBal, resLos)
  
  require(ggplot2)
  g = ggplot(res, aes(year, Emissions, color=City))
  g = g + geom_line() + geom_point()
  g + labs(title=expression(PM[2.5] * " from motor vehicle sources"))
  ggsave('figure/plot6.png')
  
}