class Jamb
  @@TYPES = [ :LABEL, :CALC, :NORMAL]
  @@ROW_LABELS = %w(X 1 2 3 4 5 6 Bon SUM Mx Mn DIF K F P J SUM)
  @@COL_LABELS = %w(X DOWN UP FREE)
  @@ROW_TYPES = [ :LABEL,
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
  @@DEPENDS = [ [7,[1,2,3,4,5,6]],
                [8,[1,2,3,4,5,6,7]],
                [11,[1,9,10]],
                [16,[12,13,14,15]]
              ]

  def depends_on(row)
    @@DEPENDS.each do |rule|
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
    @@DEPENDS.each do |rule|
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
    if [7,8,16].include?(row)
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
    return unless [1,2].include?(row)
    if col == 1
      next_normal_row = @@ROW_TYPES.slice(row+1,100).find_index(:NORMAL)
    else
      next_normal_row = @@ROW_TYPES.slice(0,row).reverse.find_index(:NORMAL)
    end
    cell(next_normal_row+1+row,col).enable unless next_normal_row == nil
  end
 
  def set_cell_value(row,col,value)
    if cell(row,col).type == :NORMAL
      raise RuntimeError unless @cells[row][col].empty? == true
    end
    @cells[row][col].value = value
    @cells[row][col].disable
    enable_next(row,col)
    observed_by(row).each do |observer_row|
      if all_full(depends_on(observer_row),col)
        calc(observer_row,col)
      end
    end
  end
  def rownum
    @@ROW_LABELS.size
  end

  def colnum
    @@COL_LABELS.size
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
    @diceboard = DiceBoard.new(6)
    (0...rownum).each do |row|
      @cells[row] = Array.new
      columns do |col|
        if col != 0
          @cells[row][col] = Cell.new(@@ROW_TYPES[row])
          if row == 0 
           @cells[row][col].value = @@COL_LABELS[col]
          end
        else
          if [7,8,11,16].include?(row)
            calccol = true
          else
            calccol = false
          end
          @cells[row][col] = Cell.new(:LABEL,calccol)
          @cells[row][col].value = @@ROW_LABELS[row]
        end
        if col == 3 && [0,7,8,11,16].include?(row) == false 
          @cells[row][col].enable
        end  
      end
    end
    @cells[1][1].enable
    @cells[15][2].enable
  end

end
