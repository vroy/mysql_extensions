class Mysql
  # See also sequel/lib/sequel/adapters/mysql.rb
  # Mapping of type numbers to conversion procs
  MYSQL_TYPES = {}

  # Use only a single proc for each type to save on memory
  MYSQL_TYPE_PROCS = {
    [0, 246]  => lambda{|v| BigDecimal.new(v)},           # decimal
    [1, 2, 3, 8, 9, 13, 247, 248]  => lambda{|v| v.to_i}, # integer
    [4, 5]  => lambda{|v| v.to_f},                        # float
    [10, 14]  => lambda{|v| ::Date.parse(v)},             # date
    [7, 12] => lambda{|v| ::Time.parse(v)},               # datetime
    [11]  => lambda{|v| ::Time.parse(v)},                 # time
  }
  MYSQL_TYPE_PROCS.each do |k,v|
    k.each{|n| MYSQL_TYPES[n] = v}
  end
end
