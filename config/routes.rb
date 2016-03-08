Rails.application.routes.draw do

  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end

  root to: 'visitors#index'

  devise_for :users
  
  resources :users, only: [:show] do 
  	resources :orders, only: [:index, :show]
  end

  resources :recitals, only: [:show] do
  	resources :areas, only: [:show] do
  	  resources :seats, only: []
  	end
  end
end
