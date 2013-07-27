class DiceBoard
  attr_accessor :dices
  def initialize (num)
    @num = num
    clear
  end
  
  def select(num)
    @selected[num] = true
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

  def img(dice)
    if @dices[dice] == nil
      return 'blanklarge.gif'
    else
      return "die-#{dices[dice]}large.gif"
    end
  end

  def class_str(dice)
    if @dices[dice] != nil 
      str = "dice"
    else
      str = "no_dice"
    end
    if @selected[dice] == true
      str = str + " selected"
    end 
    str
  end
  
  def roll_selected
    @selected.each_with_index do |sel,i|
      roll(i) unless sel == false
    end
  end

end 

    
