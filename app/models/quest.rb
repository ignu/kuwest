class Quest < ActiveRecord::Base
  attr_accessor :objective
  has_many :objectives
  belongs_to :user
  has_friendly_id :name, :use_slug => true
  
  def parse_objective

  end
end
