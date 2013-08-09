class DiceBoard
  attr_accessor :dices, :mode,:selected,:changed
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

  def is_equal?(other)
    @dices == other.dices && @mode == other.mode && @selected == other.selected
  end  

  def clear 
    @dices = Array.new
    @selected = Array.new
    @changed = [0,1,2,3,4]
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

  def change_mode
    if @mode == :no_roll
      @mode = :first_roll
    elsif @mode == :first_roll
      @mode = :second_roll
    else
      @mode = :end
    end
  end

  def roll_all 
    @changed = [0,1,2,3,4]
    (0...@num).each do |i|
      roll(i)
    end
    change_mode     
  end   
  def set_changed_to_sel
    arr = Array.new
    @selected.each_with_index do |x,i|
      if x == true 
        arr << i 
      end   
    end
    @changed = arr  
  end


  def set_changed_to_unsel
    arr = Array.new
    @selected.each_with_index do |x,i|
      if x == false
        arr << i 
      end  
    end
    @changed = arr  
  end

  def roll_selected
    set_changed_to_sel
    if dices[0] == nil 
      roll_all
      return
    else
      @selected.each_with_index do |sel,i|
        roll(i) unless sel == false
      end
    end
    change_mode
  end
  def roll_unselected
    set_changed_to_unsel
    if dices[0] == nil 
      roll_all
      return
    else
      @selected.each_with_index do |sel,i|
        roll(i) unless sel == true
      end
    end
    change_mode
  end
  def to_str
    str = ""
    (0...@num).each do |i|
      @dices[i] == nil ? str = str + "0" + "&" : str = str + @dices[i].to_s + "&"
    end
    (0...@num).each do |i|
      @selected[i] ? str = str +  "1" + "&" : str = str + "0" + "&"
    end  
    str = str + @mode.to_s + "&"
    @changed.each do |i|
      str = str + i.to_s + "&"
    end 
    str
  end
  def from_str(str)
    @changed = []
    arr = str.split("&")
    (0...@num).each do |i|
      arr[i] == "0" ? @dices[i] = nil : @dices[i] = arr[i].to_i
    end
    (@num...2*@num).each do |i|
      arr[i] == "1" ? @selected[i-@num] = true : @selected[i-@num] = false
    end
    @mode = arr[2*@num].to_sym
    ((2*@num+1)..arr.length-1).each do |i|
      @changed << arr[i].to_i
    end
    self
  end
end 

    
