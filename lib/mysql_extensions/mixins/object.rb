class Object
  def escape_single_quotes; self.to_s.e_s_q; end
  alias e_s_q escape_single_quotes
  
  def escape_double_quotes; self.to_s.e_d_q; end
  alias e_d_q escape_double_quotes
end
