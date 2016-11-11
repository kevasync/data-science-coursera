## wrote some functions to create caching matrix object
## as well as  function to calculate matrix inverse and cache it using aforementioned object

## this function creates object cacehs matrix and its inverse

makeCacheMatrix <- function(x = matrix()) {
  inverse <- NULL
  set <- function(m) {
    x <<- m
    inverse <<- NULL
  }
  get <- function() x
  setinverse <- function(i) inverse <<- i
  getinverse <- function() inverse
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


## Write a short comment describing this function
## comments, really?  playoffs!?
## this function calculates the inverse from a caching matrix object and writes the inverse to the cache
cacheSolve <- function(x, ...) {
  invertedX <- x$getinverse()
  if(!is.null(invertedX)){
    return(invertedX)
  }

  m <- x$get()
  dims <- dim(m)
  invertedX <- matrix(nrow=0, ncol=dims[1])
  for(j in 1:dims[2]) {
    invertedX <- rbind(invertedX, m[,j])
  }

  x$setinverse(invertedX)
  invertedX
}
