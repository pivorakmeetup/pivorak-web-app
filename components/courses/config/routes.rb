Rails.application.routes.draw do
  namespace :courses do
    resources :seasons, only: :show
  end

  authenticate :user, ->(u) { u.admin? } do
    namespace :admin do
      namespace :courses do
        root to: redirect('/admin/courses/seasons')

        resources :seasons, except: :destroy
      end
    end
  end
end
