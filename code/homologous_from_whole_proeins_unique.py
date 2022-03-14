import ast
f = open("homolog_summary.txt","r")
m = f.readlines()
f.close()
db = []
f = open("homolog_unique.txt","w")
for line in m:
	line_1 = line.strip("/n").split("\t")
	a = line_1[0]
	b = ast.literal_eval(line_1[1])
	c = line_1[2]

	if (a not in db):
		f.write(line)
		for key in b:

			db.append(key)

print(db)



