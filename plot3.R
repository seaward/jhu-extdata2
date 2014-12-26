plot3 <- function(NEI = NULL) {
  source("myYearPM25.R")
  neiMelt = myYearPM25(NEI, ids=c("year", "type"), fips="24510")
  res = dcast(neiMelt, type + year ~ variable, sum)
  
  require(ggplot2)
  g = ggplot(res, aes(year, Emissions, color=type))
  g = g + geom_line() + geom_point()
  g + ggtitle(expression(PM[2.5] * "(Baltimore City, Maryland)"))
  ggsave(file="figure/plot3.png")
}