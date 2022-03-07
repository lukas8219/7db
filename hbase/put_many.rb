def to_byte(*args)
    args.map { |arg| arg.to_s.to_java_bytes }
end


def put_many(table_name, row, column_values)
    table = ConnectionFactory.createConnection.getTable(TableName.valueOf(table_name.to_s.to_java_bytes))
    puts 'Created Connection'

    put = org.apache.hadoop.hbase.client.Put.new(row.to_s.to_java_bytes)
    puts 'Created Put object'

    column_values.each do |k,v|
        col_array = k.to_s.split(':', 2)
        column = org.apache.hadoop.hbase.util.Bytes.toBytes(col_array[0])
        family = org.apache.hadoop.hbase.util.Bytes.toBytes(col_array[1])
        value = org.apache.hadoop.hbase.util.Bytes.toBytes(v)
        put.addColumn(column, family, value)
    end 
    puts 'Added all Column'

    table.put(put)
    puts 'Inserted into Table'
end

put_many 'wiki', 'Some Title', {
    "text:" => "Some article name",
    "revisions:author" => "Me",
    "revisions:comment" => "No comment" 
}