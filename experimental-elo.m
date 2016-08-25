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
x = rangeN;
y = dataW./dataN;
x = x(find(y~=0));
y = y(find(y~=0));
plot(x,y)
title('Chess (starting as white)')
ylabel('Probability of winning')
xlabel('Difference in Elo score')

d = dataW./dataN;
time = rangeN(~isnan(d));
conc = d(~isnan(d));
conc = conc(find(time > -300 & time < 300));
time = time(find(time > -300 & time < 300));
modelFun =  @(p,x) 1-1 ./ (1 + 10.^(x./p(1))) + p(2)
startingVals = [400,0.02];
coefEsts = nlinfit(time, conc, modelFun, startingVals);
xgrid = -600:600;
line(xgrid, modelFun(coefEsts, xgrid), 'Color','r');
axis([-600 600 0 1])



luck = 0.2;
rankingDifferences = rangeN;
meanScores = zeros(length(rankingDifferences),1);
for i=1:length(rangeN)
    tempScores = [];
    for j=1:dataN(i)
        elo = 1 / ( 1 + 10^((-rankingDifferences(i))/400) ) + coefEsts(2);
        % Add luck
        elo = elo + luck*randn;
        if elo > 1
            elo = 1;
        elseif elo < 0
            elo = 0;
        end
        tempScores = [tempScores; elo];
    end
    if length(tempScores)>1
        meanScores(i) = mean(tempScores);
    end
end

hold on;
rankingDifferences = rankingDifferences(find(meanScores~=0))
meanScores = meanScores(find(meanScores~=0))
plot(rankingDifferences,meanScores,'g')
axis([-600 600 0 1])
hold off;

legend('Data',sprintf('Model fit, b=%2.0f, +%2.2f',coefEsts(1),coefEsts(2)),sprintf('Simulation luck=%2.2f',luck),'location','NorthWest')







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
x = rangeN;
y = dataW./dataN;
x = x(find(y~=0));
y = y(find(y~=0));
plot(x,y)
title('NBA')
ylabel('Probability of winning')
xlabel('Difference in Elo score')

d = dataW./dataN;
time = rangeN(~isnan(d));
conc = d(~isnan(d));
conc = conc(find(time > -300 & time < 300));
time = time(find(time > -300 & time < 300));
modelFun =  @(p,x) 1-1 ./ (1 + 10.^(x./p(1))) + p(2)
startingVals = [400,0.02];
coefEsts = nlinfit(time, conc, modelFun, startingVals);
xgrid = -600:600;
line(xgrid, modelFun(coefEsts, xgrid), 'Color','r');
axis([-600 600 0 1])
coefEsts


luck = 0.3;
rankingDifferences = rangeN;
meanScores = zeros(length(rankingDifferences),1);
for i=1:length(rangeN)
    tempScores = [];
    for j=1:dataN(i)
        elo = 1 / ( 1 + 10^((-rankingDifferences(i))/400) ) + coefEsts(2);
        % Add luck
        elo = elo + randn*luck;
        if elo > 1
            elo = 1;
        elseif elo < 0
            elo = 0;
        end
        tempScores = [tempScores; elo];
    end
    if length(tempScores)>1
        meanScores(i) = mean(tempScores);
    end
end

hold on;
rankingDifferences = rankingDifferences(find(meanScores~=0))
meanScores = meanScores(find(meanScores~=0))
plot(rankingDifferences,meanScores,'g')
axis([-600 600 0 1])
hold off;


legend('Data',sprintf('Model fit, b=%2.0f, +%2.2f',coefEsts(1),coefEsts(2)),sprintf('Simulation luck=%2.2f',luck),'location','NorthWest')

