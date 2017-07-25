Rails.application.routes.draw do
  namespace :courses do
    resources :seasons,      only: %i[index show] do
      resource :cancel_attendance, only: :create
      resources :students,   only: %i[index new create]
      resources :interviews, only: %i[index update]
      resources :homeworks,  only: %i[index new create]
      resources :test_task,  only: %i[new create]
    end
  end

  namespace :admin do
    namespace :courses do
      root to: redirect('/admin/courses/seasons')

      resources :seasons,      except: :destroy do
        resources :mentors,    except: %i[show edit update]
        resources :questions,  except: :destroy
        resources :interviews, except: :destroy do
          resources :interview_assessments, only: %i[create update]
        end
        resources :students,   only:   :index
        resources :lectures,   except: %i[show destroy] do
          resources :progress, only:   %i[index update]
        end
        resources :test_task,  only:   %i[index update]
      end
    end
  end
end
