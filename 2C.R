
library(ggplot2) 
library("randomNames") 
library("dplyr")

#Cohort and lab groups
first_names_list <- randomNames(288,which.names = "first")
last_names_list <- randomNames(288,which.names="last")
Grade_Book <- data.frame(first_name = first_names_list, last_name = last_names_list, labgroup = rep(1:16,18))
first_five_students <- head(Grade_Book,5)

#initialise submitted_A0 
Grade_Book$submitted_A0 <- rep(FALSE,288)
#take 250 random indices from the 288 in 
random_indices <- sample(nrow(Grade_Book),250)
#change submittedA0 values to TRUE for rows with random_indices 
Grade_Book$submitted_A0[random_indices] <- TRUE
Grade_Book$submitted_A1 <- Grade_Book$submitted_A0
#add 25 students that submitted A1
false_indices <- which(!Grade_Book$submitted_A1)
twentyfive_false_indices <- sample(false_indices,25)
#change random 25 students with false A1 to true 
Grade_Book$submitted_A1[twentyfive_false_indices] <- TRUE
#repeat for A2
Grade_Book$submitted_A2 <- Grade_Book$submitted_A0 
false_indices <- which(!Grade_Book$submitted_A2) 
twentyfive_false_indices <- sample(false_indices,25) 
Grade_Book$submitted_A2[twentyfive_false_indices] <- TRUE #plot first few lines
first_five_students <- head(Grade_Book,5)

#initialise Q1_Score, set all to -1 
Grade_Book$Q1_Score <- rep(-1,length.out = 288)
#Add Q1 scores to those who submitted A0
Participated_In_A0_indices <- which(Grade_Book$submitted_A0) 
Q1_Scores_For_Participated <- rbeta(length(Participated_In_A0_indices),4,2) 
Grade_Book$Q1_Score[Participated_In_A0_indices] <- Q1_Scores_For_Participated
#Add Q1 scores to those who did not submit A0
Not_Participated_In_A0_indices <- which(!Grade_Book$submitted_A0) 
Q1_Scores_For_Not_Participated <- rbeta(length(Not_Participated_In_A0_indices),2,2) 
Grade_Book$Q1_Score[Not_Participated_In_A0_indices] <- Q1_Scores_For_Not_Participated
#plot histogram for Q1 scores of the cohort
hist(Grade_Book$Q1_Score, main = "Histogram of Q1 Scores", xlab = "Q1 Scores", ylab = "Frequency")

#Extract Q1 scores from students who did submit A0 and students who did not submit A0 
Q1_scores_did_not_submit_A0 <- Grade_Book$Q1_Score[Grade_Book$submitted_A0 ==FALSE]
Q1_scores_did_submit_A0 <- Grade_Book$Q1_Score[Grade_Book$submitted_A0 == TRUE]
#plot box plot for the Q1 scores of students who did not submit A0 and students who did submit A0
Q1_scores <- data.frame(Group = rep(c("Did Not Submit A0","Did Submit A0")), Value = c(Q1_scores_did_not_submit_A0,Q1_scores_did_submit_A0)) 
ggplot(Q1_scores,aes(x=Group,y=Value))+geom_boxplot()+labs(title = "Q1 Scores For Those Who Did And Did Not Submit A0",x = "Submit/Did Not Submit A0",y = "Q1 Score")

