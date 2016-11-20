best = function(state, outcome) {
  rawData = readOutcomeMeasures()
  d = sortedData(rawData, outcome, state)
  as.character(d$name[1])
} 

rankHospital = function(state, outcome, rank = "best"){
  rawData = readOutcomeMeasures()
  d = sortedData(rawData, outcome, state)
  
  rank = if(rank == "best") 1
  else if(rank == "worst") nrow(d)
  else rank
  
  if(nrow(d) < rank) NA
  else as.character(d$name[rank])
}

rankAll = function (outcome, rank = "best") {
  rawData = readOutcomeMeasures()
  d = sortedData(rawData, outcome, descending = rank == "worst")
   
  if(is.numeric(rank)) {
    nRows = nrow(d)
    if(rank > nRows) return(NA)
    
    d = d[rank:length(d), ]
  }
  
  d[,c(1,3)]
}

sortedData = function(rawData, outcome, state = NA, descending = FALSE) {
  if(!is.na(state) & !is.element(state, rawData$State)) stop('invalid state')
  
  nameIdx = 2
  stateIdx = 7
  dataIdx = if(outcome == 'heart attack') 11
            else if (outcome == 'heart failure') 17
            else if (outcome == 'pneumonia') 23
            else stop("invalid outcome")
  
  filtered = rawData[which((is.na(state) | rawData$State == state) & rawData[dataIdx] != "Not Available"), 
          c(nameIdx, dataIdx, stateIdx)]
  
  names(filtered) = c("name", "value", "state")
  
  #convert data to numeric without truncation
  filtered[, 2] = as.numeric(as.character(filtered$value))
  
  filtered[order(filtered$value, filtered$name, decreasing = descending), ]
}

readOutcomeMeasures = function() {
  read.csv("outcome-of-care-measures.csv")
}

