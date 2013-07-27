class DiceBoard
  def initialize (num)
    @num = num
    clear
  end
  
  def select(num)
    @selected[i] = true
  end
   
  def mode  
    @mode
  end  
  
  def clear 
    @dices = Array.new
    @selected = Array.new
    (0...@num).each do |i|
      @dices[i] = nil
      @selected[i] = false
    end
    @mode = :no_roll
  end
    
  def roll(num)
    @dices[num] = 1 + rand(6)
    if @mode == :no_roll
      @mode = :first_roll
    else
      @mode = :end
    end 
  end
  
  def roll_selected
    @selected.each_with_index do |sel,i|
      roll(i) unless sel == false
    end
  end
end 

    
