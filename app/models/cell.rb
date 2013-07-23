class Cell
  
  attr_reader :type
  attr_accessor :value
  def initialize(type,is_col=false)
    @type = type
    @value = nil
    @enabled = false
    @is_col = is_col  
  end
 
  def is_enabled?
    @enabled
  end

  def enable
    if [:LABEL, :CALC].include?(@type)
      raise RuntimeError
    end
    @enabled = true
  end
  
  def disable
    @enabled = false
  end
  def empty?
    @value == nil
  end
  
  def class_str
    str = "b#{@type.to_s.downcase}"
    if empty? 
      str = str + " bempty" 
    end
    if is_enabled? 
       str  = str + " benabled" 
    end      
    if @is_col
      str = str + " bcolcalc"
    end
    str
  end  

  def to_s
    "cell type #{@type}  @value #{@value} @enabled #{@enabled}"
  end
end
