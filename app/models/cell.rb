class Cell
  TYPES = [ :LABEL, :CALC, :NORMAL]  
  attr_reader :type
  attr_accessor :value
  def initialize(type,is_col=false)
    @type = type
    @value = nil
    @enabled = false
    @is_col = is_col
    @is_col ||= false
      
  end
  def is_col?
    @is_col
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
   
  def to_str
    ser = "#{TYPES.index(@type)}&#{@value}&"
    is_enabled? ? ser = ser + "1&" : ser = ser+"0&" 
    @is_col == true  ? ser = ser + "1" : ser + "0" 
  end
  
  def is_equal(cell)
    self.value == cell.value && self.is_col? == cell.is_col? && self.is_enabled? == cell.is_enabled? && self.type == cell.type
  end

  def from_str(str) 
    arr = str.split('&')
    @type = TYPES[arr[0].to_i]
    if arr[1] == ""
      @value = nil
    else
      @value = arr[1]
    end
    arr[2] == "1" ? @enabled = true : @enabled = false 
    arr[3] == "1" ? @is_col = true : @is_col = false 
    return self
  end 
  def to_s
    "cell type #{@type}  @value #{@value} @enabled #{@enabled}"
  end
end
