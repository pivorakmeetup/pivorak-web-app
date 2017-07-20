Rails.application.routes.draw do
  namespace :courses do
    resources :seasons,      only: %i[index show] do
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
        resources :interviews, except: :destroy
        resources :students,   only:   :index
        resources :lectures,   except: :destroy
        resources :test_task,  only:   :index
      end
    end
  end
end

