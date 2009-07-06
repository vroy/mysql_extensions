class Mysql
  O.sql.logger.path ||= STDOUT
  O.sql.logger["enabled?"] ||= false
  O.sql.logger["log_explains?"] ||= false
  O.sql.logger["log_time?"] ||= false
  
  def log(string)
    if O.sql.logger.enabled?
      io = (O.sql.logger.path == STDOUT) ? STDOUT : File.open(O.sql.logger.path, "a")
      io.puts string
      io.close
    end
  end
  
  alias old_query query
  def query(string)
    id = ::Time.now.to_f
    log("#{id} - #{string}")
    
    start_time = ::Time.now
    res = old_query(string)
    end_time = ::Time.now
    
    log("#{DB.explain(string, id)}") if O.sql.logger.log_explains?
    
    log("#{id} - time: #{end_time-start_time}") if O.sql.logger.log_time?

    return res
  end
  
  def explain(string, id)
    rows = []
    DB.old_query("EXPLAIN #{string}").each_hash do |row|
      rows << row
    end
    PrettyTable.lines(rows).map do |line|
      "#{id} - #{line}"
    end.join("\n")
  end
end
