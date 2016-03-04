Rails.application.routes.draw do

  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end

  root to: 'visitors#index'

  devise_for :users
  
  resources :users do 
  	resources :orders
  end

  resources :recitals do
  	resources :areas do
  	  resources :seats
  	end
  end
end
