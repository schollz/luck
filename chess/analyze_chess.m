a = importdata('analyze_chess.txt');

start = min(a(:,1));
rangeN = min(a(:,1)):max(a(:,1))+1;
dataW = zeros(size(rangeN));
dataN = zeros(size(rangeN));
for i=1:size(a,1)
    dataN(a(i,1)-start+1) = dataN(a(i,1)-start+1) + 1;
    dataW(a(i,1)-start+1) = dataW(a(i,1)-start+1) + a(i,2);
end

plot(rangeN,dataW./dataN)
title('Chess')
ylabel('Probability of winning')
xlabel('Difference in Elo score')

d = dataW./dataN;
time = rangeN(~isnan(d));
conc = d(~isnan(d));
modelFun =  @(p,x) 1-1 ./ (1 + 10.^(x./p(1))) + p(2)
startingVals = [400,0.02];
coefEsts = nlinfit(time, conc, modelFun, startingVals);
xgrid = time;
plot(time,conc)
line(xgrid, modelFun(coefEsts, xgrid), 'Color','r');