## Question no : 1
#  The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
#  and load the data into R. The code book, describing the variable names is here:
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
#  Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?

download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "acs-data.csv")
names <- read.csv("acs-data.csv", nrows = 5) %>% colnames() %>% strsplit("wgtp")
print(names[[123]])

## Question no :2
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Remove the commas from the GDP numbers in millions of dollars and average them. 
# What is the average?
library(dplyr)
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", 
              destfile = "gdp-data.csv")
data <- read.csv("gdp-data.csv", colClasses = "character", skip = 4) %>% 
    tbl_df() %>%
    filter(X != "" & X.1 !="")
as.numeric(gsub(",","",x=data$X.4)) %>% mean(na.rm = TRUE)

## Question no :3
# In the data set from Question 2 what is a regular expression that would allow you to 
# count the number of countries whose name begins with "United"? Assume that the variable 
# with the country names in it is named countryNames. How many countries begin with United?
read.csv("gdp-data.csv", colClasses = "character", skip = 4) %>% 
    tbl_df() %>%
    filter(X != "" & X.1 !="") %>% 
    filter(grepl("^United",X.3)) %>% 
    summarise(total = n())

## Question no :4
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Load the educational data from this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# Match the data based on the country shortcode. Of the countries for which the 
# end of the fiscal year is available, how many end in June?

library(data.table)
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "gdp-data.csv")
gdp <- fread(input = "gdp-data.csv", sep = ",", stringsAsFactors = FALSE)
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
              , destfile = "edu-data.csv")
edudata <- fread(input = "edu-data.csv", sep = ",", stringsAsFactors = FALSE)
gdp <- gdp[gdp$Gross.domestic.product.2012 !="" & gdp$X !="",c(1,2,4)]
colnames(gdp) = c("CountryCode","ranking","country")
merged <- merge(gdp,edudata,by = c("CountryCode"))
isFiscalYearEndAvailable <- grepl("fiscal year end" , merged$`Special Notes`)
isJuneAvailble <- grepl("june", tolower(merged$`Special Notes`))
isFiscalYearEndAvailable <- grepl("fiscal year end" , tolower(merged$`Special Notes`))
table(isJuneAvailble, isFiscalYearEndAvailable)
View(merged[isFiscalYearEndAvailable & isJuneAvailble,])

#Question no 5 :
# You can use the quantmod (http://www.quantmod.com/) package to get historical 
# stock prices for publicly traded companies on the NASDAQ and NYSE. 
# Use the following code to download data on Amazon's stock price and get 
# the times the data was sampled.
# How many values were collected in 2012? 
# How many values were collected on Mondays in 2012?
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
addmargins(table(year(sampleTimes) ,weekdays(sampleTimes)))



