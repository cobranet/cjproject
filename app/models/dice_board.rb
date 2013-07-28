class DiceBoard
  attr_accessor :dices, :mode
  def initialize (num)
    @num = num
    clear
  end

  def toggle(num)
    if @selected[num] == true
      @selected[num] = false
    else
      @selected[num] = true
    end
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
     @selected[num] = false
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

  def roll_all 
    (0...@num).each do |i|
      roll(i)
    end
    if @mode == :no_roll
      @mode = :first_roll
    else
      @mode = :end
    end 
    
  end   

  def roll_selected
    if dices[0] == nil 
      roll_all
      return
    else
      @selected.each_with_index do |sel,i|
        roll(i) unless sel == false
      end
    end
    if @mode == :no_roll
      @mode = :first_roll
    else
      @mode = :end
    end 
  end

end 

    
