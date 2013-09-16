class SearchesController < ApplicationController

  def index
    @games = Game.all
  end

  def ransack
    @search = Game.search(params[:q])
    @games = @search.result
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
  end
end
