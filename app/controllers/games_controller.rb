class GamesController < ApplicationController
  def show
    game = Game.find(params[:id])
    @jamb = game.to_jamb
    gon.user_name = current_user.name
  end
  
  def index
    
  end 
 
  def create
    @jamb = Jamb.new
    game = Game.new
    game.user_id = current_user.id
    game.from_jamb(@jamb)
    game.save!
    redirect_to game_path(game.id)
   end
  
  def select
    game = Game.find(params[:id])
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
    @changed = @jamb.diceboard.changed
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
    @changed = @jamb.diceboard.changed
    respond_to do |format|
      format.html { redirect_to game_path(game.id) }
      format.js { render 'roll.js' }
    end  
  end  

  def play
    game = Game.find(params[:id])
    game_playround = params[:playround].to_i
    @jamb = game.to_jamb
    @jamb.play(params[:row].to_i,params[:col].to_i)
    game.from_jamb(@jamb)
    game.save!
    if @jamb.diceboard.mode == :end_game
      UserStat.add_score(current_user.id,@jamb.end_game_score)
    end
    respond_to do |format|
      format.html { redirect_to game_path(game.id) }
      format.js
    end
  end  
end
