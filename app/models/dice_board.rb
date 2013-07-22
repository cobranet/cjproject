class DiceBoard
  def initialize (num)
    @dices = Arrey
    @selected = Array
    (0...num).each do |i|
      @dices[i] = null
      @selected[i] = false
    end  
  end
  
  def select(num)
    @selected[i] = true
  end

  def roll(num)
    @dices[num] = 1 + rand(6)
  end
  
  def roll_selected
    @selected.each_with_index do |sel,i|
      roll(i) unless sel == false
    end
  end
end 

    
