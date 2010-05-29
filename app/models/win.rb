require 'rubygems'

class Win < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  
  def self.totals_for(user)
    raise "Need to Supply a User" if user.nil?

    find_by_sql(["SELECT SUM(amount) as total, verb, noun 
      FROM wins WHERE user_id = #{user.id} GROUP BY verb, noun", user.id])
  end
end

class Float
  def pretty
    return ("%.1f" % self).gsub(/(\d)(?=\d{3}+(\.\d*)?$)/, '\1,') if modulo(1) > 0
    self.to_i.to_s
  end
end