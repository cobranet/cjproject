class Oldgame < ActiveRecord::Base
  def self.save_new(game,score)
    g = Oldgame.new
    g.user_id = game.user_id
    g.jambgame = game.jambgame
    g.score = score
    g.save!
  end
end
