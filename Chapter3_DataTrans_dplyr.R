# R4DS Book club https://www.youtube.com/watch?v=0NdiQuuM0vw&list=PL3x6DOfs2NGjk1sPsrn2CazGiel0yZrhc&index=2
#Chapter 3

#Data transformation with dplyr

library(tidyverse)
library(nycflights13)

flights

#dplyr Basic
# filter()
# arrange()
# select()
# mutate()
# summarize()
# group_by()

#filter()
#filter(<DATA>,<CONDITIONS>,...)

#Select all flights that flew on 1st Jan
jan1 <- filter(flights, month == 1, day == 1)

(dec25 <- filter(flights, month == 12, day ==25))


#Comparision
# > >= < <= != ==
# == is used to see if 2 things are equal rather than =, except for floating-point numbers due to finite precesion algorithm
#eg:

sqrt(2)^2 == 2
1/49 *49 == 1

#in such cases use approximation, i.e. near()
near(sqrt(2)^2,2)
near(1/49*49,1)

#Logical operators
#& | !

filter(flights, month == 11 | month == 12)

filter(flights, month %in% c(11,12))

#De Morgan's law
# !(x & y) == !x | !y
# !(x | y) == !x & !y 

filter(flights, !(arr_delay > 120 | dep_delay > 120))
#is same as
filter(flights, arr_delay <= 120, dep_delay <= 120)


#Missing Values

NA > 5
NA == 4
NA / 2
NA * 2
NA == NA

x = NA
is.na(x)

#filter needs to be explicitly mentioned to check fro NA

df <- tibble(x = c(1,NA,13))
filter(df, x >1)
filter(df, is.na(x) | x >1)

#Excercise

#1
filter(flights, arr_delay >= 121)

#2
filter(flights, dest %in% c('IAH','HOU'))

#3 AA, UA, DL (check from nycflights13::airlines)
filter(flights, carrier %in% c('UA','AA','DL'))

#4
filter(flights, month %in% c(7,8,9))

#5
filter(flights, arr_delay > 120 & dep_delay < 1)

#6
filter(flights, dep_delay > 60 & dep_delay - arr_delay >29)

#7
filter(flights, dep_time <600 | dep_time == 2400)

# 3
filter(flights, is.na(dep_time))

#Arrange

arrange(flights, year, month, day)

#1
arrange(flights, -(is.na(dep_time)))

#2
arrange(flights, desc(dep_delay))
arrange(flights, (dep_delay))

#3
arrange(flights, air_time)

#4
arrange(flights, distance)
arrange(flights, desc(distance))
