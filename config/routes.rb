Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }

  #=== MAIN APP =================================
  resources :events,  only: %i[index show]
  resources :venues,  only: %i[show]
  resources :talks,   only: %i[index show]
  resource  :chat,    only: %i[show create],      controller: :chat
  resource  :profile, only: %i[show edit update], controller: :profile
  resources :members, only: %i[index show]
  resources :goals,   only: %i[index show] do
    post :donate, on: :member
  end

  #=== ADMIN AREA ===============================
  authenticate :user, ->(u) { u.admin? } do
    namespace :admin do
      get '/', to: 'home#index'
      resources :events,  except: %i[show destroy]
      resources :venues,  except: %i[show destroy]
      resources :talks,   except: %i[show destroy]
      resources :goals,   except: %i[show destroy]
      resources :members, except: %i[show destroy]
    end
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
