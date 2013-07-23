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

  it "have class_str method and must return label in it if type is :LABEL" do
    c = Cell.new(:LABEL)
    assert_equal  c.class_str.split(" ").include?('blabel'), true
   end

   it "must return empty? = false if value is not set otherwise true" do
     c = Cell.new(:NORMAL)
     assert_equal c.empty?, true
     c.value = 1;
     assert_equal c.empty?, false
   end

   it "if is column label must have class style bcol" do
     c = Cell.new(:LABEL,true)
     c1 = Cell.new(:LABEL) 
     assert_equal c.class_str.split(" ").include?("bcol"), true  
     assert_equal c1.class_str.split(" ").include?("bcol"), false  
   end 
end 
      
