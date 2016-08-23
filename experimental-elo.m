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
title('Chess')
ylabel('Probability of winning')
xlabel('Difference in Elo score')

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