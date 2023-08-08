# ADS: Capstone

This project is a part of the ADS-599 course in the Applied Data Science Program at the University of San Diego. 

## Project Status: [Completed]

## Installation
You should add an instruction how this project to be used, installed, run, edited in others’ machine.
  
## Project Intro/Objective
Mining is and has been thought to be one of the more dangerous professions, with a high fatality and accident rate. The main goal of this study is to help MSHA (Mine Safety and Health Administration) determine if a mining violation is significant or substantial, meaning that an accident occurs after a violation has been cited. To do this, various classification models, including logistic regression, random forest, naïve bayes, gradient boosting machine (GBM), and support vector machine (SVM) are trained and tuned. The output is the probability of a future accident occurring 30 days, 60 days, and 90 days after a violation has been given. We found that the logistic regression and naïve bayes models performed best for the 30 day models in terms of accuracy and recall. In conclusion, our models did well in determining if a MSHA violation will result in an accident and can potentially be used to help MSHA investigators make more timely and accurate decisions in determining if a violation will be significant or substantial to a mine. 

## Partner(s)/Contributor(s)  
• Halle Davis
•	Claire Phibbs 
•	Summer Purschke

## Methods Used
•	Data Mining 
•	Predictive Modeling 
•	Machine Learning
•	Data Visualization
•	Programming 

## Technologies
•	Python

## Project Description
The data utilized for this project was obtained from the MSHA website. The team is primarily leveraging the Violations and Accidents datasets provided in MSHA’s Mine Data Retrieval System; both of which are available to download in .txt format.

Before starting the modeling process, a sample of 100,000 is made from the cleaned and engineered dataset. This decision was made due to the large size of the dataset and to decrease the time and resources needed to train our models. Each version of the dataset (30 day, 60 day, and 90 day) are then partitioned into training and testing sets, with a 70/30 split. Then the team will find the best classification model for the use case based on which model results in the highest level of recall. Recall was selected due to the importance of finding all positive cases – i.e., cases where a violation will lead to an accident – and the nonsignificance of a false positive. Grid search and k-fold cross validation methods will also be used to optimize the classification models. All of the models are cross validated with five folds and are scored with accuracy. The best hyperparameter values from the grid search and k-fold cross validation are then used to train the models and test the models to assess model performance in terms of recall. The use of grid search in conjunction with k-fold cross validation allows for a systematic exploration of various combinations of hyperparameters, finding the best fitting model while also minimizing the occurrence of overfitting. 

