Wave::Application.routes.draw do

  get "discussions/create"

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
    resources :manufacturers, :technologies, only: [:index, :show]
    resources :entities, only: [:index, :show], :path => "product" do
      resources :discussions, :only => [:create]
    end
    get '/:option', action: :show, on: :member
  end

  resources :orders, :carts

  root :to => 'general#index'

end