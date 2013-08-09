class GamesController < ApplicationController
  def show
    game = Game.find(params[:id])
    @jamb = game.to_jamb
  end
  
  def index
    
  end 

  def on_end_game
    game = Game.find(params[:id])
    redirect_to games_path unless game.user_id == current_user.uid  
    @jamb = game.to_jamb
    UserStat.add_score(current_user,@jamb.end_game_score)
  end   
 
  def create
    if current_user == nil 
     redirect_to games_path
    else   
      @jamb = Jamb.new
      game = Game.new
      game.user_id = current_user
      game.from_jamb(@jamb)
      game.save!
      redirect_to game_path(game.id)
    end
  end
  
  def select
    game = Game.find(params[:id])
    redirect_to games_path unless game.user_id == current_user.uid  
    @jamb = game.to_jamb
    if [:first_roll,:second_roll].include?(@jamb.diceboard.mode) 
      @selected = params[:dice].to_i
      @jamb.diceboard.toggle(@selected)
      game.from_jamb(@jamb)
      game.save!
    end
    respond_to do |format|
      format.html { redirect_to game_path(game.id)}
      format.js 
    end
    
  end 

  def roll 
    game = Game.find(params[:id])
    @jamb = game.to_jamb
    @jamb.diceboard.roll_selected
    game.from_jamb(@jamb)
    game.save!
    respond_to do |format|
      format.html {redirect_to game_path(game.id)}
      format.js
    end
  end  

  def roll_other 
    game = Game.find(params[:id])
    @jamb = game.to_jamb
    @jamb.diceboard.roll_unselected
    game.from_jamb(@jamb)
    game.save!
    respond_to do |format|
      format.html { redirect_to game_path(game.id) }
      format.js { render 'roll.js'}
    end  
  end  

  def play
    game = Game.find(params[:id])
    game_playround = params[:playround].to_i
    jamb = game.to_jamb
    if jamb.playround != game_playround
      raise "#{jamb.playround} - #{game_playround}"
    end 
    jamb.play(params[:row].to_i,params[:col].to_i)
    game.from_jamb(jamb)
    puts jamb.playround
    game.save!
    redirect_to game_path(game.id)
  end  
end
