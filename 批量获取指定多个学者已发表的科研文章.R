# 这里用冈山大学马建锋教授作为寻找的对象
install.packages("rscopus")
install.packages("readxl")
library(rscopus)
library(readxl)
name = read_excel("C:/Users/user/Desktop/name.xlsx")
colnames(name)=c("ln","fn")
auid <- data.frame(auth_name=character(0),au_id=character(0),affid=character(0),affil_name=character(0))
for (i in 1:nrow(name)){
  lastname=name[i,1]
  firstname=name[i,2]
  au = get_author_info(last_name = lastname, first_name = firstname,api_key ="15a5b4a8fc85b9776697a2daa1e121f2") 
  #api_key需自行申请
  id = subset(au,affid=="60023147")
  auid = rbind(auid,id)
}
test<-author_df(au_id = 35198554200,api_key = "15a5b4a8fc85b9776697a2daa1e121f2")
paperid <- data.frame(a=character(0),b=character(0),c=character(0),d=character(0),e=character(0),f=character(0),g=character(0),h=character(0),j=character(0),k=character(0),l=character(0),m=character(0))
colnames(paperid)<-colnames(test$df)
pauid <- as.numeric(auid$au_id)
for (i in 1:nrow(auid)){
  paper<-author_df(au_id = pauid[i],api_key = "15a5b4a8fc85b9776697a2daa1e121f2")
  paperid = rbind(paperid, paper)
}
mergepaper<-merge(auid,paperid,by="au_id")
write.csv(mergepaper, file="targetpap.csv")
