class Game < ActiveRecord::Base
  def from_jamb(jamb)
    self.jambgame = jamb.to_game_string  #  Marshal.dump(jamb)
  end
  def to_jamb
    j = Jamb.new
    j.from_game_string(self.jambgame)
    j
#    Marshal.load(self.jambgame)
  end
end
