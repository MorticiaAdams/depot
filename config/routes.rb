# == Route Map
#
#             Prefix Verb   URI Pattern                        Controller#Action
#       login_signon GET    /login/signon(.:format)            login#signon
#      login_signoff GET    /login/signoff(.:format)           login#signoff
#        login_index GET    /login/index(.:format)             login#index
#              admin GET    /admin(.:format)                   admin#index
#              login GET    /login(.:format)                   sessions#new
#                    POST   /login(.:format)                   sessions#create
#             logout DELETE /logout(.:format)                  sessions#destroy
#              users GET    /users(.:format)                   users#index
#                    POST   /users(.:format)                   users#create
#           new_user GET    /users/new(.:format)               users#new
#          edit_user GET    /users/:id/edit(.:format)          users#edit
#               user GET    /users/:id(.:format)               users#show
#                    PATCH  /users/:id(.:format)               users#update
#                    PUT    /users/:id(.:format)               users#update
#                    DELETE /users/:id(.:format)               users#destroy
#             orders GET    /orders(.:format)                  orders#index
#                    POST   /orders(.:format)                  orders#create
#          new_order GET    /orders/new(.:format)              orders#new
#         edit_order GET    /orders/:id/edit(.:format)         orders#edit
#              order GET    /orders/:id(.:format)              orders#show
#                    PATCH  /orders/:id(.:format)              orders#update
#                    PUT    /orders/:id(.:format)              orders#update
#                    DELETE /orders/:id(.:format)              orders#destroy
#         line_items GET    /line_items(.:format)              line_items#index
#                    POST   /line_items(.:format)              line_items#create
#      new_line_item GET    /line_items/new(.:format)          line_items#new
#     edit_line_item GET    /line_items/:id/edit(.:format)     line_items#edit
#          line_item GET    /line_items/:id(.:format)          line_items#show
#                    PATCH  /line_items/:id(.:format)          line_items#update
#                    PUT    /line_items/:id(.:format)          line_items#update
#                    DELETE /line_items/:id(.:format)          line_items#destroy
#              carts GET    /carts(.:format)                   carts#index
#                    POST   /carts(.:format)                   carts#create
#           new_cart GET    /carts/new(.:format)               carts#new
#          edit_cart GET    /carts/:id/edit(.:format)          carts#edit
#               cart GET    /carts/:id(.:format)               carts#show
#                    PATCH  /carts/:id(.:format)               carts#update
#                    PUT    /carts/:id(.:format)               carts#update
#                    DELETE /carts/:id(.:format)               carts#destroy
# who_bought_product GET    /products/:id/who_bought(.:format) products#who_bought
#           products GET    /products(.:format)                products#index
#                    POST   /products(.:format)                products#create
#        new_product GET    /products/new(.:format)            products#new
#       edit_product GET    /products/:id/edit(.:format)       products#edit
#            product GET    /products/:id(.:format)            products#show
#                    PATCH  /products/:id(.:format)            products#update
#                    PUT    /products/:id(.:format)            products#update
#                    DELETE /products/:id(.:format)            products#destroy
#              store GET    /                                  store#index
#

Rails.application.routes.draw do
=begin
  devise_for :users
  resources :roles
    get 'admin' => 'admin#index'
=end

    get 'admin' => 'admin#index'
    controller :sessions do
        get 'login' => :new
        post 'login' => :create
        delete 'logout' => :destroy
    end

    #get 'admin/index'
    #get 'sessions/create'
    #get 'session/destroy'

    resources :users
    resources :orders
    resources :line_items do
        post 'decrement', on: :member
    end
    resources :carts

=begin
    authenticated :user do
        root :to => 'store#index', as: :authenticated_root
    end
=end
    get 'store/index'

    resources :products do
        get :who_bought, on: :member
    end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'store#index', as: 'store'

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
