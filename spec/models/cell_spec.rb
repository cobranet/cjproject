 
describe Cell do

  it "must be disabled after creation" do
    c = Cell.new(:LABEL)
    assert_equal c.is_enabled?,false
  end

  it "cant be enabled if :LABEL or :CALC" do
    c = Cell.new(:LABEL)
    expect do
     c.enable
    end.to raise_error
  end


end 
      
