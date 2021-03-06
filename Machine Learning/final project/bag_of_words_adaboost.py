import pandas as pd
from bs4 import BeautifulSoup
import re
from nltk.corpus import stopwords
import nltk
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.ensemble import AdaBoostClassifier
from sklearn.model_selection import GridSearchCV
from sklearn.metrics import make_scorer, roc_auc_score
import time

start = time.time()
nltk.download('stopwords')
###################     reading data    ###################
train = pd.read_csv("labeledTrainData.tsv", header=0, delimiter="\t", quoting=3)
test = pd.read_csv("testData.tsv", header=0, delimiter="\t", quoting=3)
###################     cleaning train data    ###################
train['review'] = [BeautifulSoup(text, 'html.parser').get_text() for text in train['review']]  # remove html markups
train['review'] = [re.sub("[^a-zA-Z]", " ", text) for text in
                   train['review']]  # delete non-word characters and replace it with " "
train['review'] = [text.lower() for text in train['review']]  # convert to lower case
train['review'] = [text.split() for text in train['review']]  # split into words
stpw = set(stopwords.words("english"))  # convert stopwords to set for more speed
n = train.shape[0]
train['review'] = [[w for w in train['review'][i] if w not in stpw] for i in range(n)]  # removing stopwords
train['review'] = [" ".join(words) for words in train['review']]  # joins the words back into one paragraph
###################     bag of words(train data)    ###################
vectorizer = CountVectorizer(analyzer="word", tokenizer=None, preprocessor=None, stop_words=None, max_features=5000)
train_data_features = vectorizer.fit_transform(train['review'])  #
train_data_features = train_data_features.toarray()  # numpy arrays are easier to work with
###################     cleaning test data    ###################
test['review'] = [BeautifulSoup(text, 'html.parser').get_text() for text in test['review']]  # remove html markups
test['review'] = [re.sub("[^a-zA-Z]", " ", text) for text in
                  test['review']]  # delete non-word characters and replace it with " "
test['review'] = [text.lower() for text in test['review']]  # convert to lower case
test['review'] = [text.split() for text in test['review']]  # split into words
stpw = set(stopwords.words("english"))  # convert stopwords to set for more speed
n = test.shape[0]
test['review'] = [[w for w in test['review'][i] if w not in stpw] for i in range(n)]  # removing stopwords
test['review'] = [" ".join(words) for words in test['review']]  # joins the words back into one paragraph
###################     bag of words(test data)    ###################
test_data_features = vectorizer.transform(test['review'])  #
test_data_features = test_data_features.toarray()  # numpy arrays are easier to work with
###################     AdaBoost    ###################
ab_clf = AdaBoostClassifier()
parameters_ab = {'n_estimators': [40,55,70], 'learning_rate': [0.3, 0.5, 1]}
grid_ab = GridSearchCV(ab_clf, parameters_ab, scoring=make_scorer(roc_auc_score), cv=5)
grid_ab.fit(train_data_features, train['sentiment'])
ab_clf = grid_ab.best_estimator_
ab_clf.fit(train_data_features, train['sentiment'])
###################     predict test data by AdaBoost model and save it in a file    ###################
pred_ab = ab_clf.predict(test_data_features)
output = pd.DataFrame(data={"id": test["id"], "sentiment": pred_ab})
output.to_csv("Bag_of_Words_Ada_Boost.csv", index=False, quoting=3)
################################
end = time.time()
print(end - start)#7816.232901096344 (130 minutes)
