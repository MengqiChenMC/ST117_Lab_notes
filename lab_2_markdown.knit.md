---
title: "ST117 Lab 2"
subtitle: "Data frame, random numbers, and functions"
author: "Mengqi Chen"
date: last-modified
format: html
editor: visual
theme: darkly
---




# 1 Q&A from the previous session

## 1.1 Data frame header

When we read a CSV file with `read.csv`, there is an argument `header` deciding whether it reads the first row as the column names of the variables.

Recall that last time, we generated a random data frame of columns named "id" and "score" first.


::: {.cell}

```{.r .cell-code}
data <- data.frame(
  id = 1:3,
  score = sample(5:10, 3, replace = TRUE) # sample(list, n) allows you to sample number n values from list
)
data
```

::: {.cell-output .cell-output-stdout}

```
  id score
1  1     7
2  2    10
3  3     8
```


:::
:::


Now, we write `data` into a CSV file


::: {.cell}

```{.r .cell-code}
# Write the data frame to a CSV file
write.csv(data, "sample_data.csv", row.names = FALSE)
```
:::


If we read with `header=TRUE` (default in this case), "id" and "score" are parsed as column names instead of variable values


::: {.cell}

```{.r .cell-code}
data_read_header <- read.csv("sample_data.csv", header = TRUE)
data_read_header
```

::: {.cell-output .cell-output-stdout}

```
  id score
1  1     7
2  2    10
3  3     8
```


:::
:::


However, if we read with `header=FALSE`, then "id" and "score" are regarded as values


::: {.cell}

```{.r .cell-code}
data_read_noheader <- read.csv("sample_data.csv", header = FALSE)
data_read_noheader
```

::: {.cell-output .cell-output-stdout}

```
  V1    V2
1 id score
2  1     7
3  2    10
4  3     8
```


:::
:::


In this case, you would run into problems if you simply take the first column of `data_read`:


::: {.cell}

```{.r .cell-code}
data_read_noheader[,1]
```

::: {.cell-output .cell-output-stdout}

```
[1] "id" "1"  "2"  "3" 
```


:::
:::


You also run into problems if you are getting a column by its name:


::: {.cell}

```{.r .cell-code}
data_read_header$id
```

::: {.cell-output .cell-output-stdout}

```
[1] 1 2 3
```


:::
:::

::: {.cell}

```{.r .cell-code}
data_read_noheader$id
```

::: {.cell-output .cell-output-stdout}

```
NULL
```


:::
:::


::: callout-note
## Note

`header` is defaulted to `TRUE` if and only if the first row contains one fewer field than the number of columns. For further details, use `?read.csv` to check the full documentation.
:::

## 1.2 R script vs Console

The R Console is an interactive platform for immediate execution of individual commands, ideal for exploratory data analysis and quick tests.

In contrast, R Scripts are non-interactive files where code can be written, saved, and executed in a structured and reproducible manner, suitable for complex and longer projects.

## 1.3 Installing and loading packages

When you find a useful R package that isn't already installed on your system, you use `install.packages()` to download and install it. This is typically a one-time process for each package. For example, to install the `ggplot2` package, you would use:


::: {.cell}

```{.r .cell-code}
install.packages("ggplot2")
```
:::


Every time you start a new R session and want to use a previously installed package, you need to load it using the `library()` function. This needs to be done at the beginning of your scripts to ensure that all functions from the package are available. For example:


::: {.cell}

```{.r .cell-code}
library(ggplot2)
```
:::


This command does not install the package again, but simply makes its functionality available in your current session.

## 1.4 Converting between strings and mumbers

To convert a string that represents a number into a numeric format, you can use the `as.numeric()` function. For example:


::: {.cell}

```{.r .cell-code}
numbers_as_strings <- c("1", "2", "3")
numbers <- as.numeric(numbers_as_strings)
```
:::


Conversely, if you need to convert numbers to strings, perhaps for output formatting, use the `as.character()` function:


::: {.cell}

```{.r .cell-code}
numbers <- c(1, 2, 3)
numbers_as_strings <- as.character(numbers)
```
:::


# 2 Functions in R

In R, a function is defined using the `function` keyword. The basic syntax is:


::: {.cell}

```{.r .cell-code}
myFunction <- function(arg1, arg2) {
  # Function body
  result <- arg1 + arg2
  return(result)
}
```
:::


This creates a function `myFunction` that takes two arguments `arg1` and `arg2`, adds them together, and returns the result.

Once a function is defined, it can be called with specific values for its arguments.


::: {.cell}

```{.r .cell-code}
# Calling the function
result <- myFunction(5, 3)
print(result) # Outputs 5+3
```

::: {.cell-output .cell-output-stdout}

```
[1] 8
```


:::
:::


The `apply` family of functions in R is used to apply a function over the margins of an array or matrix, and it's particularly useful for data frames. For example, `apply` can be used to apply a function to each column or row of a data frame.


::: {.cell}

```{.r .cell-code}
# Example data frame
df <- data.frame(a = 1:3, b = 4:6)
df
```

::: {.cell-output .cell-output-stdout}

```
  a b
1 1 4
2 2 5
3 3 6
```


:::
:::

::: {.cell}

