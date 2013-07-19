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

  it "have class_str method aand must return label in it if type is :LABEL" do
    c = Cell.new(:LABEL)
    assert_equal  c.class_str.split(" ").include?('label'), true
   end

   it "must return empty? = false if value is not set otherwise true" do
     c = Cell.new(:NORMAL)
     assert_equal c.empty?, true
     c.value = 1;
     assert_equal c.empty?, false
   end
end 
      
