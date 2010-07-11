class Quest < ActiveRecord::Base
  has_many :objectives
  belongs_to :user
  has_friendly_id :name, :use_slug => true

  def objective=

  end

  def objective
    ""
  end
end
