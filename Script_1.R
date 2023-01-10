## SYMBOL BINDING 

## When R tries to bind a value to a symbol it searches through a series of environments to find the appriopate value
## It first searches the global enviornment, and then searches within the packages 
## If value is not defined within a function, then scoping looks at the global environment and then the packages 
## This allows us to define global variables that are used in many different functions 


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
## y is a free variable in function f
## g(x) is a free variable in function f
## y is a free variable in function g
## 1a. f function is y^2 + g(x). For y^2 within f() --> we use 2 for y as we define it as such within the function. 
## 1b. We now have 2^2 + g(x).
## 2a.g(x) is defined as x*y in the global environment. x has been defined as 3 from f(3)
## 2b: y is a free variable in g(). Y is not defined within the function so we now look at the global environment 
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
## If the value of a object is not defined within the function, scoping looks at the global envionment 

## d() returns 8 because we define a as 8 in the fucntion and call a
d <- function() {
  a<-8
  a
}
d()



## R allows us to have functions defined inside other functions 
## It's possible for a function to return another function 
## The function that gets returned is defined within another function.
## In this case, the environment in which is was defined is the insides of that outter function (not the global environment)

## Example 
## make.power function takes an object n
## pow function takes an object x
## Inside the pow function, n is a free variable (x is a function argument)
## But n is defined in the make.power function. And make.power function is the environment in which pow is defined 
## So the pow function will look for the value of n inside the make.power environment 
make.power <- function(n){
  pow <- function(x){
    x^n
  }
  pow
}

# Create other functions called cube and square 
## make.power(3) creates a new function "cube" (essentially a copy of the originally make.power function but now we define n as 3) where n is defined as 3
cube <-make.power(3)
## make.power(2) creates a new function "square"  where n is defined as 2
square <-make.power(2)

## Below will set 3 as x. And cube already defines n as 3. So we get 3^3 = 27
cube(3)

##ls lets us look at the environment in which a function is defined
## for cube function: objecct n is defined and funciton pow is defined
ls(environment(cube))
get("n",environment(cube))
get("pow",environment(cube))

##So when we call cube function. It sets n as 3 and function pow as x^n
## x is a function argument which we set when calling cube()


## VARIABLE TYPES 
## x is a function (formal) argument
## a is a local variable (as it is defined within the function)
## y is a free variable 
z <- function(x){
  a<-3
  x+a+y
}
rm(y)

## y is not defined anywhere so this returns an error
z(2)
## now we define y in the global environment 
y <-3
## z(3) = 2+ 3 +3
z(2)



##EXTRA (OPTIMIZATION)
## Optimization in R (optim, nlm, optimize) requires to pass a function (example: log-likelihood) whose argument is a vector of parameters 
## Optimization aims to optimize the function (max, min, etc.)
## the function might depend on other things besides the parameters that we're optimizing over (like data)
## So when doing optimization, it is often useful to hold certain parameters fixed, and optimize over the other parameters