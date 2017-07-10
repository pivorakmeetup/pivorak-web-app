Rails.application.routes.draw do
  namespace :courses do
    resources :seasons, only: :show
  end

  namespace :admin do
    namespace :courses do
      root to: redirect('/admin/courses/seasons')

      resources :seasons, except: :destroy
    end
  end
end
