## Reading data file summarySCC_PM25.rds is time consuming.
## We can read it first, then call plot1, plot2 ... with parameter,
## it can save time.
plot4 <- function(NEI = NULL) {
  source("myYearPM25.R")
  neiMelt = myYearPM25(NEI, type="coal")
  res = dcast(neiMelt, year~variable, sum)
  
  require(ggplot2)
  g = ggplot(res, aes(year, Emissions))
  g + geom_line() + geom_point() + labs(title=expression(PM[2.5] * " from coal combustion-related sources"));
  ggsave('figure/plot4.png')
  
}