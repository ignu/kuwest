require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
include Devise::TestHelpers 

describe UsersController do

  before(:each) do
    @current_user= User.find_or_create_by_username 'megatron'
    #sign_in @megatron
  end

  describe "getting a non existant user" do

    before(:each) do
      get(:show, {:id=>"notauser"})
    end

    it { should respond_with(:not_found) }
  end

  describe "view another profile" do

    before(:each) do
      Win.stub_method(:totals_for => 4)   
      User.stub_method(:find_by_username => @megatron)
      get(:show, {:id=>"megatron"})
    end


    it "doesn't show the update status field" do
      assigns[:can_update_status].should be false
    end

    it { should respond_with(:success) }
  end     

  describe "view my own profile" do

    before(:each) do
      Win.stub_method(:totals_for => 4)   
      @ignu = User.find_or_create_by_username 'ignu'
      User.stub_method(:find_by_username => @ignu)
      get(:show, {:id=>"ignu"})
    end

    it "shows the update status field" do
      assigns[:can_update_status].should be true
    end

    it { should respond_with(:success) }
  end     
  
  describe "routing" do
    it "should route /users/ignu to ignu's profile" do
      params_from(:post, '/users/ignu').should == {:controller => 'users', :action => 'show', :id=>'ignu'}  
    end
  end
end
