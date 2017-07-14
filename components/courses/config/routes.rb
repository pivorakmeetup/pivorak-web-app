Rails.application.routes.draw do
  namespace :courses do
    resources :seasons, only: :show do
      resource :attend, only: %i[show create]
    end
  end

  namespace :admin do
    namespace :courses do
      root to: redirect('/admin/courses/seasons')

      resources :seasons, except: :destroy do
        resources :mentors, except: %i[show edit update]
        resources :questions, except: :destroy
        resources :interviews, except: :destroy
      end
    end
  end
end
