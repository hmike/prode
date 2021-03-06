Prode::Application.routes.draw do

  resources :bets

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  mount RailsAdminImport::Engine => '/rails_admin_import', :as => 'rails_admin_import'

  resources :user_groups
  resources :user_group_members
  resources :teams
  resources :leagues
  resources :matches

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  # root "users/edit"
  root :to => 'user_groups#index'

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
  
  resources :users

  as :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to:'devise/sessions#create', as: :user_session
    match 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session,
      :via => Devise.mappings[:user].sign_out_via
    get 'cancel', to: 'devise/registrations#cancel', as: :cancel_user_registration
    post 'create' => 'devise/registrations#create', :as => :user_registration
    get 'signup' => 'devise/registrations#new', :as => :new_user_registration
    get 'profile', to: 'devise/registrations#edit', as: :edit_user_registration
    delete 'create', to: 'devise/registrations#destroy'

    patch 'create', to: 'registrations#update'
    put 'create', to: 'registrations#update'
  end

  # resources :user_groups do
    # get 'signup', :on => :collection
  # devise_scope :user_groups do
  as :user_groups do
    get 'user_groups/:id/invite_user/:email', to: 'user_groups#invite_user', as: :user_group_invite_user
    get 'user_groups/:id/fixture', to: 'user_groups#fixture', as: :user_group_fixture
  end
  # end
  # end

  get 'my_groups', to: 'user_groups#index', as: :my_groups

  # AngularJS
  scope :api do
    get 'user_groups/my_groups', to: 'user_groups#my_groups', defaults: {format: :json}
    get 'user_groups/notifications', to: 'user_groups#notifications', defaults: {format: :json}
    resources :user_groups, defaults: {format: :json}
    # match 'user_groups/:id/invite_user', to: 'user_groups#invite_user', defaults: {format: :json}, via: [:post]
    post 'user_groups/:id/invite_user', to: 'user_groups#invite_user', defaults: {format: :json}
    post 'user_groups/:id/bet_match', to: 'user_groups#bet_match', defaults: {format: :json}
    get 'user_group_members/:id/my_bets', to: 'user_group_members#my_bets', defaults: {format: :json}
    get 'user_groups/:id/my_bets', to: 'user_groups#my_bets', defaults: {format: :json}
    get 'user_groups/:id/matches/:league_date', to: 'user_groups#matches', defaults: {format: :json}
    post 'user_groups/:id/accept_invitation', to: 'user_groups#accept_invitation', as: :user_group_accept_invitation, defaults: {format: :json}
    post 'user_groups/:id/reject_invitation', to: 'user_groups#reject_invitation', as: :user_group_reject_invitation, defaults: {format: :json}
    resources :matches, defaults: {format: :json}
  end
  # root 'watchlist#index'


end