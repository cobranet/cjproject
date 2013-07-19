describe Jamb do
  it "must be created" do
    j = Jamb.new
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

  it "if cell is not empty and somebody nust be disabled" do
    j = Jamb.new
    j.set_cell_value(1,1,"B")
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

    assert_equal j.cell(13,2).is_enabled?, false
    j.enable_next(14,2)
    assert_equal j.cell(13,2).is_enabled?, false

  end 


  it "set_cel_value must enable next cel if cols are 1 and 2" do
    j = Jamb.new
    assert_equal j.cell(2,1).is_enabled?, false
    j.set_cell_value(1,1,1)
    assert_equal j.cell(2,1).is_enabled?, true
    assert_equal j.cell(3,1).is_enabled?, false
    j.set_cell_value(2,1,2)
    assert_equal j.cell(3,1).is_enabled?, true
  end


end
