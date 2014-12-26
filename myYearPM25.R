""
myYearPM25 <- function(data, ids="year", vars="Emissions", fips=NULL, type=NULL) {
  if(is.null(NEI)){
    NEI <- readRDS("summarySCC_PM25.rds")
  }
  nei = NEI
  if(!is.null(fips)) {
    nei = NEI[NEI[,"fips"] == fips, ]
  }

  # If type is not null, use the type to subset NEI
  if(!is.null(type)) {
    SCC <- readRDS("Source_Classification_Code.rds")
    # Get SCC Number of `motor vehicle` emissions
    rows = grep(type, SCC$Short.Name, ignore.case = T)
    sccs = SCC[rows, "SCC"]
    
    nei = subset(nei, SCC %in% sccs, select=c("year","Emissions"))
  }
  
  require(reshape2)
  neiMelt = melt(nei, id=ids, measure.vars=vars)
  
  neiMelt
}