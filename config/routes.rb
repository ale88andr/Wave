Wave::Application.routes.draw do

  get "manufacturers/index"

  get "manufacturers/show"

  get "categories/index"

  get "categories/show"

	# Backend
	namespace :backend do
		resources :users do
      get 'privileges', action: :privileges
    end
    resources :attributes, :units, :manufacturers, :technologies, except: :show
    resources :categories do
      resources :entities, only: :new
    end

    resources :currencies do

    end

    resources :entities do
      get "select", on: :collection
      put "redirect_to_new_with_category", on: :collection
    end
	end

  # Devise
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'register'}

  resources :profiles, only: :show
  resources :categories, only: [:index, :show] do
    resources :manufacturers, only: [:index, :show]
    resources :entities, only: [:index, :show], :path => "product"
  end

  root :to => 'general#index'

end