## Reading data file summarySCC_PM25.rds is time consuming.
## We can read it first, then call plot1, plot2 ... with parameter,
## it can save time.
plot1 <- function(NEI = NULL) {
  if(is.null(NEI)){
    NEI <- readRDS("summarySCC_PM25.rds")
  }

  require(reshape2)
  neiMelt = melt(NEI, id="year", measure.vars="Emissions")
  res = dcast(neiMelt, year~variable, sum)

#   ysep = split(NEI, NEI$year)
#   
#   len = length(ysep)
#   Emissions = rep(0,len)
#   Year = rep(0,len)
#   for(i in 1:len) {
#     Emissions[i] = sum(ysep[[i]]$Emissions)
#     Year[i] = ysep[[i]]$year[1]
#   }
#   Emissions = Emissions / 1000000
#   res = data.frame(Year, Emissions)
  
  with(res, plot(year, Emissions / 1000000, ylab = 'Emissions(M)', type = 'b'))
  title(main = 'PM2.5(USA)')
  dev.copy(png, file='figure/plot1.png')
  dev.off()
  
}