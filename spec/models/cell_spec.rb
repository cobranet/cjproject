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

   it "if is column label and calc must have class style bcolcalc" do
     c = Cell.new(:LABEL,true)
     c1 = Cell.new(:LABEL) 
     assert_equal c.class_str.split(" ").include?("bcolcalc"), true  
     assert_equal c1.class_str.split(" ").include?("bcolcalc"), false  
   end 
   
   it "must have bcolcalc style in rows 7,8,11,16 and col 0 " do
     j=Jamb.new
     assert_equal j.cell(7,0).class_str.split(" ").include?("bcolcalc"), true
     assert_equal j.cell(8,0).class_str.split(" ").include?("bcolcalc"), true
     assert_equal j.cell(11,0).class_str.split(" ").include?("bcolcalc"), true
     assert_equal j.cell(16,0).class_str.split(" ").include?("bcolcalc"), true
     assert_equal j.cell(10,0).class_str.split(" ").include?("bcolcalc"), false
     assert_equal j.cell(4,0).class_str.split(" ").include?("bcolcalc"), false
   end  
  
end 
      
