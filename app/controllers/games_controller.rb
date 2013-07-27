class GamesController < ApplicationController
  def show
    @jamb = Jamb.new
  end   
  def play
    @jamb = Jamb.new
  end  
end
