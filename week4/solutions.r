best = function(state, reason) {
  outcomes = read.csv("outcome-of-care-measures.csv")
  
  if(!is.element(state, unique(outcomes$State))) stop('invalid state')
  
  sourceDataColIdx = 
    if(reason == 'heart attack') 11
    else if (reason == 'heart failure') 17
    else if (reason == 'pneumonia') 23
    else stop("invalid outcome")
  
  sourceNameColIdx <- 2
  nameDataKvps = outcomes[which(outcomes$State == state & outcomes[sourceDataColIdx] != "Not Available"), 
                          c(sourceNameColIdx, sourceDataColIdx)]
  
  keyIdx = 1
  valueIdx = 2
  minIdxs = which.min(as.numeric(as.character(nameDataKvps[,valueIdx])))
  as.character(sort(nameDataKvps[minIdxs, keyIdx])[1])
} 