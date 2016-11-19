best = function(state, outcome) {
  rawData = readOutcomeMeasures()
  d = sortedNameAndOutcome(rawData, state, outcome)
  as.character(d$name[1])
} 

rankHospital = function(state, outcome, rank){
  rawData = readOutcomeMeasures()
  d = sortedNameAndOutcome(rawData, state, outcome)
  
  if(nrow(d) < rank) NA
  else as.character(d$name[rank])
}

sortedNameAndOutcome = function(rawData, state, outcome) {
  if(!is.element(state, rawData$State)) stop('invalid state')
  
  nameIdx = 2
  dataIdx = if(outcome == 'heart attack') 11
            else if (outcome == 'heart failure') 17
            else if (outcome == 'pneumonia') 23
            else stop("invalid outcome")
  
  filtered = rawData[which(rawData$State == state & rawData[dataIdx] != "Not Available"), 
          c(nameIdx, dataIdx)]
  
  names(filtered) = c("name", "value")
  
  #convert data to numeric without truncation
  filtered[, 2] = as.numeric(as.character(filtered$value))
  
  filtered[order(filtered$value, filtered$name), ]
}

readOutcomeMeasures = function() {
  read.csv("outcome-of-care-measures.csv")
}

