Rails.application.routes.draw do
  resources :events

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'events#index'
  get 'about' => 'welcome#index', as: :welcome_index
  post 'update_gamertag' => 'welcome#update_gamertag', as: :welcome_update_gamertag
  get 'events_manage' => 'events#events_manage', as: :events_manage
  post 'events/:id/join_event' => 'events#join_event', as: :join_event
  post 'events/:id/approve' => 'events#approve', as: :approve
  get 'events/:id/close' => 'events#close_event', as: :close_event
  get 'events/:id/open' => 'events#open_event', as: :open_event
  get 'events/live_event/chat_window' => 'events#live_event', as: :live_event
  post 'events/:id/announcement_post' => 'events#announcement_post', as: :announcement_post
  
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
