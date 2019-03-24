# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :courses do
    resources :seasons, only: %i[show] do
      resource :cancel_attendance, only: :create
      resources :students,   only: %i[index new create]
      resources :interviews, only: %i[index update]
      resources :homeworks,  only: %i[index new create]
      resources :test_task,  only: %i[new create edit update]
    end
  end

  namespace :admin do
    namespace :courses do
      root to: redirect('/admin/courses/seasons')

      resources :seasons,      except: :destroy do
        resources :mentors,    except: %i[show edit update]
        resources :test_task,  only:   %i[index update]
        resources :questions,  except: :destroy
        resource  :journal,    only:   :show, controller: 'journal'
        resource  :graduate,   only:   :create
        resources :students,   only:   %i[index show update] do
          resource :drop,      only:   :create, controller: 'drop'
        end

        resources :interviews, except: :destroy do
          resources :interview_assessments, only: %i[create update]
        end

        resources :lectures,   except: %i[show destroy] do
          resources :progress, only:   %i[index update]
        end
      end
    end
  end
end
