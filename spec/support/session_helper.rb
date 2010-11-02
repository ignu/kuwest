module SessionHelpers
  include Devise::TestHelpers

  def signin_as(email, username, password)
    user = User.create(:email => email, :password => password, :password_confirmation => password, :username => username)
    sign_in user
    user
  end

  def signin_mock
    user = mock_model(User) 
    sign_in user
    user
  end

end
