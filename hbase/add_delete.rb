import 'org.apache.hadoop.hbase.client.Delete'

def jbytes(*args)
    args.map {|arg| arg.to_s.to_java_bytes}
end

table = ConnectionFactory.createConnection.getTable(TableName.valueOf(*jbytes("wiki")))
d = Delete.new(*jbytes("Home"))
d.addColumn(*jbytes("revisions", "author"))
table.delete(d)


import 'org.apache.hadoop.hbase.client.Put'


def jbytes(*args)
    args.map {|arg| arg.to_s.to_java_bytes}
end

table = ConnectionFactory.createConnection.getTable(TableName.valueOf(*jbytes( "wiki")))

p = Put.new(*jbytes("Home"))
p.addColumn(*jbytes("text", "", "Hello world"))
p.addColumn(*jbytes("revisions", "author", "jimbo"))
p.addColumn(*jbytes("revisions", "comment", "my first edit"))

table.put(p)