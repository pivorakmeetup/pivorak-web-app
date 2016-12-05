Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  #=== MAIN APP =================================
  resources :events, only: %i[index show]
  resources :venues, only: %i[show]
  resources :talks,  only: %i[index show]
  resource :invites, only: %i[new create]

  #=== ADMIN AREA ===============================
  authenticate :user, ->(u) { u.admin? } do
    namespace :admin do
      get '/', to: 'home#index'
      resources :events, except: %i[show destroy]
      resources :venues, except: %i[show destroy]
      resources :talks,  except: %i[show destroy]
    end
  end
end
