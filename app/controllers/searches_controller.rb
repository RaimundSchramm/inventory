class SearchesController < ApplicationController

  def index
    @games = Game.all
  end
end
