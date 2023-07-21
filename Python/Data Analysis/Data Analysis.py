import pandas as pd
import numpy as np
import scipy.stats as stats

# READ FILE
print("\n","READ FILE".center(100, "="))
data = pd.read_csv("2_heart.csv")
df = pd.DataFrame(data)
print(df)

# OUTLIER
print("\n","OUTLIER".center(100, "="))
outliers = []
def detect_outlier(data):
    threshold = 3
    mean = np.mean(data)
    std = np.std(data)
    
    for y in data:
        z_score = (y-mean)/std
        if np.abs(z_score)>threshold:
            outliers.append(y)
    return outliers

outlier_datapoints_age = detect_outlier(df['age'])
print('Outlier age = ', outlier_datapoints_age)
outliers.clear()

outlier_datapoints_trestbps = detect_outlier(df['trestbps'])
print('Outlier trestbps = ', outlier_datapoints_trestbps)
outliers.clear()

outlier_datapoints_chol = detect_outlier(df['chol'])
print('Outlier chol = ', outlier_datapoints_chol)
outliers.clear()

outlier_datapoints_thalach = detect_outlier(df['thalach'])
print('Outlier thalach = ', outlier_datapoints_thalach)
outliers.clear()

outlier_datapoints_oldpeak = detect_outlier(df['oldpeak'])
print('Outlier oldpeak = ', outlier_datapoints_oldpeak,'\n\n')
outliers.clear()

# MISSING VALUE
print("\n","MISSING VALUE".center(100, "="))
print(df.isna().sum())

# HANDLING OUTLIERS
print("\n","HANDLING OUTLIERS".center(100, "="))
z_trestbps = np.abs(stats.zscore(df["trestbps"]))
#print("Z-Score of Trestbps".center(100, "="))
#print(z_trestbps)
threshold = 3
#print(np.where(z_trestbps > 3))
new_df = df[(z_trestbps < 3)]
#print(new_df)

z_chol = np.abs(stats.zscore(new_df["chol"]))
#print("Z-Score of Chol".center(100, "="))
#print(z_chol)
threshold = 3
#print(np.where(z_chol > 3))
new_df = new_df[(z_chol < 3)]
#print(new_df)

z_thalach = np.abs(stats.zscore(new_df["thalach"]))
#print("Z-Score of Thalach".center(100, "="))
#print(z_thalach)
threshold = 3
#print(np.where(z_thalach > 3))
new_df = new_df[(z_thalach < 3)]
#print(new_df)

z_oldpeak = np.abs(stats.zscore(new_df["oldpeak"]))
#print("Z-Score of Oldpeak".center(100, "="))
#print(z_oldpeak)
threshold = 3
#print(np.where(z_oldpeak > 3))
new_df = new_df[(z_oldpeak < 3)]
print(new_df)

# NORMALIZATION (MIN-MAX)
print("\n","MIN-MAX NORMALIZATION".center(100, "="))
from sklearn import preprocessing
min_max_scaler = preprocessing.MinMaxScaler()
np_scaled = min_max_scaler.fit_transform(new_df)
df_normalized = pd.DataFrame(np_scaled)
print(df_normalized)

# FEATURE
print("\n","FEATURE".center(100, "="))
X = df_normalized.iloc[:,0:12].values
print(X)
y = df_normalized.iloc[:,13].values
print(y)

# K-FOLD
print("\n","K-FOLD".center(100, "="))
from sklearn.model_selection import KFold
kf = KFold(n_splits = 10, shuffle = False)
print(kf)  
i = 1        
for train_index, test_index in kf.split(X):
    # print("TRAIN:", train_index, "TEST:", test_index)
    x_train = X[train_index]
    x_test = X[test_index]
    y_train = y[train_index]
    y_test = y[test_index]
    i+=1
print("shape x_train :", x_train.shape)
print("shape x_test :", x_test.shape)


# NAIVE BAYES
print("\n","NAIVE BAYES".center(100, "="))
from sklearn.naive_bayes import GaussianNB
from sklearn.metrics import accuracy_score ,precision_score, recall_score, f1_score
gaussian = GaussianNB()
gaussian.fit(x_train, y_train)
y_pred = gaussian.predict(x_test)
accuracy_nb = round(accuracy_score(y_test, y_pred) * 100, 2)
acc_gaussian = round(gaussian.score(x_train, y_train) * 100, 2)
print("instance prediksi naive bayes:")
print(y_pred)

# CONFUSION MATRIX
print("\n","CONFUSION MATRIX".center(100, "="))
from sklearn.metrics import confusion_matrix
cm = confusion_matrix(y_test, y_pred)
accuracy = accuracy_score(y_test,y_pred)
precision = precision_score(y_test, y_pred, average = 'micro')
recall = recall_score(y_test, y_pred, average = 'micro')
f1 = f1_score(y_test,y_pred, average = 'micro')
print('Confusion matrix for Naive Bayes\n', cm)
print('Accuracy Naive Bayes: %.3f' %accuracy)
print('Precision_Naive Bayes: %.3f' %precision)
print('Recall_Naive Bayes: %.3f' %recall)
print('F1 score Naive Bayes: %.3f' %f1)