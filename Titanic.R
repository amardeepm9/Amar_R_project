Tit<-read.csv("C:/Users/Anil/Desktop/titanic/train.csv", stringsAsFactors=FALSE)
Tit
str(Tit)
summary(Tit)

table(Tit$Survived)
#We see that in the training set, 342 passengers survived, while 549 died.
# How about a proportion? Well, we can send the output of one function into another. 
#So now give prop.table() the output of the table function as input:

prop.table(table(Tit$Survived))


#now we want to assume no one survived in the test data 
Test<-read.csv("C:/Users/Anil/Desktop/titanic/test.csv", stringsAsFactors=FALSE)


#Since there was no ‘Survived’ column in the dataframe,
# it will create one for us and repeat our ‘0’ prediction 418 times
#the number of rows we have. If this column already existed, it would overwrite it with the new values,
#so be careful! While not entirely necessary for this simple model,
# putting the prediction next to the existing data will help keep things in order later, so it’s a good habit to get into for more complicated predictions.

Test$Survived <- rep(0, 418)
str(Test)

submit <- data.frame(PassengerId = Test$PassengerId, Survived = Test$Survived)
submit
str(submit)
write.csv(submit, file = "C:/Users/Anil/Desktop/titanic/allperish.csv", row.names = FALSE)


#gender of the passengers
Tit<-read.csv("C:/Users/Anil/Desktop/titanic/train.csv")
table(Tit$Sex)
prop.table(table(Tit$Sex))
str(Tit$Sex)

#two-way comparison on the number of males and FEMALES that survived

prop.table(table(Tit$Sex, Tit$Survived))


#proportion of each sex that survived, as separate groups

prop.table(table(Tit$Sex, Tit$Survived),1)


#as we know majority of the female got saved at least 75% of them so we predict 
Test$Survived <- 0
Test$Survived[Test$Sex == 'female'] <- 1

Test$Survived == 1
submit <- data.frame(PassengerId = Test$PassengerId, Survived = Test$Survived)
submit
str(submit)

write.csv(submit, file = "C:/Users/Anil/Desktop/titanic/allperish.csv", row.names = FALSE)

#now digging the age variable
summary(Tit$Age)

#as we can see there are 177 NA's available in the data and the min age is .42 so we will create another variable Child 

Tit$child <- 0
Tit$child[Tit$Age < 18]<-1

summary(Tit)
aggregate(Survived ~ child + Sex, data=Tit, FUN=sum)
