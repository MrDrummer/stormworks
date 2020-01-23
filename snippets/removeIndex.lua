myTable = {}
table.insert(myTable, "index1")
table.insert(myTable, "index2")
table.insert(myTable, "index3")
table.insert(myTable, "index4")
table.insert(myTable, "index5")

print(table.unpack(myTable))

table.remove(myTable, 1)

print(table.unpack(myTable))