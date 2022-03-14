import ast
def diff(m,n):
	tmp = [val for val in m if val in n]
	#print(tmp)
	return(tmp)
f =open("filter_0.01_Maker.txt","r")
f.readline()
m = f.readlines()
f.close()
marker  = {}
for line in m:
	line1 = line.strip("\n").split("\t")
	a = line1[5]
	marker[a] = []
for line in m:
	line1 = line.strip("\n").split("\t")
	a = line1[5]
	b = line1[6]
	marker[a].append(b)
#for key in marker.keys():
#	print(key +"\t" +  str(marker[key]) + "\n")


ref = {}

f = open("homolog_summary.txt","r")
m = f.readlines()
f.close()
for line in m:
	line1 = line.strip("\n").split("\t")
	a = line1[0]
	b = ast.literal_eval(line1[1])
	c = line1[2]
	ref[a] = b

f = open("homolog_cluster_expr.txt","w")
for key in marker.keys():
	print(key)
	for key_2 in marker[key]:

		if key_2 in ref.keys():
		#print(key)
			#print(ref[key_2])
			#print(marker[key])
		#	print(ref[key_2])
			int_sect =  diff(ref[key_2],marker[key])
			print(int_sect)
			f.write(key_2 + "\t" + str(int_sect) + "\t" + str(len(int_sect)) + "\t" + str(len(ref[key_2])) +"\t" + str(len(int_sect)/len(ref[key_2])) + "\n" )

	
f.close()



