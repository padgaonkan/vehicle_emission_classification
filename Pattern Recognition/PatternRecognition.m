clear;
clc;
input = readtable('tr_input.csv');
output = readtable('tr_output.csv');
in = readtable('test_in.csv');
out = readtable('test_out.csv');
tr_input = table2array(input);
tr_output = table2array(output);
test_in = table2array(in);
test_out = table2array(out);

tr_input = tr_input';
tr_output = tr_output';
test_in = test_in';
test_out = test_out';

net = patternnet(10);
net = train(net,tr_input,tr_output);
pred_output = net(tr_input);
pred_out = net(test_in);

figure(1); 
plotconfusion(tr_output,pred_output);
figure(2);
plotconfusion(test_out,pred_out);