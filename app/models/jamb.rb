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
