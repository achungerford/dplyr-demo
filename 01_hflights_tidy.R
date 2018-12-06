# author: Alexander C. Hungerford

# created: 5 December 2016

# title:
    # Datacamp
    # Data Manipulation in R with Dplyr
    # Section 1 - tidying data


# envSetup ----------------------------------------------------------------

# set up the envirnoment
# install.packages("dplyr")
# install.packages("hflights")

library("dplyr")
library("hflights")
library("tidyr")


# load, View Data ---------------------------------------------------------

# read in data
hflights <- hflights::hflights

# Look at the data
str(hflights)
hflights[1:20,]


# df to tibble to df again ------------------------------------------------

# create hflights_tbl as tibble
hflights <- tbl_df(hflights)

# tibbles are a special dataframe that shows you only what fits in your
# console and adjusts with the size of your window
hflights

# the tibble is multiple classes
class(hflights)

# convert back to dataframe as hflights
hflights <- as.data.frame(hflights)
class(hflights)

# back to tibble -- using as_tibble() function
hflights <- as_tibble(hflights)
class(hflights)

str(hflights)

# lookup table ------------------------------------------------------------

# create Carriers object
carriers <- hflights$UniqueCarrier
class(carriers)

## changing labels of hflights; named vector as lookup table
lut <- c("AA" = "American", "AS" = "Alaska", "B6" = "JetBlue",
         "CO" = "Continental", "DL" = "Delta", "OO" = "SkyWest",
         "UA" = "United", "US" = "US_Airways", "WN" = "Southwest",
         "EV" = "Atlantic_Southeast", "F9" = "Frontier",
         "FL" = "AirTran", "MQ" = "American_Eagle",
         "XE" = "ExpressJet", "YV" = "Mesa")

class(lut)

# add a Carrier column (base R, not mutate)
hflights$Carrier <- lut[hflights$UniqueCarrier]

# turn UniqueCarrier codes into corresponding names using lut
hflights$UniqueCarrier <- lut[hflights$UniqueCarrier]

head(hflights$UniqueCarrier)
# we went straight down the UniqueCarrier column and we replaced
# the codes -- AA, AS, DL, UA etc. -- with the corresponding names from lut,
# our lookup table; American, Alaska, Delta, United etc.

# now you'll see the Carrier variable, looking at variables 19, 20, 21, 22
str(hflights[19:22])

# notice we have 22 variables now with Carrier
glimpse(hflights)

# drop Carrier column
hflights <- hflights[1:21]


# lut cancellations -------------------------------------------------------

# lookup table for cancellation codes
lut <- c("A" = "carrier", "B" = "weather", "C" = "FFA",
         "D" = "security", "E" = "not cancelled")

# this will take a few minues -- add a Code column
hflights$Code <- lut[hflights$CancellationCode]

# class is a "character"
class(hflights$Code)
hflights$Code[1:500]


# looking at a tibble column, we only see the first 10 rows
hflights %>%
  select(Code)

# remove NA, use glimpse to get a better view of the data
glimpse(hflights %>%
               select(Code) %>%
               filter(!is.na(Code))
        )

# still not great, but you can use View()
glimpse(hflights %>%
          select(Code) %>%
          filter(!is.na(Code))
) %>% View()

# change NA to "not cancelled" using tidyr


# see column Code
str(hflights)



# tbl back to df ----------------------------------------------------------

# from hflights package, call data hflights, and assign back to hflights
hflights <- hflights::hflights
str(hflights)




# Section 2: Select & Mutate ----------------------------------------------

# select() will remove rows, returning only the ones we've chosen
    # contains("x")
    # matches("x")
    # ends_with("xyz")
    # starts_with("abc")



# NOTES -------------------------------------------------------------------
# 
# select(), which returns a subset of the columns,
# filter(), that is able to return a subset of the rows,
# arrange(), that reorders the rows according to single or multiple variables,
# mutate(), used to add columns from existing data,
# summarize(), which reduces each group to a single row by calculating aggregate measures.
