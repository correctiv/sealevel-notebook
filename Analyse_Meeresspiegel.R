Libraries laden

library(httr)
library(data.table)

#Funktion, um Daten einzulesen

mydat <- fread('http://uhslc.soest.hawaii.edu/data/csv3/fdd/fdd0001.csv')

#Set column names

column_names <- c("year", "month", "day", "seaLevel")

#Download data and set column names

uh002 <- fread('http://uhslc.soest.hawaii.edu/data/csv3/fdd/fdd0001.csv', header = FALSE)
setnames(uh002, column_names)


#Subsetting data

subsetUh001 <- uh001[ which(uh001$year=='2001')]


#getData function: scrape csv data from uhslc website

getData <- function(number) {
	data <- ""
	for(i in 1:number) {
		# change the url according to the id
		url[i] <- paste('http://uhslc.soest.hawaii.edu/data/csv3/fdd/fdd000',i,'.csv', sep="")
		
		# skip if url does not exist
		if(GET(url[i])$status_code!=200) next
		
		# scrape it
		dataset <- fread(url[i])
		
		# modify column headers
		setnames(dataset, column_names)
		
		# add all data to a list
		data[i] <- list(dataset)
	}

	return(data)
}

#get mean

getMean <- function(dataSet, Number) {
	aggregate(x = dataSet[[Number]]$seaLevel, by = list(year = dataSet[[Number]]$year), FUN = "mean")
}

#create bar chart with mean data

getMeanPlot <- function(dataSet, Number) {
	average <- aggregate(x = dataSet[[Number]]$seaLevel, by = list(year = dataSet[[Number]]$year), FUN = "mean")
	barplot(average$x, main="Yearly Means", xlab="Years", names.arg=(average$year))
}