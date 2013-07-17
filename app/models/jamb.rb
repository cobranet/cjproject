class Jamb
  @@TYPES = [ :LABEL, :CALC, :NORMAL]
  @@ROW_LABELS = %w(X,1,2,3,4,5,6,Bon,SUM,Mx,Mn,DIF,K,F,P,J,SUM)
  @@COL_LABELS = %w(X,DOWN,UP,FREE)
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
    @@ROW_LABELS.length
  end   

  def colnum
    @@COL_LABELS.length
  end


  def initialize
    @cells = Array.new
    (1...rownum).each |row|
      @cells[row] = Array.new
      (1...colnum).each |col|
        @cells[row][col] = Cell.new(@@ROW_TYPES[row])
      end
    end
  end


end
