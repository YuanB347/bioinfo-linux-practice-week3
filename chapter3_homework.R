# chapter3_homework.R
# R语言第三章课后作业：基本数据管理
# 题目0：创建数据框
manager <- c(1, 2, 3, 4, 5)
date <- c("10/24/08", "10/28/08", "10/01/08", "10/12/08", "05/01/09")
country <- c("US", "US", "UK", "UK", "UK")
gender <- c("M", "F", "F", "M", "F")
age <- c(32, 45, 25, 39, 99)
q1 <- c(5, 3, 3, 3, 2)
q2 <- c(4, 5, 5, 3, 2)
q3 <- c(5, 2, 5, 4, 1)
q4 <- c(5, 5, 5, NA, 2)
q5 <- c(5, 5, 2, NA, 1)

leadership <- data.frame(manager, date, country, gender, age,
                         q1, q2, q3, q4, q5)
# 题目1
head(leadership)
str(leadership)
names(leadership)
# 题目2
leadership$total_score <- leadership$q1 + leadership$q2 + leadership$q3 +
  leadership$q4 + leadership$q5
# 题目3
leadership$mean_score <- rowMeans(leadership[, c("q1", "q2", "q3", "q4", "q5")],
                                  na.rm = TRUE)
# 题目4
leadership$age[leadership$age == 99] <- NA
# 题目5
leadership$agecat <- NA
leadership$agecat[leadership$age < 35] <- "Young"
leadership$agecat[leadership$age >= 35 & leadership$age <= 50] <- "Middle"
leadership$agecat[leadership$age > 50] <- "Senior"
# 题目6
leadership$date <- as.Date(leadership$date, format = "%m/%d/%y")
# 题目7
leadership$days_to_2009 <- as.numeric(leadership$date - as.Date("2009-01-01"))
# 题目8
leadership$gender <- factor(leadership$gender,
                            levels = c("M", "F"),
                            labels = c("Male", "Female"))
# 题目9
colSums(is.na(leadership))
# 题目10
leadership_complete <- na.omit(leadership)
# 题目11
leadership_age_order <- leadership[order(leadership$age), ]
# 题目12
leadership_score_order <- leadership[order(-leadership$mean_score), ]
# 题目13
leadership_under40 <- leadership[leadership$age < 40, ]
# 题目14
leadership_female_high <- leadership[leadership$gender == "Female" &
                                       leadership$mean_score > 4, ]
# 题目15
leadership_sub <- leadership[, c("manager", "country", "gender",
                                 "age", "total_score", "mean_score")]
# 题目16
names(leadership)[names(leadership) == "manager"] <- "managerID"
# 题目17
library(dplyr)

leadership_dplyr1 <- leadership %>%
  mutate(
    age = ifelse(age == 99, NA, age),
    mean_score = rowMeans(select(., q1, q2, q3, q4, q5), na.rm = TRUE)
  ) %>%
  filter(!is.na(age)) %>%
  select(manager, country, gender, age, mean_score)

leadership_dplyr1
# 题目18
leadership_dplyr2 <- leadership %>%
  mutate(
    total_score = q1 + q2 + q3 + q4 + q5,
    mean_score = rowMeans(select(., q1, q2, q3, q4, q5), na.rm = TRUE)
  ) %>%
  filter(mean_score >= 4) %>%
  select(manager, gender, age, total_score, mean_score) %>%
  arrange(desc(mean_score))

leadership_dplyr2
mean(leadership$q4, na.rm = TRUE)
# 题目19
# 这段代码的含义是：计算 leadership 数据框中 q4 这一列的平均值。
# 其中 na.rm = TRUE 的作用是“在计算平均值时删除缺失值 NA”。
# 如果不写 na.rm = TRUE，只要 q4 中存在 NA，计算结果就会返回 NA。
leadership$age >= 35 && leadership$age <= 50
# 题目20
# 这段代码不能正确用于向量化判断，因为 && 只比较向量的第一个元素，
# 不适合对整列数据进行逐元素判断。
# 正确写法应使用 &，它会对向量中的每个元素分别进行逻辑比较。

leadership$age >= 35 & leadership$age <= 50
# 题目21
write.csv(leadership_dplyr2, "chapter3_result.csv", row.names = FALSE)
