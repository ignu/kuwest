require 'rubygems'

class Win < ActiveRecord::Base
  belongs_to :user
  
  def self.totals_for(user)
    raise "Need to Supply a User" if user.nil?

    find_by_sql(["SELECT SUM(amount) as total, verb, noun 
      FROM wins GROUP BY verb, noun", user.id])
  end
end
