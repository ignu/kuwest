


class WinViewModel 
  attr_accessor :username, :body

  def initialize(hash)
     hash.each do |k,v|
     #  puts "@#{k} ::: #{v}")  ## create and initialize an instance variable for this key/value pair
       self.instance_variable_set("@#{k}", v)  ## create and initialize an instance variable for this key/value pair
     end
     @activity = Activity.new(body)
   end
    
  def to_win
    @user = User.find_or_generate_by_username @username
    raise "Could not find user #{@username}" if @user.nil?
    return Win.new(:amount=>@activity.amount, :noun=>@activity.noun, 
      :verb=>@activity.verb, :user=>@user)
  end
  
end 

