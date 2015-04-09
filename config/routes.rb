Rails.application.routes.draw do

  root :to => 'home#index'

  devise_for :users

  resources :businesses, :path => 'merchants' do
    get 'profile', on: :member
    resources :locations
    resources :deals
    resources :payments, :only => [:index, :new, :create, :destroy] do
      member do
        get 'edit_card'
        get 'update_card'
        get 'edit_plan'
        get 'update_plan'
      end
    end
  end

  resources :favorites, :only => [:index, :create, :destroy]

  get '/search', to: 'search#index'

end
