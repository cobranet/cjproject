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
  
  def select
    game = Game.find(params[:id])
    jamb = game.to_jamb
    jamb.diceboard.toggle(params[:dice].to_i)
    game.from_jamb(jamb)
    game.save!
    redirect_to game_path(game.id)
  end 

  def roll 
    game = Game.find(params[:id])
    jamb = game.to_jamb
    jamb.diceboard.roll_selected
    game.from_jamb(jamb)
    game.save!
    redirect_to game_path(game.id)
  end  

  def play
    game = Game.find(params[:id])
    jamb = game.to_jamb
    jamb.play(params[:row].to_i,params[:col].to_i)
    game.from_jamb(jamb)
    game.save!
    redirect_to game_path(game.id)
  end  
end
