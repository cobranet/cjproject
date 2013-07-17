describe Jamb do
  it "must be crated" do
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
    end
  end
  
  it "col num 0 must have type :LABEL and be disabled" do
    j = Jamb.new
    j.rows do |row|
      assert_equal :LABEL, j.cell(row,0).type
      assert_equal false, j.cell(row,0).is_enabled?
    end
  end
end
