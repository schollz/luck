clc

lucks = [];
for luck=0:0.05:1
    actualRanking = randn(2500,1000,1)+100;
    actualRanking = randn(500,1)*300+800;
    eloRanking = ones(size(actualRanking))*800;
    N = length(actualRanking);
    K = 24;

    numTrials = 1000;
    kineticVariability = zeros(1,length(numTrials));
    startVariability = 0;

    for iterate=1:numTrials
        ordering = randperm(N);
        for i=1:2:N-1
            %disp(sprintf('%d vs %d',ordering(i),ordering(i+1)))
            expectedScore = 1 / ( 1 + 10^((eloRanking(i+1)-eloRanking(i))/400) );
            actualScore = 1 / ( 1 + 10^((actualRanking(i+1)-actualRanking(i))/400) );
            if rand < luck
                actualScore = rand;
                if actualScore > 1
                    actualScore = 1;
                elseif actualScore < 0
                    actualScore = 0;
                end
            end
            expectedScore2 = 1 / ( 1 + 10^((eloRanking(i)-eloRanking(i+1))/400) );
            actualScore2 = 1-actualScore;

            eloRanking(i) = eloRanking(i) + K * ( actualScore - expectedScore);    
            eloRanking(i+1) = eloRanking(i+1) + K * ( actualScore2 - expectedScore2);    
        end
        if iterate == 1
            startVariability = std(eloRanking);
        end
        kineticVariability(iterate) = std(eloRanking)/startVariability;
    end


%     kineticVariability = kineticVariability - mean(kineticVariability());
%     plot(kineticVariability)
%     std(kineticVariability(9000:10000))
%     hold on;
    lucks = [lucks; luck kineticVariability(end)];
end

figure(2)
plot(lucks(:,1),lucks(:,2))
hold on;

luck = 0.05
rankingDifferences = -1200:1200;
iterations = 100;
expectedScore = zeros(length(rankingDifferences)*length(iterations),1);
rankingDifference = zeros(length(rankingDifferences)*length(iterations),1);
it = 1;
for iterate=1:iterations
    for i = 1:length(rankingDifferences)
        expectedScore(it) = 1 / ( 1 + 10^((-rankingDifferences(i))/400) );
        if rand < 2
            expectedScore(it) = expectedScore(it) + luck*randn;
            if expectedScore(it) > 1
                expectedScore(it) = 1;
            elseif expectedScore(it) < 0
                expectedScore(it) = 0;
            end
        end
        rankingDifference(it) = rankingDifferences(i);
        it = it +1;
    end
end
plot(rankingDifference, expectedScore,'.')

grid = zeros(max(rankingDifferences + -min(rankingDifferences))+1,100+1);
for i=1:length(expectedScore)
    x=1+rankingDifference(i)-min(rankingDifferences);
    y=1+round(100*expectedScore(i));
    grid(x,y) = grid(x,y) +1;
end
imagesc(imrotate(grid(2:end-1,2:end-1),90))
ylabel('Probability of defeat')
xlabel('Difference in Elo ranking')




    


figure(3)
subplot(2,1,1)
hist(actualRanking)
title('Actual ranking')
axis([0 1500 0 150])
subplot(2,1,2)
hist(eloRanking)
title('Elo ranking')
axis([0 1500 0 150])


% plot(actualRanking,eloRanking,'o')
