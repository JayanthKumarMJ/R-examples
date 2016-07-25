readDataAndFilter <- function(state, colNumber){
    outComeDf <- read.csv("rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = 'character')
    if(!is.null(state)){
        outComeDf[outComeDf$State == state,c(2,colNumber)]
    }else{
        outComeDf[,c(2,colNumber)]
    }
} 

getRankedData <- function(state, outcome){
     colclasses <- c("character","character","character")
     outComeToColumnMap <- list("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
     colNumber <- outComeToColumnMap[[outcome]]
     if(is.null(colNumber)){
         return("invalid outcome") 
     }
     filteredDf <- readDataAndFilter(state,colNumber)
     if(is.data.frame(filteredDf) && nrow(filteredDf) == 0){
         return("invalid state")
     }
     filteredDf[, c(2)] <- sapply(filteredDf[, c(2)], as.numeric)
     filteredColumns <- filteredDf[order(filteredDf[2],filteredDf[1]),]
     filteredColumns <- cbind(filteredColumns, 1:nrow(filteredColumns))
     colnames(filteredColumns) <- c("HospitalName", "Rate", "Rank")
     na.omit(filteredColumns)
 }

best <- function(state, outcome) {
    filteredColumns <- getRankedData(state, outcome)
    if(is.data.frame(filteredColumns)){
        filteredColumns[1,1]
    }else{
        stop(filteredColumns)
    }
}

getResult <- function(num, filteredData){
    if(nrow(filteredData) == 0){
        return(NA)
    }
    if(num == "best"){
        return(filteredData[1,1]) 
    }
    if(num == "worst"){
        return(filteredData[nrow(filteredData),1])    
    }
    if(nrow(filteredData) < num){
        return(NA)
    }
    filteredData[num,1]
}

# ranks hospital in a particular state, if null is passed to state, it considers all states data.
rankhospital <- function(state, outcome, num = "best") {
    filteredData <- getRankedData(state, outcome)
    if(is.data.frame(filteredData)){
        getResult(num,filteredData)
    }else{
        stop(filteredData)
    }
}

# Ranks hospitals accross USA
rankall <- function(outcome , num = "best"){
    outComeDf <- read.csv("rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = 'character')
    outComeToColumnMap <- list("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
    colNumber <- outComeToColumnMap[[outcome]]
    if(is.null(colNumber)){
        stop("invalid outcome") 
    }
    outComeDf <- outComeDf[,c(7,2,colNumber)]
    outComeDf[,c(3)] <- sapply(outComeDf[,c(3)],as.numeric) 
    outComeDf <- outComeDf[order(outComeDf[1],outComeDf[3],outComeDf[2]),]
    states <- unique(outComeDf$State)
    finalData <- sapply(states, function(state){
        df <- outComeDf[outComeDf$State == state,c(2,1)]
        if(num == "best"){
            return(df[1,]) 
        }
        if(num == "worst"){
            return(df[nrow(df),])    
        }
        if(nrow(df) < num){
            return(c(NA,state))
        }
        df[num,]
    })
    t(finalData)
}
