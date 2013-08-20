Tournamentdirector::Application.routes.draw do

  resources :reports do
    get :show_ranking, on: :collection
  end
  
  post "game_type/add_tournament" => "game_types#assign_tournament", as: "game_type_add_tournament"
  get "game_type/add_tournament" => "game_types#add_tournament", as: "game_type_add_tournament"
  resources :game_types

  get  "user/:id/unassign_tournament/:tournament_id" => "users#unassign_tournament", as: "unassign_tournament"

  get  "user/:id/assign_tournament" => "users#add_tournament", as: "assign_tournament"
  post "user/:id/assign_tournament" => "users#assign_tournament", as: "assign_tournament"

  
  #Use for adding a Game to a squad entry
  get "squad_entry/:id/new_game" => "squad_entries#new_game", as: "new_squad_entry_game"
  post "squad_entry/:id/new_game" => "squad_entries#create_game", as: "create_squad_entry_game"

  get "squads/updated_entry/:updated_squad_entry_id" => "squads#show", as: "squad_updated_entry"
  get "squad/:squad_id/entry/:game_type_id/new" => "squad_entries#new", as: "new_squad_entry"
  

  resources :squad_entries do
    get :add, on: :collection
  end

  resources :games
  resources :squads do
    get '/show/:bowler_class_name' => "squads#show_by_category"
    get '/show/:bowler_class_name/:game_type_name' => "squads#show_by_category", as: "show_by_category"
  end

  resources :tournaments do
    get 'select'
    get 'latest', on: :collection
  end

  get "average_entry/new/:bowler_id" => "average_entries#new", as: "new_average_entry"
  resources :average_entries

  get "sessions/new"
  get "users/new"
  
  resources :bowlers do
    get 'show_entries'
    get 'search_entries', on: :collection
    post 'search_entries', on: :collection
    get 'names', on: :collection
  end

  resources :bowling_associations do
    get "show_entries"
  end

  get "error" => "sessions#error", :as => "error"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  root :to => "tournaments#index"
  resources :users
  resources :sessions

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root to: 'welcome#index'

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

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
