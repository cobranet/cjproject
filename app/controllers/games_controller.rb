class GamesController < ApplicationController
  def show
    @jamb = Jamb.new
  end
   
  def play
    @jamb = Jamb.new
    @jamb.set_cell_value(params[:row].to_i,params[:col].to_i,3)
  end  
end
