class Win < ActiveRecord::Base
  belongs_to :user
  
  def self.totals_for(user)
    find_by_sql(["SELECT SUM(amount) as total, verb, noun 
      FROM wins WHERE user_id = ? GROUP BY noun, amount", user.id])
  end
end
