require 'rubygems'
require 'google_chart'

class Win < ActiveRecord::Base
<<<<<<< HEAD
	def self.scatter_data_for_month
		chart = GoogleChart::ScatterChart.new('600x400',"Scatter Chart") do |sc|
      sc.data "Scatter Set", [[1,2,], [2,2], [3,3], [4,4], [2,4], [6,4]]
      sc.max_value [5,7] 
      sc.axis :x, :range => [0,9], :labels => ['', 'Sun', 'Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat', '']
      sc.axis :y, :range => [0,9], :labels => [0,1,2,3,4,5,6,7]
      sc.point_sizes [3,5,3,18,5,5] 
			sc.shape_marker :circle, :data_set_index => 1, :data_point_index => 2, :pixel_size => 60
    end
		chart.to_url
	end
=======
  belongs_to :user
>>>>>>> e4573608757d09ee03aa9d4f35626cee8d70d5c2
end
