require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
include Devise::TestHelpers 

describe UsersController do

  before(:each) do
    @current_user= User.find_or_create_by_username 'megatron'
  end

  describe "getting a non existant user" do

    before(:each) do
      get(:show, {:id=>"notauser"})
    end

    it { should respond_with(:not_found) }
  end

# describe "view another profile" do
#
#   before(:each) do
#     Win.stubs(:totals_for).returns(:whatever)   
#     User.stubs(:find_by_username).returns(@current_user)
#     get(:show, {:id=>"megatron"})
#   end
#
#
#   it "doesn't show the update status field" do
#     assigns[:can_update_status].should be false
#   end
#
#   it { should respond_with(:success) }
# end     
#
# describe "view my own profile" do
#
#   before(:each) do
#     Win.stubs(:totals_for).returns(:whatever)   
#     @ignu = User.find_or_create_by_username 'ignu'
#     User.stubs(:find_by_username).returns(@ignu)
#     get(:show, {:id=>"ignu"})
#   end
#
#   it "shows the update status field" do
#     assigns[:can_update_status].should be true
#   end
#
#   it { should respond_with(:success) }
# end     
# 
  describe "routing" do
    it "should route /users/ignu to ignu's profile" do
      params_from(:post, '/users/ignu').should == {:controller => 'users', :action => 'show', :id=>'ignu'}  
    end
  end
end
