class DiceBoard
  def initialize (num)
    @dices = Array.new
    @selected = Array.new
    (0...num).each do |i|
      @dices[i] = nil
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

    
