class Mysql
  class Result
    # Returns an array of arrays returned by fetch_row
    # Passing a block will act as map
    def arrays(&block)
      rows = []
      self.each do |row|
        rows << ((block) ? yield(row) : row)
      end
      rows
    end
    
    # Returns an array of hashes returned by fetch_hash
    # Passing a block will act as map
    def hashes(with_table=false, &block)
      rows = []
      self.each_hash(with_table) do |row|
        rows << ((block) ? yield(row) : row)
      end
      rows
    end
    
    # Returns an array of Mysql::Row
    # Passing a block will act as map
    def objects(with_table=false, &block)
      hashes(with_table) do |row|
        row = Row.convert(row, self.fetch_fields, with_table)
        (block) ? yield(row) : row
      end
    end
    alias all objects # Kind of like Sequel but not lazily queried like Sequel
    
    # Added because there is each and each_hash, it can be useful to just loop
    # once and get a Mysql::Row instance right away
    # Yields Mysql::Row
    def each_object(with_table=false)
      self.each_hash(with_table){|row| yield(Row.convert(row, self.fetch_fields, with_table)) }
    end
    
    def print_pretty_table(with_table=false, *columns)
      rows = objects(with_table)
      begin
        PrettyTable.print(rows, columns.empty? ? nil : columns)
      rescue => e
        rows.each{|row| p row }
      end
      nil
    end
    
    private
    def symbol_keys(hash)
      new_row = {}
      hash.each {|k, v| new_row[k.to_sym] = v }
      new_row
    end
    
  end
end
