class UserStat < ActiveRecord::Base

   def self.get_properties(user)
     return UserStat.where(:user_id => user).to_a
   end

   def self.get_user_property(user,property)
    prop = UserStat.get_properties(user)
    p =  prop.select { |x|  x.property == property }
    p == [] ? 0 : p.first.value  
   end
    
  def self.user_average(user)
    a = get_user_property(user,'AVERAGE')    
    a ? a.to_f : 0
  end

  def self.user_last_score(user)
    a = get_user_property(user,'LAST_SCORE') 
    a ? a.to_i : 0
  end

  def self.user_games_played(user)
    a = get_user_property(user,'GAMES_PLAYED') 
    a ? a.to_i : 0
  end 
  
  def self.user_games_best(user)
    a = get_user_property(user,'BEST_SCORE') 
    a ? a.to_i : 0
  end 
    

   def self.add_score(user,score)
    userstr = user.to_s 
    if UserStat.where(:property => 'LAST_SCORE',:user_id => userstr).update_all(:value => score)  == 0 
      u = UserStat.new
      u.user_id = user
      u.property = "LAST_SCORE"
      u.value = score
      u.save!
    end
    best = UserStat.where(:property => 'BEST_SCORE',:user_id => userstr).all.first
    if best == nil  
      u = UserStat.new
      u.user_id = userstr
      u.property = "BEST_SCORE"
      u.value = score
      u.save!
    else
      if best.value.to_i < score   
        UserStat.where(:property => 'BEST_SCORE',:user_id => userstr).update_all(:value => score)
      end  
    end
    if UserStat.where(:property => 'LAST_PLAYED',:user_id => userstr).update_all(:value => Time.now.strftime("%Y-%d-%m %H:%M"))  == 0 
      u = UserStat.new
      u.user_id = user
      u.property = "LAST_PLAYED"
      u.value = Time.now.strftime("%Y-%d-%m %H:%M")
      u.save!
    end 
    games = UserStat.where(:property => 'GAMES_PLAYED',:user_id => userstr).all.first
    if games == nil 
      games = UserStat.new
      games.user_id = userstr
      games.property = "GAMES_PLAYED"
      games.value = 1
      games.save!
    else
      UserStat.where(:property => 'GAMES_PLAYED',:user_id => userstr).update_all(:value => games.value.to_i + 1)
    end  

    
    average = UserStat.where(:property => 'AVERAGE',:user_id => userstr).all.first
    if average == nil 
      average = UserStat.new
      average.user_id = userstr
      average.property = "AVERAGE"
      average.value = score
      average.save!
    else
      UserStat.where(:property => 'AVERAGE',:user_id => userstr).update_all(:value => (average.value.to_f*games.value.to_f + score)/(games.value.to_i  + 1)) 
    end 
  end  
end
