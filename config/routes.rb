Rails.application.routes.draw do

  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end

  root to: 'visitors#index'

  devise_for :users
  
  resources :orders

  resources :recitals, only: [:show] do
    resources :areas, only: [:index, :create] do
  	  resources :seats, only: [:index]
  	end
  end

  resources :aggregation, only: [:show, :index]

  get 'files/:filename' => 'file#download' 

end