Wave::Application.routes.draw do

	# Backend
	namespace :backend do
		resources :users do
      get 'privileges', action: :privileges
    end
    resources :attributes, :units, :categories, :manufacturers, :entities, except: :show
	end

  # Devise
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'register'}

  resources :profiles, only: :show

  root :to => 'general#index'

end