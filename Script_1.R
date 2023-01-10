## SYMBOL BINDING 

## When R tries to bind a value to a symbol it searches through a series of environments to find the appriopate value
## It first searches the global enviornment, and then searches within the packages 

## look at scoping order (first looks at global environment, and then in packages)
search()

## example 1 of scoping 
y <- 10

f <- function(x){
  y <- 2
  y ^2 + g(x)
}

g <- function(x){
  x*y
}
## When we call f (3) this is what happens: 
## 1a. f function is y^2 + g(x). We use 2 for y as we define it as such within the function. 
## 1b. We now have 2^2 + g(x).
## 2a.g(x) is defined as x*y. x has been defined as 3 from f(3)
## 2b: y is a free variable. Y is not defined within the function so we now look at the global environment 
## 2c: y is defined as 10 in global environment so we use that value 
## 3a: f(3) = 2^2 +(3*10)
## 3b f(3)= 34
f(3)

## example 2
## lm is not defined in the global environment, but it is defined in the stats package 
## so the below will return how lm is defined in the stats package 
lm

## Now when we define lm in our global envionment and call lm --> it will return the defintion we used in the global environment 
lm <- function(x) {x*x}
lm

## Example 3 
## Variable z below is a free variable. Scoping rules tell us how we define values for such variables 
f <- function(x,y){
  x^2 + y/z
}
## Below will return error as z has not been defined in our global environment nor within the packages
f(2,3)

## Below will return a value as we have defined z in the global environment 
z <- 3
f(2,3)

## Example 4

a <- 7

b <- function() a

c <- function() {
  a<-8
  b()
}
## Function C defines a as 8 within the function and then returns the value of function b()
## Function b() simply returns the value of a 
## a is a free variable in function b, so how does scoping define it?
## Lexical scoping first looks for the value of a in the global environment, and finds it to be 7 
## As such, c() returns 7 
c()

## If we removed the definition of a in the global environment --> c() would return an error "object a not found"
## b() function looks for definition of a in global environment and packages, but not within the c() function
## As is such, objects defined within functions do not carry over to other functions 

## d() returns 8 because we define a as 8 in the fucntion and call a
d <- function() {
  a<-8
  a
}
d()


