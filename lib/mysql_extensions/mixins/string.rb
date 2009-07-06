class String
  # Used to insert values in the table
  def escape_single_quotes
    self.gsub(/[']/, '\\\\\'')
  end
  alias e_s_q escape_single_quotes
  
  def escape_double_quotes
    self.gsub(/["]/, '\\"')
  end
  alias e_d_q escape_double_quotes
  
  def to_comma; self.to_i.to_comma; end
end
