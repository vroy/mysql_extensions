class Options < Hash
  def method_missing(m,*a)
    m = m.to_s
    
    if m =~ /=$/
      self[$`.to_s] = a[0]
      
    elsif a.empty?
      self[m] = Options.new if self[m].nil?
      return self[m]
     
    else
      raise NoMethodError, "#{m}"
    end
  end
end

O = Options.new
