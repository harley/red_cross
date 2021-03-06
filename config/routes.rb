Rails.application.routes.draw do
  comfy_route :cms_admin, :path => '/admin/cms'
  mount RailsEmailPreview::Engine, at: 'admin/emails'
  resources :appointments, only: [:index] do
    collection do
      get :by
    end
  end

  get 'sign_in' => 'home#sign_in'

  resources :users do
    post 'update_roles', on: :collection
  end
  resources :drives, only: [:show] do
    resources :appointments, except: [:index] do
      post :remind, on: :member
    end
    member do
      get 'kiosk'
      post 'add_appointment'
    end
  end
  resources :drives, only: [:edit, :update, :index]

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  namespace :admin do
    # Directs /admin/products/* to Admin::ProductsController
    # (app/controllers/admin/products_controller.rb)
    resources :drives, only: [:show] do
      resources :appointments, only: [:index]
    end
  end

  # Make sure this routeset is defined last
  # comfy_route :cms, :path => '/', :sitemap => false
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
