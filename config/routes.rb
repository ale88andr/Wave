Wave::Application.routes.draw do

  # Devise
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'register'}

  resources :profiles, only: :show

  root :to => 'general#index'

end