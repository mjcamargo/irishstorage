Rails.application.routes.draw do
  devise_for :admins
  resources :reservations
    resources :profiles
  
  get 'home/index'
  resources :shops
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  get '/signedinuserprofile' => 'profiles#signedinuserprofile'
  
  resources :profiles do
    resources:reservations
  end  

end
