
## example 1 of scoping 
y <- 10

f <- function(x){
  y <- 2
  y ^2 + g(x)
}

g <- function(x){
  x*y
}

f(3)

lm <- function(x) {x*x}
lm

## look at scoping order (first looks at golbal environment, and then in packages)
search()

## Variable z below is a free variable. Scoping rules tell us how we define values for such variables 
f <- function(x,y){
  x^2 + y/z
}
