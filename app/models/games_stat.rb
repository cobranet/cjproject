class GamesStat
  def self.best_scores
    a = Array.new  
    best = UserStat.where(property: "BEST_SCORE").order("value desc").first(3)
    best.each do |b| # unefficent until learn join
      a << User.find(b.user_id)
    end
    a
  end   
end
