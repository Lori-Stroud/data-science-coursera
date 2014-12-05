## Matrix inversion is usually a costly computation and there may be some
## benefit to caching the inverse of a matrix rather than computing it
## repeatedly.

## You can test these functions by entering the following commands:
##
##   source(cachematrix.R)
##   M = matrix(c(1, 2, 3, 4), nrow=2, ncol=2)
##   CM = makeCacheMatrix(M)
##   cacheSolve(CM))
##   cacheSolve(CM))   # will print to stderr 'getting cached data'


## This function creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
    i <- NULL        # initialize the cached matrix object ('i') to NULL

    # set and get the value of a matrix
    set <- function(y) {
        x <<- y
        i <<- NULL   # the matrix has changed: reinitialize to NULL
    }
    get <- function() x

    # set and get the value of a cached inverse matrix
    setinv <- function(inv) i <<- inv
    getinv <- function() i

    # list of all the available methods
    list(set = set, get = get,
         setinv = setinv, getinv = getinv)
}


## This function computes the inverse of the special "matrix" returned by
## makeCacheMatrix.  If the inverse has already been calculated
## (and the matrix has not changed), then cacheSolve will retrieve the inverse
## from the cache.

cacheSolve <- function(x, ...) {
    i <- x$getinv()
    # check if a cached object is available
    if(!is.null(i)) {
        message("getting cached data")
        return(i)           # return the inverse from the cache
    }

    # no cached object has been found
    data <- x$get()
    i <- solve(data, ...)   # calculate the inverse
    x$setinv(i)             # and cache its value

    i  # return the inverse matrix
}
