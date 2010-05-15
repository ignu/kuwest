class WinsController < ApplicationController

  def index
  end

  def new
    @win = Win.new
  end
end
