# author: Alexander C. Hungerford

# created: 5 December 2016

# title:
    # Datacamp
    # Data Manipulation in R with Dplyr
    # Section 1 - tidying data


# Note a bug: If you work with tibbles in a script and you're adding
# other columns to the tibble later in the script, you'll see a
# Warning(s) "Unknonw or uninitialized column".
# You can avoid this by working with the data as a data frame
# rather than a tibble.


# envSetup ----------------------------------------------------------------

# set up the envirnoment
# install.packages("dplyr")
# install.packages("hflights")

library("dplyr")
library("hflights")
library("tidyr")
options(warn = 1) # shows all warnings immediately

# load, View Data ---------------------------------------------------------

# read in data
hflights <- hflights::hflights

# familiarize yourself with the data
str(hflights)


# df to tibble to df again ------------------------------------------------

# change hflights from df to tibble
hflights <- as_tibble(hflights)

# tibbles are a special dataframe that shows you only what fits in your
# console and adjusts with the size of your window
hflights

# the tibble is multiple classes
class(hflights)

# convert back to dataframe
hflights <- as.data.frame(hflights)

# back to tibble
# hflights <- tbl_df(hflights)


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


# add a Carrier column (base R, not mutate)
hflights$Carrier <- lut[hflights$UniqueCarrier]
str(hflights)

# turn UniqueCarrier codes into corresponding names using lut
hflights$UniqueCarrier <- lut[hflights$UniqueCarrier]

head(hflights$UniqueCarrier)
# we went straight down the UniqueCarrier column and we replaced
# the codes -- AA, AS, DL, UA etc. -- with the corresponding names from lut,
# our lookup table; American, Alaska, Delta, United etc.

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

# class = "character"
class(hflights$Code)
hflights$Code[1:500]


# looking at Code column
hflights %>%
  select(Code)

# look at 'Code' column, NAs removed
hflights %>%
  select(Code) %>%
  filter(!is.na(Code))

# remove NA, use View() to show 'Code' column
hflights %>%
  select(Code) %>%
  filter(!is.na(Code))%>% 
  View()

# change NA to "not cancelled" using tidyr
hflights <- hflights %>%
  replace_na(list(Code = "not cancelled"))

# see column Code
str(hflights)

# drop 'CancellationCode' column
hflights <- select(hflights, -CancellationCode)

# move Diverted to end -- select all except diverted, then reselect 
hflights <- select(hflights, -Diverted, Diverted)
str(hflights)

# rename 'Code' column to 'CancellationCode'
hflights <- rename(hflights, CancellationCode = Code)
str(hflights)

# create a backup checkpoint in case hflights is manipulated incorrectly
backup <- hflights
head(backup)


# Section 2: Select & Mutate ----------------------------------------------

# select() will remove rows, returning only the ones we've chosen
    # starts_with("abc")
    # ends_with("xyz")
    # contains("x")
    # matches("x")
    # num_range("x", 1:5)
    # one_of("x") - x is a char vector



# NOTES -------------------------------------------------------------------
# 
# select(), which returns a subset of the columns,
# filter(), that is able to return a subset of the rows,
# arrange(), that reorders the rows according to single or multiple variables,
# mutate(), used to add columns from existing data,
# summarize(), which reduces each group to a single row by calculating aggregate measures.
