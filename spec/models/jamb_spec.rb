describe Jamb do
  it "must be crated" do
    j = Jamb.new
  end

  it "must have rownum 16" do
    j = Jamb.new
    assert_equal j.rownum, 17
    assert_equal j.colnum, 4
  end

end
