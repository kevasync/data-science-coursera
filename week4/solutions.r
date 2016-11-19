best = function(state, outcome) {
  outcomes = read.csv("outcome-of-care-measures.csv")
  
  if(!is.element(state, unique(outcomes$State))) stop('invalid state')
  
  nameIdx <- 2
  dataIdx = 
    if(outcome == 'heart attack') 11
    else if (outcome == 'heart failure') 17
    else if (outcome == 'pneumonia') 23
    else stop("invalid outcome")
  
  filteredData = outcomes[which(outcomes$State == state & outcomes[dataIdx] != "Not Available"), 
                          c(nameIdx, dataIdx)]
  
  minIdxs = which.min(as.numeric(as.character(filteredData[,2])))
  as.character(head(sort(filteredData[minIdxs, 1]), 1))
} 