clear;
clc;
input = readtable("tr_input.csv");
output = readtable("tr_output.csv");
in = readtable("test_in.csv");
out = readtable("test_out.csv");

tr_input = table2array(input);
tr_output = table2array(output);
test_in = table2array(in);
test_out = table2array(out);

tr_input=tr_input';
tr_output=tr_output';
test_in=test_in';
test_out=test_out';

net = feedforwardnet(10);
net = train(net,tr_input,tr_output);

%Training Data prediction
a1=sim(net,tr_input);
y1=a1;
y1(y1<5.5)=5;
y1(y1>=5.5)=6;
figure(1);
cm_tr = confusionchart(tr_output,y1,'Title','Confusion Matrix for Training Data');
answer = 100*sum(y1==tr_output)/240;
fprintf('Percentage Correct Classification for Training Data   : %f%%\n', answer);
fprintf('Percentage Incorrect Classification for Training Data  : %f%%\n', (100-answer));

%Testing Data Prediction
a2=sim(net,test_in);
y2 = a2;
y2(y2<5.5)=5;
y2(y2>=5.5)=6;
figure(2);
cm_test = confusionchart(test_out,y2,'Title','Confusion Matrix for Testing Data');
answer1 = 100*sum(y2==test_out)/60;
fprintf('Percentage Correct Classification for Testing Data   : %f%%\n', answer1);
fprintf('Percentage Incorrect Classification for Testing Data  : %f%%\n', (100-answer1));

%Exporting data
tr_out = y1';
test_output = y2';
tr_pred_out = array2table(tr_out);
test_pred_out = array2table(test_output);
training_output = [output tr_pred_out];
testing_output = [out test_pred_out];
filename1 = 'training_pred_output.csv';
filename2 = 'testing_pred_output.csv';
writetable(training_output,filename1);
writetable(testing_output,filename2);