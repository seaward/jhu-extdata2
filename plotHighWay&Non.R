## Reading data file summarySCC_PM25.rds is time consuming.
## We can read it first, then call plot1, plot2 ... with parameter,
## it can save time.
plot5 <- function(NEI = NULL) {
  if(is.null(NEI)){
    NEI <- readRDS("summarySCC_PM25.rds")
  }
  SCC <- readRDS("Source_Classification_Code.rds")
  # Get SCC Number of coal emissions
  rows = grep("highway veh", SCC$Short.Name, ignore.case = T)
  sccsH = SCC[rows, "SCC"]
  rows = grep("Off-highway", SCC$Short.Name, ignore.case = T)
  sccsN = SCC[rows, "SCC"]
  
  nei = subset(NEI, SCC %in% sccsH, select=c("year","Emissions"))
  
  require(reshape2)
  neiMelt = melt(nei, id="year", measure.vars="Emissions")
  resH = dcast(neiMelt, year~variable, sum)
  resH$type = "Highway"
  
  nei = subset(NEI, SCC %in% sccsN, select=c("year","Emissions"))
  neiMelt = melt(nei, id="year", measure.vars="Emissions")
  resN = dcast(neiMelt, year~variable, sum)
  resN$type = "Off-highway"
  
  res = rbind(resH, resN)
  
  require(ggplot2)
  g = ggplot(res, aes(year, Emissions, color=type))
  g + geom_line() + geom_point() + labs(title=expression(PM[2.5] * " from motor vehicle sources"));
  ggsave('figure/plotHighA.png')
  
}