```{.r .cell-code}
# Define a simple function to calculate the mean
meanFunction <- function(x) {
  return(mean(x))
}

# Apply meanFunction to each column of df to get the mean of each column
apply(df, MARGIN = 2, FUN = meanFunction) # MARGIN = 1 indicates rows (try it!)
```

::: {.cell-output .cell-output-stdout}

```
a b 
2 5 
```


:::
:::


This will calculate the mean of each column in the data frame `df`.

# 3 Assignments

::: callout-important
## Your turn!

The following is the Lab 2 worksheet kindly designed by [**Yujing Lu**](mailto:Yujing.Lu.2@warwick.ac.uk), the module tutor.

1.  Please attempt these questions with your deskmate - raise your hand if you need any help.
2.  If you and your deskmate have chosen different methods, check if you get the same results!
3.  The solutions will be posted after the session.
:::

## 3.1 Random numbers and data frame

### 3.1.1 Generating Random Numbers and Names

\(i\) Generate two vectors $(v_1,v_2)$ of 30 random integers each, where the elements in $v_1$ are uniformly drawn from $\{80,81,\dots,100\}$, and the elements in $v_2$ are uniformly drawn from $\{60,61,\dots, 90 \}$, with replacement.





\(ii\) Generate a vector of 30 random names using the `randomNames()` function. Remember to install the `randomNames` package and load it!





::: callout-tip
## Hint

`set.seed()` allows the code to be reproducible by setting a specific seed value. When a seed is set, the sequence generated remains deterministic.
:::





### 3.1.2 Create a data frame

We aim to record the names, assignment marks, and exam marks of 30 students from course 1 in a table. Using the functions above, first generate these items randomly, then combine them into a data frame with three columns: "names", "assignment", and "exam".





### 3.1.3 Deal with data frame

\(i\) First, calculate the final marks for this course using the formula $$\text{Final mark} = 0.2\times \text{Assignment} + 0.8\times \text{Exam}$$ and add this information to a new column named `finalMark`.





\(ii\) Can you find the student with the highest `finalMark`?

::: callout-tip
## Hint

1.  You may consider sorting your data frame in descending order by the values of `finalMarks` - look up the different between `sort` and `order`!
2.  Alternatively, you can use the `arrange` function in the [**`dplyr`**](https://dplyr.tidyverse.org/) package for this task (optional).
:::









\(iii\) Next, calculate the means of `assignment`, `exam`, and `finalMarks`, respectively.









\(iv\) Then, randomly pick 10 students and set then to have chosen course 2. The other students have not chosen this course. Please add a column `course2` to indicate their choice (0 for yes,1 for no).





\(v\) Finally, find the students with marks above 85 and who haven't chosen course 2 by extracting values from the `names` column. You can also use the `apply()` function for this purpose. Verify if these two methods give the same results.







## 3.2 Define a function

Recall that the Fibonacci sequence is defined by recurrent relations:

$F_0=0,\ F_1=1,\ F_n=F_{n-1}+F_{n-2}$.

Define a function to produce the nth Fibonacci number with or without a loop.







## 3.3 Uniform distribution and histogram

Simulate 1000 samples from a uniform distribution $X\sim U[0,1]$ and create a histogram of the generated sequence. Overlay the histogram on the probability density function - does the histogram reflect the density well?

::: callout-tip
## Hint

1.  You can look up `dunif()`, which defines the probability density function of a uniform distribution.
2.  To plot the histogram, you can simply use the `hist` function - alternatively, you can try the `ggplot2` package.
:::









::: callout-note
## Discussion

If we increase the number of simulations, does the fit improve?
:::

# 4\* Simulation Game: Coin Tossing Problem

::: callout-note
## Note

This is a more complicated simulation game and is not compulsory - try it if you are interested!
:::

## Problem Statement

A and B are tossing a fair coin. A wins if HHH appears first; B wins if HTH appears first. Who is more likely to win?

## Simulation Code

We can write some codes to simulate the game


::: {.cell}

```{.r .cell-code}
simulate_coin_toss <- function(sequence_a, sequence_b, num_simulations = 10000) {
  wins_a <- 0
  wins_b <- 0

  # play the game num_simulations times
  for (i in 1:num_simulations) {
    
    # keep tossing until there is a winner
    coin_sequence <- ""
    while (!grepl(sequence_a, coin_sequence) && !grepl(sequence_b, coin_sequence)) {
      coin_sequence <- paste0(coin_sequence, sample(c("H", "T"), 1, replace = TRUE))
    }
    
    # record the winner
    if (grepl(sequence_a, coin_sequence)) {
      wins_a <- wins_a + 1
    } else {
      wins_b <- wins_b + 1
    }
  }

  # use the number of wins to estimate the winning probability
  prob_a_wins <- wins_a / num_simulations
  prob_b_wins <- wins_b / num_simulations

  return(c(prob_a_wins, prob_b_wins))
}

# Call the function
simulate_coin_toss("HHH", "HTH")
```

::: {.cell-output .cell-output-stdout}

```
[1] 0.406 0.594
```


:::
:::


::: callout-important
## Your turn

1.  Can you write some codes to estimate the expected number of tosses needed until a certain player gets a win?
2.  Can you prove your winning probabilities algebraically?
:::




