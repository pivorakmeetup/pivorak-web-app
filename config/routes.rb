Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations:      'users/registrations',
    passwords:          'users/passwords'
  }

  #=== MAIN APP =================================
  resources :events,  only: %i[index show] do
    resources :visit_requests, controller: 'visit_request/visit_requests', only: %i[create] do
      patch :cancel, to: 'visit_request/cancel#update'
    end
  end
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
      resources :events,  except: %i[show destroy] do
        resources :visit_requests, controller: 'visit_request/visit_requests', only: %i[index] do
          patch :approve, to: 'visit_request/approve#update'
          patch :cancel, to: 'visit_request/cancel#update'
        end
      end
      resources :venues,  except: %i[show destroy]
      resources :talks,   except: %i[show destroy]
      resources :goals,   except: %i[show destroy]
      resources :members, except: %i[show destroy]
    end
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
