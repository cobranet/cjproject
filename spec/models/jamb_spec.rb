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
  it "rows from 7 and 8 must be calc and disabled if col <> 0 " do
    j = Jamb.new
    j.rows do |row|
      j.columns do |col|
        if [7,8].include?(row) && col != 0
          assert_equal :CALC, j.cell(row,col).type
        end
     end
    end
  end

end
