import re
f =open("homolog.txt","r")
m = f.readlines()
f.close()
a={}
for line in m:
	line_ = line.strip("\n").split("\t")
	b = re.sub(r'(-[\d]+)','',line_[0]).replace("t","g")	
	a[b] = []
for line in m:

	line_=line.strip("\n").split("\t")
	b= re.sub(r'(-[\d]+)','',line_[1]).replace("t","g")
#	print(b)
	c = re.sub(r'(-[\d]+)','',line_[0]).replace("t","g")
#	print(c)
	if (b not in a[c]):

		a[c].append(b)
f = open("homolog_summary.txt","w")
num = 0

for key in a.keys():
	if (num <5):
#		print(a[key])
		num = num +1
for key in a.keys():
	f.write(key + "\t" +  str(a[key])+ "\t" + str(len(a[key])) +  "\n" )
f.close()

