library(randomNames)
names <- randomNames(288) # Creates a list of random names
new_Names <- sample(names) # Randomises names
splitNames <- strsplit(new_Names, ", ") # Splits the first and last names 
first_Names <- sapply(splitNames, function(x) x[2]) # New list of first names 
last_Names <- sapply(splitNames, function(x) x[1]) # New list of last names
groupListF <- split(first_Names, rep(1:16, each = length(first_Names)/16)) # Splits the ra 
groupListL <- split(last_Names, rep(1:16, each = length(last_Names)/16))
# Create an empty data.frame
gradeBook <- data.frame(Firstname = character(), Surname = character(),
                        Pod = integer())
# Iterate over the groups and fill the data frame
for (i in 1:16) {
  gradeBook <- rbind(gradeBook, data.frame(
    Firstname = groupListF[[i]],
    Surname = groupListL[[i]],
    LabPod = rep(i, length(groupListF[[i]]))
  )) }

engagement <- rbinom(6, 288, 0.8) # Creates a distribution simulating engagement
for (i in 1:length(engagement)) { # Goes through the list of numbers of students who engag 
  selection <- sample(1:nrow(gradeBook), 1) # Randomly chooses a row in the gradebook 
  selected_rows <- sample(1:nrow(gradeBook), selection) # Chooses random rows from the sel 
  column_name <- paste0("Log", i) # Labels the columns 1 to 6
  gradeBook[[column_name]] <- "NO"
  gradeBook[[column_name]][selected_rows] <- "YES" # Labels whether a student engaged in a 
  }
  req_columns <- c("Log1", "Log2", "Log3", "Log4", "Log5", "Log6")
  yes_prop <- colMeans(gradeBook[req_columns] == "YES") # Only those rows that have a yes fo
  barplot(yes_prop, # Creates a bar plot that represents the proportion who submitted per Lo main = "Proportions of submissions ",
          xlab = "Log",
          ylab = "Proportion of those who did submit",
          col = "skyblue",
          border = "white",
          ylim = c(0, 1), names.arg = req_columns, las = 2)