# R-examples
This repo has Coursera assignments. can also be helpful for users who want have a look at examples of data frame, reading specific columns of CSV, 
filtering data and order by on multiple columns. New examples and assignments will be added to this Repo.

## cleaning data week 3 quiz has been added.
1. The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv and load the data into R. The code book, describing the variable names is here: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE. which(agricultureLogical) What are the first 3 values that result?
2. Using the jpeg package read in the following picture of your instructor into R https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? (some Linux systems may produce an answer 638 different for the 30th quantile)
4. What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
5. Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?
