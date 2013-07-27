class GamesController < ApplicationController
  def show
    game = Game.find(params[:id])
    @jamb = game.to_jamb
  end
  
  def index
    
  end 
  def create
    @jamb = Jamb.new
    game = Game.new
    game.from_jamb(@jamb)
    game.save!
    redirect_to game_path(game.id)
  end
    
  def play
    game = Game.find(params[:id])
    jamb = game.to_jamb
    jamb.set_cell_value(params[:row].to_i,params[:col].to_i,3)
    game.from_jamb(jamb)
    game.save!
    redirect_to game_path(game.id)
  end  
end
