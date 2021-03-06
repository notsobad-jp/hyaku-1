Hyaku1::Application.routes.draw do


  root :to => 'home#index'

  match 'learn' => 'histories#show', :as => :learn
  match 'learn/save' => 'histories#save', :as => :learn_save
  match 'learn/finish' => 'histories#finish', :as => :learn_finish
  match 'learn/complete' => 'histories#complete', :as => :learn_complete
  match 'review' => 'review#show', :as => :review
  match 'review/index' => 'review#index', :as => :review_index
  match 'review/answer' => 'review#answer', :as => :review_answer
  match 'review/finish' => 'review#finish', :as => :review_finish
  match 'exam/index' => 'exam#index', :as => :exam_index
  match 'exam' => 'exam#show', :as => :exam
  match 'exam/answer' => 'exam#answer', :as => :exam_answer
  match 'exam/finish' => 'exam#finish', :as => :exam_finish
  resources :users
  resources :user_sessions
  resources :songs
  match 'oauth/callback' => 'oauths#callback'
  match 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'top' => 'home#top', :as => 'top'
  match 'home/about' => 'home#about', :as => 'about'
  match 'home/credit' => 'home#credit', :as => 'credit'

  match 'games/index' => 'games#index', :as => :games_index
  match 'games' => 'games#show', :as => :games
  match 'games/answer' => 'games#answer', :as => :games_answer
  match 'games/finish' => 'games#finish', :as => :games_finish

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
