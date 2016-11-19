best = function(state, outcome) {
  rawData = readOutcomeMeasures()
  filteredData = getHospitalNameAndData(rawData, state, outcome)

  minIdxs = which.min(as.numeric(as.character(filteredData[, 2])))
  as.character(head(sort(filteredData[minIdxs, 1]), 1))
} 

rankHospital = function(state, outcome, rank){
  rawData = readOutcomeMeasures()
  filteredData = getHospitalNameAndData(rawData, state, outcome)
}



getHospitalNameAndData = function(rawData, state, outcome) {
  validateState(state, rawData)
  nameIdx = 2
  dataIdx = getDataColumnIndex(outcome)
  return(rawData[which(rawData$State == state & rawData[dataIdx] != "Not Available"), 
          c(nameIdx, dataIdx)])
  
  validateState = function(state, outcomes) {
    if(!is.element(state, outcomes$State)) stop('invalid state')
  }
  
  getDataColumnIndex = function(outcome) {
    if(outcome == 'heart attack') 11
    else if (outcome == 'heart failure') 17
    else if (outcome == 'pneumonia') 23
    else stop("invalid outcome")
  }
}

readOutcomeMeasures = function() {
  read.csv("outcome-of-care-measures.csv")
}

