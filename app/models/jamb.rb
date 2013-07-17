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
                 
  def rownum
    puts @@ROW_LABELS.inspect
    @@ROW_LABELS.size
  end   

  def colnum
    @@COL_LABELS.size
  end
  def initialize
    @cells = Array.new
    (1...rownum).each do |row|
      @cells[row] = Array.new
     end
  end


end
