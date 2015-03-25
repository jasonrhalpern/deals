Rails.application.routes.draw do

  root :to => 'home#index'

  devise_for :users

  resources :businesses, :path => 'merchants' do
    resources :locations
    resources :deals
    get 'profile', on: :member
  end

  get '/search', to: 'search#index'

end
