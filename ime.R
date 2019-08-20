library(data.table)
library(DT)
library(timeSeries)
library(tidyverse)
library(reshape)
library(stringr)
library(doBy)
library(formattable)
library(gridExtra)

library(ggplot2)
library(plotly)
library(corrplot)
library(wesanderson)
library(RColorBrewer)
library(gridExtra)
library(zoo)

library(forecast)
library(prophet)
library(nnfor)

mydata<-read.csv(file.choose())
mydata
str(mydata)
mydata$date<-as.Date(mydata$date)
mydata$Year<-year(mydata$date)        
mydata$Month=as.yearmon(mydata$date)
str(mydata)
x
#forcasting for store 1 item1
train_final_store1_item1=subset(mydata,mydata$store==1 & mydata$item==1)
stats=data.frame(y=log1p(train_final_store1_item1$sales)
                 ,ds=train_final_store1_item1$date)
stats=aggregate(stats$y,by=list(stats$ds),FUN=sum)
colnames(stats)<- c("ds","y")
model_prophet = prophet::prophet(stats,daily.seasonality = TRUE)
summary(model_prophet)
future = make_future_dataframe(model_prophet, periods = 90)
forecast = predict(model_prophet, future)
forecast
prophet_plot_components(model_prophet, forecast)

#####
mydata$Year=NULL
mydata$Month=NULL
head(mydata)
mydata$sales=log1p(mydata$sales)
mydata<-as.data.table(mydata)
colnames(mydata)<- c("ds","store","item","y")
train_splitting<-split(mydata, by=c("store","item"),keep.by=FALSE)
class(train_splitting)
class(mydata)


#prediction function
prediction<-function(df)
{
  playoffs <- data_frame(
    holiday = 'playoff',
    ds = as.Date(c('2013-07-12', '2014-07-12', '2014-07-19',
                   '2014-07-02', '2015-07-11', '2016-07-17',
                   '2016-07-24', '2016-07-07','2016-07-24')),
    lower_window = 0,
    upper_window = 1
  )
  
  #######  I have inlcuded the Holiday Sales fofr Festive seasons like New Year & Christmas for different Years in Superbowls.
  superbowls <- data_frame(
    holiday = 'superbowl',
    ds = as.Date(c('2013-01-01', '2013-12-25', '2014-01-01', '2014-12-25','2015-01-01', '2015-12-25','2016-01-01', '2016-12-25',
                   '2017-01-01', '2017-12-25')),
    lower_window = 0,
    upper_window = 1
  )
  holidays <- bind_rows(playoffs, superbowls)
  
  
  
  
  model_prophet <- prophet()
  model_prophet <- add_seasonality(model_prophet, name='daily', period=60, fourier.order=5)
  model_prophet <- prophet(df, holidays = holidays,holidays.prior.scale = 0.5, yearly.seasonality = 4,
                           interval.width = 0.95,changepoint.prior.scale = 0.006,daily.seasonality = T)
  
  
  future = make_future_dataframe(model_prophet, periods = 90)
  forecast = predict(model_prophet, future)
  forecast_final<-  xts::last(forecast[, c("ds","yhat")],90)
  return(forecast_final)
  
}
prediction_final=as.data.frame(sapply(train_splitting[c(1,2)],prediction))

library(reshape)
dim(prediction_final)
md <- melt(prediction_final)
dim(md)
colnames(md)<-c("store","date","sales")
md$sales=expm1(md$sales)
head(md)
md
