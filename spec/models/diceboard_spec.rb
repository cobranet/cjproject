describe DiceBoard do
  it "must be created " do
    db = DiceBoard.new(5)
  end
  
  it "must return images sources for dices" do
    db = DiceBoard.new(5)
    (0..5).each do |dice|
      assert_equal db.img(dice) == 'blanklarge.gif', true
    end
    db.roll(3)
    assert_equal  db.img(3), "die-#{db.dices[3]}large.gif"
  end
  
  it "must return class_str for dices ... if dices is selected must heave selected class " do
    db = DiceBoard.new(5)
    db.select(3)
    assert_equal db.class_str(3).split(" ").include?("selected"), true
    assert_equal db.class_str(4).split(" ").include?("selected"), false
  end

  it "must set mode to first roll after roll_all " do
    db = DiceBoard.new(5)
    db.roll_all
    assert_equal db.mode,:first_roll
  end 

  it "must set mode to first roll after roll selected " do
    db = DiceBoard.new(5)
    db.roll_selected
    assert_equal db.mode,:first_roll
  end 
  
   it "if is roll selected ... unselected dices must keep value " do
     db = DiceBoard.new(5)
     db.roll_all
     dices_old = db.dices
     db.select(0)
     db.select(3)
     db.select(4)

     db.roll_selected 
     assert_equal db.dices[1], dices_old[1]
     assert_equal db.dices[2], dices_old[2]
   end
   it "if is roll unselected ... selected dices must keep value " do
     db = DiceBoard.new(5)
     db.roll_all
     dices_old = db.dices
     db.select(0)
     db.select(3)
     db.select(4)
     db.roll_selected 
     assert_equal db.dices[0], dices_old[0]
     assert_equal db.dices[3], dices_old[3]
     assert_equal db.dices[4], dices_old[4]
   end
   it "must keep state using to_str and from_str" do
     a = DiceBoard.new(5)
     a.dices[0] = 1
     a.dices[2] = 3
     a.dices[4] = 5
     a.select(0)
     a.select(3)
     b = DiceBoard.new(5)
     b.changed = []
     b.selected = []
     b.dices = []
     b.from_str(a.to_str)
     (0...5).each do |i|
       assert_equal a.selected[i] , b.selected[i]
       assert_equal b.dices[i], a.dices[i]
       assert_equal a.is_equal?(b) , true
       assert_equal a.changed[i], b.changed[i]  
     end
   end
    
   it "set_changed_to_sell must set changed to selected" do
     a = DiceBoard.new(5)
     a.select(0)
     a.select(3)
     a.select(4)
     a.set_changed_to_sel
     assert_equal a.changed, [0,3,4]
   end
   it "set_changed_to_unsel must set changed to unselected" do
     a = DiceBoard.new(5)
     a.select(0)
     a.select(3)
     a.select(4)
     a.set_changed_to_unsel
     assert_equal a.changed, [1,2]
   end

   it "after roll_selected changed must be eqaul to index of selected  " do
    a = DiceBoard.new(5)
    a.roll_all
    a.select(0)
    a.select(1)
    a.roll_selected
    assert_equal a.changed, [0,1]
   end

   it "after roll_unselected changed must be eqaul to index of unselected  " do
    a = DiceBoard.new(5)
    a.roll_all
    a.select(0)
    a.select(1)
    a.roll_unselected
    assert_equal a.changed, [2,3,4]
   end

end
