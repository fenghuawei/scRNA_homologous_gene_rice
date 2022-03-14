import ast
f = open("homolog_cluster_expr.txt","r")
m = f.readlines()
f.close()
db = []
f = open("homolog_cluster_expr_unique.txt","w")
for line in m:
	line_1 = line.strip("/n").split("\t")
	a = line_1[0]
	b = ast.literal_eval(line_1[1])
	c = line_1[2]

	if (a not in db) and (int(c) >=2):
		f.write(line)
		for key in b:

			db.append(key)

print(db)



