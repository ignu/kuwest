ActionController::Routing::Routes.draw do |map|
  
  map.devise_for :users, :path_names=>{:sign_in => 'login', :sign_out => 'logout', :sign_up => "new"}
  map.resource :users
  map.resources :wins
  map.resources :quest_definitions

  map.profile   'profile',      :controller=>"users", :action =>"edit"
  map.new_user  'users/new',    :controller=>"users", :action =>"new"
  map.update    'users/update', :controller=>"users", :action =>"update"
  map.create    'users/create', :controller=>"users", :action =>"create"
  map.top_users 'top-users',    :controller=>"users", :action =>"top"
  #hack
  map.user_show      'users/:id',    :controller=>"users", :action =>"show"
  map.user      'users/:id',    :controller=>"users", :action =>"show"
  map.tos       'tos',          :controller=>"home",  :action =>"tos"
  map.about     'about',        :controller=>"home",  :action =>"about"
  map.root                      :controller=>"wins", :action=>"index"
  
  map.resources :followings, :only => [:create, :destroy]
  map.after_twitter_login 'after_twitter_login', :controller => 'after_twitter_login', :action => 'login_to_devise'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
