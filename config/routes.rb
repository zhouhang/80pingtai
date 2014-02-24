Pingtai::Application.routes.draw do

  namespace :admin do
    resources :users,:phones
    match 'channels/query',  to: 'channels#getByCondition',:via => [:get]
    match 'channels/get_provinces_cites',  to: 'channels#get_provinces_cities',:via => [:get, :post]
    resources :channels do
      member do
        post :update_status
      end
    end
    resources :channelgroups
    match "channelgroups/area/:areaid/operator/:operator_id" => "channelgroups#getByAreaOperator",:via => [:get,:post]
    resources :prices do
      member do
        post :update_status
      end
    end
    match "prices/keyword/:keyword" => "prices#getByKeyword",:via => [:get,:post]
    match 'workids/query',  to: 'workids#getByCondition',:via => [:get]
    resources :workids do
      member do
        post :update_status
      end
    end
    resources :sessions, only: [:new, :create, :destroy]
    resources :charges do
      member do
        post :confirm
      end
    end

    match '/signin',  to: 'sessions#new',:via => [:get,:post]
    match '/signout', to: 'sessions#destroy', :via =>[:delete,:get]
    root :to => 'users#index'
  end

  resources :users, :phones, :fundslogs
  scope 'notify', :as => 'notify' do
    get 'qianxing', to: 'notify#qianxing'
  end

  match 'charges/get_charge_money',  to: 'charges#get_charge_money',:via => [:get, :post]
  match 'charges/get_tenpay_url',  to: 'charges#get_tenpay_url',:via => [:get, :post]
  resources :charges do
    member do
      post :cancel
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  match 'locations/search', to: 'locations#search', :via => [:get]
  match 'locations/query', to: 'locations#query', :via => [:get]
  match '/signup',  to: 'users#new',:via => [:get]
  match '/signin',  to: 'sessions#new',:via => [:get,:post]
  match '/signout', to: 'sessions#destroy', :via =>[:delete,:get]
  root :to => 'phones#new'

  match 'users/update_business_password', to: 'users#update_business_password', :via =>[:post]

end
