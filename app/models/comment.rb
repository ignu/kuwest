require 'rubygems'

class Comment < ActiveRecord::Base
  belongs_to :win
  belongs_to :user
  validates_presence_of :body
end
