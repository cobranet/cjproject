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
                [8,[1,2,3,4,5,6]],
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
    @cells[row,col] = 1
  end         
  def set_cell_value(row,col,value)
    if cell(row,col).type == :NORMAL
      raise RuntimeError unless @cells[row][col].empty? == true 
    end
    @cells[row][col].value = value
    @enabled = false
    observed_by(row).each do |observer_row|
      puts "row #{observer_row} col #{col} #{cell(observer_row,col).to_s}   "
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
  def initialize
    @cells = Array.new
    (0...rownum).each do |row|
      @cells[row] = Array.new
      columns do  |col|
        if col != 0
          @cells[row][col] = Cell.new(@@ROW_TYPES[row]) 
        else
          @cells[row][col] = Cell.new(:LABEL)
        end  
      end 
    end
  end


end
