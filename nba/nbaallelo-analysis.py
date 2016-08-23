firstLine = True
names = []
odd = True
with open('nbaallelo.csv','r') as f:
	for line in f:
		if firstLine:
			firstLine = False
			names = line.split(',')
			continue
		odd = not odd
		if odd:
			continue
		csv = line.split(',')
		# print(names[11],csv[11]) # elo_i
		# print(names[17],csv[17]) # opp_elo_i
		# print(names[20],csv[20]) # game_result
		elo_i = round(float(csv[11]))
		opp_elo_i = round(float(csv[17]))
		w = 0
		if csv[20]=='W':
			w = 1
		print(elo_i-opp_elo_i,w)



MATLAB CODE

# start = min(a(:,1));
# rangeN = min(a(:,1)):max(a(:,1))+1;
# dataW = zeros(size(rangeN));
# dataN = zeros(size(rangeN));
# for i=1:size(a,1)
#     dataN(a(i,1)-start+1) = dataN(a(i,1)-start+1) + 1;
#     dataW(a(i,1)-start+1) = dataW(a(i,1)-start+1) + a(i,2);
# end
