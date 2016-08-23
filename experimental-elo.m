a = importdata('chess/analyze_chess.txt');

start = min(a(:,1));
rangeN = min(a(:,1)):max(a(:,1))+1;
dataW = zeros(size(rangeN));
dataN = zeros(size(rangeN));
for i=1:size(a,1)
    dataN(a(i,1)-start+1) = dataN(a(i,1)-start+1) + 1;
    dataW(a(i,1)-start+1) = dataW(a(i,1)-start+1) + a(i,2);
end

subplot(2,1,1)
plot(rangeN,dataW./dataN)
title('Chess (starting as white)')
ylabel('Probability of winning')
xlabel('Difference in Elo score')

d = dataW./dataN;
time = rangeN(~isnan(d));
conc = d(~isnan(d));
modelFun =  @(p,x) 1-1 ./ (1 + 10.^(x./p(1))) + p(2)
startingVals = [400,0.02];
coefEsts = nlinfit(time, conc, modelFun, startingVals);
xgrid = time;
line(xgrid, modelFun(coefEsts, xgrid), 'Color','r');
axis([-600 600 0 1])


a = importdata('nba/nbaallelo-output.txt');

start = min(a(:,1));
rangeN = min(a(:,1)):max(a(:,1))+1;
dataW = zeros(size(rangeN));
dataN = zeros(size(rangeN));
for i=1:size(a,1)
    dataN(a(i,1)-start+1) = dataN(a(i,1)-start+1) + 1;
    dataW(a(i,1)-start+1) = dataW(a(i,1)-start+1) + a(i,2);
end

subplot(2,1,2)
plot(rangeN,dataW./dataN)
title('NBA')
ylabel('Probability of winning')
xlabel('Difference in Elo score')

d = dataW./dataN;
time = rangeN(~isnan(d));
conc = d(~isnan(d));
modelFun =  @(p,x) 1-1 ./ (1 + 10.^(x./p(1))) + p(2)
startingVals = [400,0.02];
coefEsts = nlinfit(time, conc, modelFun, startingVals);
xgrid = time;
line(xgrid, modelFun(coefEsts, xgrid), 'Color','r');
axis([-600 600 0 1])
