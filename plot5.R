"Reading data file summarySCC_PM25.rds is time consuming.
 We can read it first, then call plot1, plot2 ... with parameter,
 it can save time."
plot5 <- function(NEI = NULL) {
  source("myYearPM25.R")
  neiMelt = myYearPM25(NEI, fips="24510", type="motor")
  res = dcast(neiMelt, year~variable, sum)
  
  require(ggplot2)
  g = ggplot(res, aes(year, Emissions))
  g = g + geom_line() + geom_point()
  g + labs(title=expression(PM[2.5] * " from motor vehicle sources in Baltimore City"))
  ggsave('figure/plot5.png')
  
}