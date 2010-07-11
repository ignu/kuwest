class QuestsController < ApplicationController
  def new
    @quest = Quest.new
  end
end
