class Cell
  
  attr_reader :type
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
      puts "We are in runtime error"
      raise RuntimeError
    end
  end
  
end
