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
end
