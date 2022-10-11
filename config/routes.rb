require 'sidekiq/web'

Rails.application.routes.draw do
  constraints subdomain: 'www' do
    devise_for :users, class_name: "Tenant::User", path: '', skip: [:sessions, :confirmations, :passwords, :unlocks], controllers: { registrations: 'users/registrations' }
  end

  # get 'dashboard/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  constraints TenantConstraint do

    scope module: :tenant, as: :tenant do
      root to: 'dashboard#index'

      get 'catalogue', to: 'catalogue#index'

      namespace :catalogue do
        get 'favourites', to: 'favourites#index'
      end

      get 'catalogue/*path', to: 'catalogue#index', as: :catalogue_browser

      resources :media_items, only: [:show, :create, :update] do
        get 'move', on: :member
        post 'customized_fields_update', on: :member
      end

      resources :nodes, only: [:index] do
        get 'move', on: :collection
        patch 'batch_update', on: :collection
      end

      resources :folders, only: [:new, :edit, :create, :destroy, :update] do
        get 'move', on: :member
      end

      get 'screening_room', to: 'screening_room#index'

      get 'settings', to: 'settings#index'
      get 'settings/predefined_metadata_fields', to: 'settings#predefined_metadata_fields'
      get 'settings/customized_metadata_fields', to: 'settings#customized_metadata_fields'
      match 'settings/update', to: 'settings#update', via: [:put, :patch]

      get 'in_development', to: 'in_development#index'
    end

    devise_for :users, class_name: "Tenant::User", path: '', path_names: { sign_in: 'login', sign_out: 'logout' }, skip: [:registrations]

    devise_scope :user do
      put 'account/update', to: 'users/registrations#update'
    end
  end

  mount Sidekiq::Web => '/sidekiq'
end
