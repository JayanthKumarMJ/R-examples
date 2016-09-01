## clean data week 3 quiz 

## question 1 :
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
              destfile = "Idaho-State-acs.csv")
acsData <- read.csv("Idaho-State-acs.csv")
agricultureLogical = (acsData$ACR == 3 & acsData$AGS == 6)
which(agricultureLogical)

## question 2 :
install.packages("jpeg")
library(jpeg)
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", 
              destfile = "jeff.jpg")
img <- readJPEG("<path-to-file>/jeff.jpg", native = TRUE)
quantile(img, c(0.30,0.80))

## question 3 : 
library(dplyr)
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
              destfile = "gdp-data.csv")
gdp <- read.csv("gdp-data.csv", colClasses = "Character")
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
              destfile = "edu-data.csv")
eduData <- read.csv("edu-data.csv")
gdp1 <- tbl_df(gdp) %>% select(X ,Gross.domestic.product.2012, X.2)
colnames(gdp1) <- c("CountryCode","ranking","Country")
eduDf <- tbl_df(eduData) %>% select(CountryCode)
result <- inner_join(gdp1, eduDf)
result <- mutate(result, ranking = extract_numeric(ranking)) %>% arrange(desc(ranking))
print(result[13,3])
print(nrow(na.omit(result)))

##Question 4 : 
gdp <- read.csv("gdp-data.csv", colClasses = "character") %>% tbl_df()
eduData <- read.csv("edu-data.csv", colClasses = "character") %>% tbl_df()
colNames <- colnames(gdp)
colNames[1] <- "CountryCode"
colnames(gdp) <- colNames
result <- inner_join(gdp,eduData) %>% 
    group_by(Income.Group) %>% 
    mutate(Gross.domestic.product.2012 = extract_numeric(Gross.domestic.product.2012)) %>% 
    summarise(avg = mean(Gross.domestic.product.2012, na.rm = TRUE))
print(result)

##Question 5 : 
gdp <- read.csv("gdp-data.csv", colClasses = "character") %>% tbl_df()
eduData <- read.csv("edu-data.csv", colClasses = "character") %>% tbl_df()
colNames <- colnames(gdp)
colNames[1] <- "CountryCode"
colNames[2] <- "rank"
colnames(gdp) <- colNames
result <- inner_join(gdp,eduData) %>% select(CountryCode,2,Income.Group) %>% 
    mutate(rank = extract_numeric(rank)) %>%
    mutate(quantileGdpGroup = cut(rank, 
        breaks = quantile(rank, probs = seq(0, 1, 0.2), na.rm = TRUE))) %>%
    filter(Income.Group == "Lower middle income") %>% 
    group_by(quantileGdpGroup) %>% 
    summarise(n = n())
