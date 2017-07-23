Rails.application.routes.draw do
  root 'home#index'

  mount RailsEmailPreview::Engine, at: 'emails'
  mount ActionCable.server, at: 'cable'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations:      'users/registrations',
    passwords:          'users/passwords'
  }

  #=== MAIN APP =================================
  resources :events,  only: %i[index show] do
    resources :visit_requests, only: %i[show create destroy]
  end

  resources :speakers,  only: %i[index]
  resources :search,    only: %i[index]
  resources :venues,    only: %i[show]
  resources :talks,     only: %i[index show]
  resource  :chat,      only: %i[show create],      controller: :chat
  resource  :profile,   only: %i[show edit update], controller: :profile
  resources :members,   only: %i[index show] do
    post :become_speaker, to: 'become_speaker#create', on: :collection
  end

  # TODO uncomment when page is created
  # resource :donation,        only: %i[show create], controller: :donation
  resource :donation,        only: %i[create], controller: :donation
  resource :payment_handler, only: %i[create], controller: :payment_handler

  resources :goals,   only: %i[index show] do
    post :donate, on: :member
  end

  resource :supporters, only: %i[show]

  #=== ADMIN AREA ===============================
  authenticate :user, ->(u) { u.admin? } do
    namespace :admin do
      get '/', to: 'home#index'
      get '/donations', to: 'donations#index'

      resources :events,  except: %i[show destroy] do
        resources :visit_requests, only: %i[index] do
          collection do
            post :send_confirmations, to: 'visit_request/send_confirmations#create'
            post :import,             to: 'visit_request/import#create'
            get  :report,             to: 'visit_request/report#download'
          end

          put  :approve,      to: 'visit_request/approve#update'
          put  :cancel,       to: 'visit_request/cancel#update'
          put  :toggle_list,  to: 'visit_request/toggle_list#update'
          put  :toggle_visit, to: 'visit_request/toggle_visit#update'
        end
      end
      resources :venues,  except: %i[show destroy]
      resources :talks,   except: %i[show destroy]
      resources :goals,   except: %i[show destroy]
      resources :members, except: %i[show destroy] do
        resource :squash, only: %i[show create], controller: 'members/squash'
        post     :sign_in_as,                    to: 'members/sign_in_as#create'
      end
      resources :groups,  except: %i[show]
      resources :emails,  only:   %i[new show index create]
      resources :friends, except: %i[show destroy]
      resources :pages,   except: %i[show]
      resources :email_templates,   only: %i[index edit update]

      ez_settings_for :app

      require 'sidekiq/web'
      mount Sidekiq::Web => '/sidekiq'
    end
  end

  # This route must (!) be always (!) at the bottom of this file (!)
  get '/:page_url', to: 'pages#show'
end
