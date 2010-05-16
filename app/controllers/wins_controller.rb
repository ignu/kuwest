class WinsController < ApplicationController

  def index
    @wins = Win.all
  end

  def new
    @win = Win.new
  end
  
end
