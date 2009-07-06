class Mysql
  #TODO: *rows instead
  def insert(row, &block)
    DB.query(yield(row.escaped))
    true
  rescue
    false
  end
end
