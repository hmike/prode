Prode::Application.routes.draw do
  
  resources :user_groups

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  # root "users/edit"
  # root :to => 'devise/registrations#new'

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

  devise_scope :user do
    # get 'profile', to: 'devise/registrations#edit', as: :edit_user_registration
    authenticated :user do
      root :to => 'devise/registrations#edit', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'devise/sessions#create', as: :unauthenticated_root
    end
  end
  devise_for :users, :skip => [:sessions, :registrations], :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # devise_for :users, :skip => [:sessions], :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  as :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to:'devise/sessions#create', as: :user_session
    match 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session,
      :via => Devise.mappings[:user].sign_out_via
    get 'cancel', to: 'devise/registrations#cancel', as: :cancel_user_registration
    post 'create' => 'devise/registrations#create', :as => :user_registration
    get 'signup' => 'devise/registrations#new', :as => :new_user_registration
    get 'profile', to: 'devise/registrations#edit', as: :edit_user_registration
    patch 'create', to: 'devise/registrations#update'
    put 'create', to: 'devise/registrations#update'
    delete 'create', to: 'devise/registrations#destroy'
  end


end

# authenticated_root_path  GET   /   devise/registrations#edit
# unauthenticated_root_path  GET   /   devise/registrations#new
# cancel_user_registration_path  GET   /users/cancel(.:format)   devise/registrations#cancel
# user_registration_path   POST  /users(.:format)  devise/registrations#create
# new_user_registration_path   GET   /users/sign_up(.:format)  devise/registrations#new
# edit_user_registration_path  GET   /users/edit(.:format)   devise/registrations#edit
# PATCH  /users(.:format)  devise/registrations#update
# PUT  /users(.:format)  devise/registrations#update
# DELETE   /users(.:format)  devise/registrations#destroy