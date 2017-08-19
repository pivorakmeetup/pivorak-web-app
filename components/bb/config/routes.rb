Rails.application.routes.draw do
  namespace :bb do
    root to: 'home#index'
  end

  namespace :admin do
    namespace :bb do
      root to: 'home#index'
    end
  end
end
