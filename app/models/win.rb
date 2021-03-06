require 'rubygems'

class Win < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  has_attached_file :photo,
        :storage        => :s3,
        :s3_credentials => "#{Rails.root}/config/s3.yml",
        :path           => ":attachment/comment/:id/:style.:extension",
        :styles         =>  {:small  => "240x180>"},
        :default_url    => ":attachment/defaults/clear.gif"

  process_in_background :photo

  def self.totals_for(user)
    raise "Need to Supply a User" if user.nil?

    find_by_sql(["SELECT SUM(amount) as total, verb, noun
      FROM wins WHERE user_id = #{user.id} GROUP BY verb, noun", user.id])
  end

end
