import json

players = {}
data = {}
with open("initial_ratings.csv","r") as f:
    for line in f:
        if "Player,Rating,KFactor,NumGames" in line:
            continue
        csv = line.split(',')
        players[csv[0]] = int(csv[1])

with open("primary_training_part1.csv","r") as f:
    for line in f:
        if "WhitePlayer" in line:
            continue
        csv = line.split(',')
        if csv[2] not in players or csv[3] not in players:
            continue
        Ra = players[csv[2]]
        Rb = players[csv[3]]
        outcome = float(csv[4])

        if Ra-Rb not in data:
            data[Ra-Rb] = []
        data[Ra-Rb].append(outcome)

        Sa = outcome
        Ea = 1.0 / (1.0 + 10.0**(float(Rb-Ra)/400.0))
        K = 15.0
        Rap = int(round(float(Ra) + K * (Sa - Ea)))
        players[csv[2]] = Rap

        Rb = players[csv[2]]
        Ra = players[csv[3]]
        outcome = 1.0-float(csv[4])
        Sa = outcome
        Ea = 1.0 / (1.0 + 10.0**(float(Rb-Ra)/400.0))
        K = 15.0
        Rap = int(round(float(Ra) + K * (Sa - Ea)))
        players[csv[3]] = Rap


with open("primary_training_part2.csv","r") as f:
    for line in f:
        if "WhitePlayer" in line:
            continue
        csv = line.split(',')
        if csv[2] not in players or csv[3] not in players:
            continue
        Ra = players[csv[2]]
        Rb = players[csv[3]]
        outcome = float(csv[4])

        if Ra-Rb not in data:
            data[Ra-Rb] = []
        data[Ra-Rb].append(outcome)

        Sa = outcome
        Ea = 1.0 / (1.0 + 10.0**(float(Rb-Ra)/400.0))
        K = 15.0
        Rap = int(round(float(Ra) + K * (Sa - Ea)))
        players[csv[2]] = Rap

        Rb = players[csv[2]]
        Ra = players[csv[3]]
        outcome = 1.0-float(csv[4])
        Sa = outcome
        Ea = 1.0 / (1.0 + 10.0**(float(Rb-Ra)/400.0))
        K = 15.0
        Rap = int(round(float(Ra) + K * (Sa - Ea)))
        players[csv[3]] = Rap


with open("primary_training_part3.csv","r") as f:
    for line in f:
        if "WhitePlayer" in line:
            continue
        csv = line.split(',')
        if csv[2] not in players or csv[3] not in players:
            continue
        Ra = players[csv[2]]
        Rb = players[csv[3]]
        outcome = float(csv[4])

        if Ra-Rb not in data:
            data[Ra-Rb] = []
        data[Ra-Rb].append(outcome)

        Sa = outcome
        Ea = 1.0 / (1.0 + 10.0**(float(Rb-Ra)/400.0))
        K = 15.0
        Rap = int(round(float(Ra) + K * (Sa - Ea)))
        players[csv[2]] = Rap

        Rb = players[csv[2]]
        Ra = players[csv[3]]
        outcome = 1.0-float(csv[4])
        Sa = outcome
        Ea = 1.0 / (1.0 + 10.0**(float(Rb-Ra)/400.0))
        K = 15.0
        Rap = int(round(float(Ra) + K * (Sa - Ea)))
        players[csv[3]] = Rap

for dat in data.keys():
    for da in data[dat]:
        print(dat,da)


