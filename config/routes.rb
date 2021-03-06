Comics::Application.routes.draw do

  resources :users, only: [:show] do
    member do
      get 'token'
      get 'get_new_token'
    end
  end
  resources :users do
    resources :publishers, only: [:index, :show]
    resources :issues, only: [:show, :update]
    resources :volumes, only: [:show]
    resources :characters, only: [:index, :show]
    resources :people, only: [:index, :show]
    resources :subscriptions, only: [:index, :create, :destroy]
    resources :collected_editions, only: [:show, :update, :new, :create]
  end
  get 'users/:user_id/collected_editions/new/:id', to: 'collected_editions#new', as: 'new_user_collected_edition_id'

  get 'users/:user_id/issues/:id/:variant_id', to: 'issues#show', as: 'user_variant'
  post 'users/:user_id/issues/:id/add', to: 'users#add_existing_issue', as: 'user_add_existing_issue'

  post 'add_issue', to: 'users#add_issue'
  get 'add_collected_edition', to: 'collected_editions#add_collected_edition'
  post 'add_variant', to: 'users#add_variant'
  post 'add_volume', to: 'users#add_subscription'
  post 'remove_volume', to: 'users#remove_subscription'
  get 'get_username', to: 'users#get_username'
  get 'get_number_of_issues', to: 'users#get_number_of_issues'
  get 'volume_subscribed', to: 'users#volume_subscribed'

  get 'update_all_issues', to: 'issues#update_all'

  get 'sessions/new', as: 'login'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'sessions#new'

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
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
