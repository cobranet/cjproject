class Jamb

  ROW_LABELS = %w(X 1 2 3 4 5 6 Bon SUM Mx Mn DIF K F P J SUM)
  COL_LABELS = %w(X DOWN UP FREE)
  ROW_TYPES = [ :LABEL,
                  :NORMAL,
                  :NORMAL,
                  :NORMAL,
                  :NORMAL,
                  :NORMAL,
                  :NORMAL,
                  :CALC,
                  :CALC,
                  :NORMAL,
                  :NORMAL,
                  :CALC,
                  :NORMAL,
                  :NORMAL,
                  :NORMAL,
                  :NORMAL,
                  :CALC]
  DEPENDS = [ [7,[1,2,3,4,5,6]],
                [8,[1,2,3,4,5,6,7]],
                [11,[1,9,10]],
                [16,[12,13,14,15]]
              ]
  attr_accessor :diceboard,:playround,:cells, :changed
  def depends_on(row)
    DEPENDS.each do |rule|
      if rule[0] == row
        return rule[1]
      end
    end
  end
  def cell_id(row,col)
    "#{row}a#{col}" 
  end
  def all_full(arr,col)
    full = true
    arr.each do |row|
      if cell(row,col).empty?
        full = false
      end
    end
    full
  end
  def observed_by(row)
    arr = Array.new
    DEPENDS.each do |rule|
      if rule[1].include?(row)
        arr << rule[0]
      end
    end
    arr
  end

  def columns
    (0...colnum).each do |col|
      yield col
    end
  end

  def rows
    (0...rownum).each do |row|
       yield row
    end
  end

  def cell(row,col)
    @cells[row][col]
  end
    
  def calc(row,col)
    if row == 7 
      if calc_sum(row,col) > 59 
        @cells[row][col].value = 30
      else
         @cells[row][col].value = 0
      end
    end
    if [8,16].include?(row)
      @cells[row][col].value = calc_sum(row,col)
    end
    if row == 11
      @cells[row][col].value = calc_dif(col)
    end
  end
  
  def calc_sum(row,col)
   sum = 0
   depends_on(row).each do |drow|
     sum = cell(drow,col).value + sum
   end
   sum 
  end
 
  def calc_dif(col)
    dep = cell(1,col).value * ( cell(9,col).value - cell(10,col).value)
  end
 
  def enable_next(row,col)
    return unless [1,2].include?(col)
    dif = row
    if col == 1
      smer = 1
    else
      smer = -1
    end
    while dif >  0 && dif < 16  do 
      dif = dif + smer
      if ROW_TYPES[dif] == :NORMAL
        cell(dif,col).enable
        @changed << [dif,col] 
        return
      end
    end   
  end
  def is_number?(str)
    true if Float(str) rescue false
  end
  def set_cell_value(row,col,value)
    if cell(row,col).type == :NORMAL
      if @cells[row][col].empty? == false
        raise RuntimeError 
      end  
    end
    @cells[row][col].value = value
    @cells[row][col].disable
    enable_next(row,col)
    observed_by(row).each do |observer_row|
      if all_full(depends_on(observer_row),col)
        calc(observer_row,col)
        @changed << [observer_row,col]
      end
    end
  end
  def rownum
    ROW_LABELS.size
  end

  def colnum
    COL_LABELS.size
  end

  def play(row,col)    
    @changed = [[row,col]]
    set_cell_value(row,col,calc_roll(row,@diceboard.dices))
    @diceboard.clear
    @empty = @empty - 1
    @playround = @playround + 1
    if @empty == 0 
      @diceboard.mode = :end_game
    end
  end  
  def test_game(game_id,user_id)
    jamb = Jamb.new
    game = Game.new
    game.id = game_id
    game.user_id = user_id
    game.from_jamb(jamb)
    game.save!
    (1..6).each do |row|
      [1,3].each do |col|
        jamb.diceboard.roll_all
        jamb.play(row,col)
      end
    end
    [15,14,13,12].each do|row|
      jamb.diceboard.roll_all
      [2,3].each do |col|
        jamb.play(row,col)
      end  
    end
    [9,10].each do |row| 
      jamb.diceboard.roll_all
      jamb.play(row,1)
      jamb.diceboard.roll_all
      jamb.play(row,3)
    end
    [10,9].each do |row| 
      jamb.diceboard.roll_all
      jamb.play(row,2)
    end
    [6,5,4,3,2,1].each do |row|
      jamb.diceboard.roll_all
      jamb.play(row,2)
    end
    game.from_jamb(jamb)
    game.save!
  end

  def cellxy(row,col)
    puts "Row #{row}- Col #{col}"
  end
 
  def calc_roll(row,dices)
    if [1,2,3,4,5,6].include?(row)
      sum = 0 
      dices.each do |dice|
        sum = sum + dice unless dice != row
      end
      return sum
    end
    if [9,10].include?(row)
      return dices.sum
    end
    if row == 12
      if dices.sort == [1,2,3,4,5] || dices.sort == [2,3,4,5,6]
        return 45
      end
      return 0
    end
    if row == 13 #FULL
      if distribution(dices) == [2,3] 
        return dices.sum + 30
      else
        return 0
      end
    end
    if row == 14 #POKER
      if distribution(dices) != [1,4] && distribution(dices) != [5]
        return 0
      else
        (1..6).each do |num|
          return num*4 +40 unless dices.select { |x| x==num }.count < 4 
        end  
      end  
    end
    if row == 15 #JAMB
      if distribution(dices) == [5]
        return 50 + 5*dices[0]
      else
        return 0
      end
    end
  end

  def distribution(dices)
    arr = Array.new
    (1..6).each do |num|
      if dices.select { |x| x  == num }.count > 0 
        arr << dices.select { |x| x == num }.count 
      end
    end
    arr.sort
  end

    
  def initialize
    @cells = Array.new
    @diceboard = DiceBoard.new(5)
    @empty = (6+2+4)*3
    @playround = 0
    @changed = Array.new 
    (0...rownum).each do |row|
      @cells[row] = Array.new
      columns do |col|
        if col != 0
          @cells[row][col] = Cell.new(ROW_TYPES[row])
          if row == 0 
           @cells[row][col].value = COL_LABELS[col]
          end
        else
          if [7,8,11,16].include?(row)
            calccol = true
          else
            calccol = false
          end
          @cells[row][col] = Cell.new(:LABEL,calccol)
          @cells[row][col].value = ROW_LABELS[row]
        end
        if col == 3 && [0,7,8,11,16].include?(row) == false 
          @cells[row][col].enable
        end  
      end
    end
    @cells[1][1].enable
    @cells[15][2].enable
  end

  def to_game_string
    str = ""
    rows do |row|
      columns do |col|
        str =  str+@cells[row][col].to_str + "#"
      end
    end

    str = str + @empty.to_s + "#"
    str = str + @playround.to_s + "#"    
    str = str + @diceboard.to_str
  end
  def end_game_score
    rows = [8,11,16]
    final = 0
    rows.each do |row|
      [1,2,3].each do |col|
        final = final + cell(row,col).value
      end
    end
    final
  end  
  def from_game_string(str)
    arr = str.split("#")
    rows do |row|
      columns do |col| 
        @cells[row][col].from_str( arr[row*colnum+col])
      end
    end          
    where = (rownum)*(colnum)+1 
    where = where + 1
    @empty = arr[where-2].to_i
    @playround = arr[where-1].to_i
    @diceboard = DiceBoard.new(5)
    @diceboard.from_str(arr[where])
    self
  end
end
