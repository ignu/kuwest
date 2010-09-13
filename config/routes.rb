Kuwest::Application.routes.draw do |map|
  
  resource :users
  resources :wins
  resources :quest_definitions

  map.profile   'profile',      :controller=>"users", :action =>"edit"
  map.top_users 'top-users',    :controller=>"users", :action =>"top"

  map.user_show 'users/:id',    :controller=>"users", :action =>"show"
  map.user      'users/:id',    :controller=>"users", :action =>"show"
  map.tos       'tos',          :controller=>"home",  :action =>"tos"
  map.about     'about',        :controller=>"home",  :action =>"about"
  map.root                      :controller=>"wins", :action=>"index"

#devise_for "users", :path_names=>{:sign_in => 'login', :sign_out => 'logout', :sign_up => "new"}
  
  resources :followings, :only => [:create, :destroy]
  map.after_twitter_login 'after_twitter_login', :controller => 'after_twitter_login', :action => 'login_to_devise'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
