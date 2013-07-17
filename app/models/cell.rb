class Cell
  
  attr_reader :type
  attr_accessor :value
  
  def initialize(type)
    @type = type
    @value = nil
    @enabled = false
  end
 
  def is_enabled?
    @enabled
  end

  def enable
    if [:LABEL, :CALC].include?(@type)
      raise RuntimeError
    end
  end

  def empty?
    @valule == nil
  end
  
  def class_str
    str = "#{@type.to_s.downcase}"
    if empty? 
      str = str + " empty" 
    end
    if is_enabled? 
       str  = str + " enabled" 
    end      
    str
  end  

end
