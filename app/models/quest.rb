class Quest < ActiveRecord::Base
  has_many :objectives
  belongs_to :user
end
