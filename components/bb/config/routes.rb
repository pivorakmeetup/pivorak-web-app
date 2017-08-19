Rails.application.routes.draw do
  namespace :bb do
    root to: 'home#index'

    resources :knock, only: %i[new create]
  end

  namespace :admin do
    namespace :bb do
      root to: 'home#index'

      resources :members
    end
  end
end
