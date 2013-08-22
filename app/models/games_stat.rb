class GamesStat
  def self.average_best_score
    a = ActiveRecord::Base.connection.select_all("select AVG(CAST(value as integer) ) from user_stats where property = 'BEST_SCORE'")
    a[0]['avg'].to_i
  end
  def self.all_user_average
    a = ActiveRecord::Base.connection.select_all("select AVG(CAST(value as float) ) from user_stats where property = 'AVERAGE'")
    "%.0f" % a[0]['avg'].to_f
  end
  def self.games_played
    a = ActiveRecord::Base.connection.select_all("select SUM(CAST(value as float) ) from user_stats where property = 'GAMES_PLAYED'")
    a[0]['sum'].to_i
  end
  def self.best_scores
    a = Array.new  
    best = UserStat.where(property: "AVERAGE").order("CAST(value as float) desc").first(3)
    best.each do |b| 
      a << User.find(b.user_id)
    end
    a
  end   
end
