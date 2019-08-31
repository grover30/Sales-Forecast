# SALES FORECAST using ARIMA and PROPHET models
## Introduction
The objective of my project is to predict three months sales values for different stores for the year 2018 that is for the months of January, February and March, given the day to day data from 2013 to 2017 for 10 stores each selling 50 identical item`s.

## Seasonality and Additional Regressors
Seasonality is estimated using partial Fourier sum which can approximate an arbitrary periodic signal. The no of terms in the partial sum (the order) is a parameter that determines how quickly the seasonality can change. Additional regressors can be added to the linear part of the model using the add_regressor method or function

## Effects of holidays
If you have holidays or other recurring events that you’d like to model, you must create a data frame for them. It has two columns (holiday and ds) and a row for each occurrence of the holiday. It must include all occurrences of the holiday, both in the past (back as far as the historical data go) and in the future (out as far as the forecast is being made). If they won’t repeat in the future, Prophet will model them and then not include them in the forecast. 

## Data Pre-processing and Visualization
The relevant parameters for checking data quality are:
1. Accuracy (no typos or junk values)  
2. Completeness (no missing vales or truncation) imputed missing values using k- nearest neighbours 
3. Consistency (no contradiction)
4. Validity (allowable values)

From the analysis I found all the attributes in the data followed all the above data quality measures making it fit for analysis. Also we found that we cannot remove the outliers because they are mostly due to holidays and holidays improved the fit of the model. I visualized the data based on stores, items and time series analysis on daily weekly monthly and yearly basis and trend in the sales values with the years. I found that the train data followed Positively Skewed Distribution for sales, followed same distribution for different stores, different items and for different years.

## Time series trends
Daily: Sales is fluctuating in the day time and starts rising in the evening and through the night.
Weekly: The sales were highest on Sundays and drop to lowest on Mondays and then increases steadily through the week.
Monthly: The sales were low in the starting month of the year and then rises from February and steadily increasing and reaching maximum in July and then decreases till October and remains almost constant in November and rises sharply in December due to festive occasions like Christmas and New Year.
Yearly: There is a steady increase in sales with year.
 
## Model used:
At its core, the Prophet Procedure is an additive regression model with four main components: A piecewise linear or logistic growth curve trend. Prophet automatically detects changes in trends by selecting change points from the data.

# Interpreting the Results
I see the model has improved a lot after optimising the prophet parameters and including holidays, seasonality and additional regressors in the data. The trend is NOT much fluctuating like the baseline models and there is NO CHANGE POINTS of sales as well after fitting a better model. The model is NOT much over fitting as well. We can conclude that Holidays has an effect on Sales and we have taken care of it in our optimised models. We can see there is a Drop of Sales from Sunday to Monday. Therefore there must be holiday effect on our sales data. There is peak in sales in July that means those may the festive times or seasonal sales with high discount prices.
I used Prophet Model and ARIMA model for predicting the sales values and used SMAPE to judge the accuracy of these models.

# Prophet model: SMAPE= 20.2% AND ARIMA model: SMAPE=25.5% 
So Prophet Model had better accuracy, the reason could be inclusion of holidays and better prediction of seasonality with prophet model. Holidays and seasonality explained the shocks in sales values therefore further optimisation on these factors can improve the accuracy of the model.
