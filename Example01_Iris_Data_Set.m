%Examples using Iris Data Set

load iris.dat
meas = iris(:,1:4);
species = iris(:,5);


X = meas;
Y = species;
Xnew = [min(X);mean(X);max(X)];
PDF = 'gaussian'; % There are 2 types of options: 'gaussian' and 'exponential'

mdl = NaiveBayes(PDF);
mdl = mdl.fit(X,Y)
Ypred = mdl.predict(X)

accuracy = accuracy_score(Ypred,Y)
