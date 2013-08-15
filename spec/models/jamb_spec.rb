require 'set'
describe Jamb do
  it "must be created" do
    j = Jamb.new
  end
  
  it "after created cells 1,1 and 15,2 must be enabled" do
    j = Jamb.new
    assert_equal j.cell(1,1).is_enabled?, true
    assert_equal j.cell(15,2).is_enabled?, true
  end

  it "must have rownum 16" do
    j = Jamb.new
    assert_equal j.rownum, 17
    assert_equal j.colnum, 4
  end

  it "row num 0 must have type :LABEL and be disabled" do
    j = Jamb.new
    j.columns do |col|
      assert_equal :LABEL, j.cell(0,col).type
      assert_equal false, j.cell(0,col).is_enabled?
    end
  end
  
  it "col num 0 must have type :LABEL and be disabled" do
    j = Jamb.new
    j.rows do |row|
      assert_equal :LABEL, j.cell(row,0).type
      assert_equal false, j.cell(row,0).is_enabled?
    end
  end
  
  it "rows from 1 to 6 and 9 and 10 must be normal if col <> 0 " do
    j = Jamb.new
    j.rows do |row|
      j.columns do |col|
        if [1,2,3,4,5,6,9,10].include?(row) && col != 0
          assert_equal :NORMAL, j.cell(row,col).type
        end
     end
    end
  end

  it "rows from 7, 8, 11 and 16  must be calc and disabled if col <> 0 " do
    j = Jamb.new
    j.rows do |row|
      j.columns do |col|
        if [7,8,11].include?(row) && col != 0
          assert_equal :CALC, j.cell(row,col).type
          assert_equal false, j.cell(row,col).is_enabled?
        end
     end
    end
  end

  it "if cell is :NORMAL and asigned by value must keep it" do
    j = Jamb.new
    j.set_cell_value(1,1,12)
    assert_equal 12, j.cell(1,1).value
  end
   
  it "if cell is not empty and somebody try to set value it must raise error" do
    j = Jamb.new
    j.set_cell_value(1,1,"B")
    expect {j.set_cell_value(1,1,"C")}.to raise_error(RuntimeError)
  end 

  it "if cell is not empty and somebody must be disabled" do
    j = Jamb.new
    j.set_cell_value(1,1,1)
    assert_equal j.cell(1,1).is_enabled?, false
  end 
  
  it "for calculated rows method depends_on must be array of rows on which that cell depends" do
    j = Jamb.new
    j.rows do |row|
      j.columns do |col|
        if j.cell(row,col).type == :CALC  
          assert_equal j.depends_on(row).class, Array
        end
      end
    end
  end 

  it "all rows on which row depends that call must be calculate if all cells are full" do
    j = Jamb.new
    j.columns do |col|
      if col != 0 
        (1..6).each do |row|
          j.set_cell_value(row,col,1)
         end
       assert_equal j.cell(7,col).empty?,  false  
      end
    end
  end
  
  it "observed by > for rows that are obsered by same calc rows observed_by must return array of that rows" do
    j = Jamb.new
      [2,3,4,5,6].each do |row|
        assert_equal j.observed_by(row), [7,8]
      end
      [1].each do |row|
        assert_equal j.observed_by(row), [7,8,11]
      end

      [9,10].each do |row|
        assert_equal j.observed_by(row), [11]
      end
      [12,13,14,15].each do |row|
        assert_equal j.observed_by(row), [16]
      end
  end
  
  it "calc_rowe must return 30 if sum of rows 1 to 6 is greater 59 " do
    j = Jamb.new
    j.set_cell_value(1,1,3)
    j.set_cell_value(2,1,6)
    j.set_cell_value(3,1,9)
    j.set_cell_value(4,1,12)
    j.set_cell_value(5,1,15)
    j.set_cell_value(6,1,18)
    assert_equal j.cell(7,1).value, 30
    j = Jamb.new
    j.set_cell_value(1,1,3)
    j.set_cell_value(2,1,6)
    j.set_cell_value(3,1,9)
    j.set_cell_value(4,1,12)
    j.set_cell_value(5,1,15)
    j.set_cell_value(6,1,0)
    assert_equal j.cell(7,1).value, 0
  end

  it "calc_sum metod calc sum of all rows on which dependes " do
    j = Jamb.new
    (1..6).each do |row|
      j.set_cell_value(row,1,3)
    end
    (12..15).each do |row|
      j.set_cell_value(row,2,10)
    end
    assert_equal j.calc_sum(7,1), 6*3
    assert_equal j.calc_sum(16,2), 4 * 10  
  end

  it "calc_dif metod is first row multyplay with diference of second and third" do
    j = Jamb.new
    j.set_cell_value(1,1,5)
    j.set_cell_value(9,1,30)
    j.set_cell_value(10,1,5)
    assert_equal j.calc_dif(1), 5*(30-5)
  end

  it "enable next cell in col 1   and 2" do
    j = Jamb.new
    assert_equal j.cell(2,1).is_enabled?, false
    j.enable_next(1,1)
    assert_equal j.cell(2,1).is_enabled?, true
    j.enable_next(3,1)
    assert_equal j.cell(4,1).is_enabled?, true
    
    assert_equal j.cell(13,2).is_enabled?, false
    j.enable_next(14,2)
    assert_equal j.cell(13,2).is_enabled?, true
    j.enable_next(13,2)
    assert_equal j.cell(12,2).is_enabled?, true
  end 

  it "set_cel_value must enable next cel if cols are 1 and 2" do
    j = Jamb.new
    assert_equal j.cell(2,1).is_enabled?, false
    j.set_cell_value(1,1,1)
    assert_equal j.cell(2,1).is_enabled?, true
    assert_equal j.cell(3,1).is_enabled?, false
    j.set_cell_value(2,1,2)
    assert_equal j.cell(3,1).is_enabled?, true
    j.set_cell_value(3,1,8)
    assert_equal j.cell(4,1).is_enabled?,true
    j.set_cell_value(15,2,80)
    assert_equal j.cell(14,2).is_enabled?,true
    j.set_cell_value(14,2,64)
    assert_equal j.cell(13,2).is_enabled?,true
  end

  it " with distibution must return sorted array of counts of diferent values of dices" do
    j = Jamb.new
    assert_equal [1,2,2], j.distribution([1,2,3,2,1])
    assert_equal [1,4], j.distribution([3,2,3,3,3])
    assert_equal [5], j.distribution([1,1,1,1,1])        
  end

  it "calc_roll return value for dices and row " do
    j = Jamb.new
    assert_equal 3, j.calc_roll(1,[1,1,1,4,5]) 
    assert_equal 4, j.calc_roll(2,[2,2,1,4,5]) 
    assert_equal 3, j.calc_roll(3,[3,1,1,4,5]) 
    assert_equal 20, j.calc_roll(4,[4,4,4,4,4]) 
    assert_equal 10, j.calc_roll(5,[5,1,1,4,5])  
    assert_equal 18, j.calc_roll(6,[6,6,1,6,5])
    assert_equal 23, j.calc_roll(9,[6,6,6,2,3])      
    assert_equal 7,  j.calc_roll(10,[2,2,1,1,1])
    assert_equal 45, j.calc_roll(12,[1,2,3,4,5])               
    assert_equal 0, j.calc_roll(12,[1,2,3,4,6])
    assert_equal 45, j.calc_roll(12,[6,2,3,4,5]) 
    assert_equal 58, j.calc_roll(13,[6,6,6,5,5]) 
    assert_equal 0, j.calc_roll(13,[6,6,6,4,5])                              
    assert_equal 64, j.calc_roll(14,[6,6,6,6,5]) 
    assert_equal 0, j.calc_roll(14,[6,5,6,6,5])
    assert_equal 64, j.calc_roll(14,[6,6,6,6,6])  
    assert_equal 80, j.calc_roll(15,[6,6,6,6,6])
    assert_equal 0, j.calc_roll(15,[6,6,6,6,5])  
   end

  it "if there is no empty cell than diceboard must go to end_game mode" do
    j = Jamb.new
    [1,2,3,4,5,6,9,10,12,13,14,15].each do |row|
      j.diceboard.roll_all
      j.play(row,1)
      j.diceboard.roll_all
      j.play(row,3)
    end
    assert_equal j.diceboard.mode == :end_game, false
    [1,2,3,4,5,6,9,10,12,13,14,15].reverse.each do |row|
      j.diceboard.roll_all
      j.play(row,2)
    end
    assert_equal j.diceboard.mode, :end_game
  end

  it "Must save cells state from to_game_string and from_game_string" do
    original = Jamb.new
    copy = Jamb.new
    #some plays done... 
    [1,2,3,4,5,6,9,10,12,13,14,15].each do |row|
      original.diceboard.roll_all
      original.play(row,1)
      original.diceboard.roll_all
      original.play(row,3)
    end
    #to sting
    str1 = original.to_game_string
    copy = copy.from_game_string(str1)
    original.rows do |row|
      original.columns do |col|
        assert_equal original.cell(row,col).value, copy.cell(row,col).value
        assert_equal original.cell(row,col).is_enabled?, copy.cell(row,col).is_enabled?
        assert_equal original.cell(row,col).type, copy.cell(row,col).type
        assert_equal original.cell(row,col).is_col?, copy.cell(row,col).is_col?
      end
    end

  end
   
  it "game must save diceboard too" do
    original = Jamb.new
    original.diceboard.roll_all
    copy = Jamb.new
    copy.from_game_string(original.to_game_string)
    assert_equal copy.diceboard.dices, original.diceboard.dices
    assert_equal copy.diceboard.is_equal?(original.diceboard), true
  end
  it "must have same to_string from and back" do
    original = Jamb.new
    original.diceboard.roll_all
    original.play(1,1)
    original.diceboard.select(0)
    original.diceboard.roll_selected
    copy = Jamb.new
    copy.from_game_string(original.to_game_string)
    assert_equal copy.to_game_string, original.to_game_string
  end 
    

  it "must keep playround property from string and back"do
    original = Jamb.new
    original.playround = 10
    copy = Jamb.new
    copy.from_game_string(original.to_game_string)
    assert_equal original.playround, copy.playround
  end
  it "ater play playround must be one + previos" do
    j = Jamb.new
    j.diceboard.roll_all
    last = j.playround
    j.play(1,1)
    assert_equal j.playround, last + 1
  end
  it "after play diceboard state must be in :no_roll " do
    j = Jamb.new
    j.rows do |row|
      j.columns do |col|
        j.diceboard.roll_all
        if j.cell(row,col).is_enabled? 
          j.play(row,col)
          assert_equal j.diceboard.mode, :no_roll
        end
      end
    end
  end
  
  it " cell 0 0 must no be enabled" do
    j = Jamb.new
    assert_equal j.cell(0,0).is_enabled?, false
  end        
  it " when created dice board must be in :no_roll mode " do 
    j = Jamb.new
    assert_equal j.diceboard.mode, :no_roll
  end   
  it "must set changed for lists of changed cells" do
    j = Jamb.new
    j.diceboard.roll_all
    j.play(1,1)
    a = Array.new
    a << [1,1]
    a << [2,1] 
    assert_equal a , j.changed
  end
  it "must set changed for lists of changed cells including calculated" do
    j = Jamb.new
    [1,2,3,4,5,6].each do |row|
      j.diceboard.roll_all
      j.play(row,1)
    end 
    a = Array.new
    a << [6,1]
    a << [7,1]
    a << [8,1] 
    a << [9,1]
    set_a = a.to_set
    set_changed = j.changed.to_set
    assert_equal set_a.subset?(set_changed), true
    assert_equal set_changed.subset?(set_a), true

  end 
end
