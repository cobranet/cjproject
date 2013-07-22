class Game < ActiveRecord::Base
  def from_jamb(jamb)
    self.jambgame = Marshal.dump(jamb)
  end
  def to_jamb
    Marshal.load(self.jambgame)
  end
end
