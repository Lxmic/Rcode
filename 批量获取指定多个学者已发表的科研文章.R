# 这里我用日本冈山大学马建锋教授为例，将其公开发表过的文章信息获取并写入Excel。
## 安装和载入需要的R包
install.packages("rscopus")
install.packages("readxl")
library(rscopus)
library(readxl)
## 读取xlsx中的内容，将列名称分别改为ln和fn
name = read_excel("C:/Users/user/Desktop/au_all_article/name.xlsx")
colnames(name)=c("ln","fn")
## 建立一个新的数据框，各字符串的长度为0
auid <- data.frame(auth_name=character(0),au_id=character(0),affid=character(0),affil_name=character(0))
## 循环获取作者的信息，get_author_info是一个获取作者信息的函数：通过作者的名字来获取，所以有时候会有同名同姓的人，还要手动选择的。
for (i in 1:nrow(name)){
  lastname=name[i,1]
  firstname=name[i,2]
  au = get_author_info(last_name = lastname, first_name = firstname,api_key ="15a*****************") 
  #api_key需自行申请，网址是：https://dev.elsevier.com/apikey/create，每个人我觉得应该有一个独一无二的key。
# 用subset函数，进行条件选择，这里的条件为机构的ID，在au变量中能够看到这个，这里我因为只有一个人，也没有用这个循环，其实应该用新的变量来进行替换，达到循环的效果
  id = subset(au,affid=="60024045")
  auid = rbind(auid,id)
}
## author_df是一个函数，通过au_id来获取作者发表的文章的信息
test<-author_df(au_id = 14056743000,api_key = "15a*********************")
## 创建新的变量，以数据框的形式来存储数据
paperid <- data.frame(a=character(0),b=character(0),c=character(0),d=character(0),e=character(0),f=character(0),g=character(0),h=character(0),j=character(0),k=character(0),l=character(0),m=character(0))
## 赋予列名称，并将字符型变量au_id转变成数值型变量pauid，然后再通过author_df函数来获取论文信息
colnames(paperid)<-colnames(test$df)
pauid <- as.numeric(auid$au_id)
for (i in 1:nrow(auid)){
  paper<-author_df(au_id = pauid[i],api_key = "15a*******************")
  paperid = rbind(paperid, paper)
}
## 最后合并变量，以CSV格式输出
mergepaper<-merge(auid,paperid,by="au_id")
write.csv(mergepaper, file="targetpap.csv")
