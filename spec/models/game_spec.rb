require 'spec_helper'

describe Game do
  it "must have from_jamb method that returns String class " do
    j = Jamb.new
    g = Game.new
    g.from_jamb(j)
    assert_equal String, g.jambgame.class
  end
 
  it "must have to_jamb method returns Jamb class" do
    j = Jamb.new
    g = Game.new
    g.from_jamb(j)
    assert_equal g.to_jamb.class, Jamb
  end
  
  it "must preserve state" do 
    j = Jamb.new
    g = Game.new
    j.set_cell_value(1,1,7)
    g.from_jamb(j)
    g.save!
    g1 = Game.find(g.id)
    j1 = Jamb.new
    j1 = g1.to_jamb
    assert_equal g1.jambgame, g.jambgame
    j.from_game_string(g.jambgame)
    j1.from_game_string(g.jambgame)
    (0..16).each do |row|
      (0..3).each do |col|
        assert_equal j1.cell(row,col).is_equal?(j.cell(row,col)), true
      end  
    end  
    assert_equal 7, j1.cell(1,1).value
  end
end
