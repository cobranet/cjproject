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
  it "must be equal to it self" do
    c = Cell.new(:NORMAL)
    assert_equal c.is_equal?(c), true
    c = Cell.new(:CALC)
    assert_equal c.is_equal?(c), true
    c = Cell.new(:SUM)
    assert_equal c.is_equal?(c), true
    c = Cell.new(:NORMAL,true)
    assert_equal c.is_equal?(c), true
    c = Cell.new(:CALC,true)
    assert_equal c.is_equal?(c), true
    c = Cell.new(:SUM,true)
    assert_equal c.is_equal?(c), true
  end

  it "must be not equal if value,type,is_enabled? and is_col? are not same" do
    c = Cell.new(:NORMAL,true)
    c1 = Cell.new(:NORMAL)
 
    c1.value = 7
    c1.enable 

    c.value = 7
    c.enable 

    assert_equal c1.is_equal?(c),false
  end

  it "must be not equal if value,type,is_enabled? and is_col? are not same" do
    c = Cell.new(:NORMAL,true)
    c1 = Cell.new(:NORMAL)
 
    c1.value = 7
    c1.enable 

    c.value = 7
    c.enable 

    assert_equal c1.is_equal?(c),false
  end

  it "must be not if value,type,is_enabled? and is_col? are not same" do
    c = Cell.new(:NORMAL)
    c1 = Cell.new(:NORMAL)
 
    c1.value = 7
    c1.enable 

    c.value = 7
    c.enable 

    assert_equal c1.is_equal?(c),true
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
  
   it "it must go from to_str and from str in same cell " do
    j = Jamb.new
    cell = Cell.new(:LABEL)  
    j.rows do |row| 
      j.columns do |col|
        assert_equal j.cell(row,col).to_str , cell.from_str(j.cell(row,col).to_str).to_str
      end
    end 
  end
  
  it "it must go from to_str and from_str and keep value" do
    j = Jamb.new
    cell = Cell.new(:LABEL)  
    j.rows do |row| 
      j.columns do |col|
        assert_equal j.cell(row,col).value , cell.from_str(j.cell(row,col).to_str).value
      end
    end 
  end
  it "it must go from to_str and from_str and keep is_col?" do
    j = Jamb.new
    cell = Cell.new(:LABEL)  
    j.rows do |row| 
      j.columns do |col|
        assert_equal j.cell(row,col).is_col? , cell.from_str(j.cell(row,col).to_str).is_col?
      end
    end 
  end 
  it "it must go from to_str and from_str and keep is_enabled?" do
    j = Jamb.new
    cell = Cell.new(:LABEL)  
    j.rows do |row| 
      j.columns do |col|
        assert_equal j.cell(row,col).is_enabled? , cell.from_str(j.cell(row,col).to_str).is_enabled?
      end
    end 
  end
  it "it must go from to_str and from_str and keep type" do
    j = Jamb.new
    cell = Cell.new(:LABEL)  
    j.rows do |row| 
      j.columns do |col|
        assert_equal j.cell(row,col).type , cell.from_str(j.cell(row,col).to_str).type
      end
    end 
  end
  
end 
      
