Philaspice::Application.routes.draw do
  get "dashboard/index" => 'dashboard#index', as: :dashboard
  get "help" => 'dashboard#help', as: :help

  devise_for :admins, path: '', path_names: {sign_in: 'tallyho'}, skip: [:registration]

  get "admin/options" => 'options#show', as: :option
  
  put "admin/options" => 'options#update', as: :option
  get "storefront/index" => 'storefront#index', as: :storefront
 get "store/category/:category_id" => 'storefront#index', as: :storefront
  get "store/product/:id" => 'storefront#product', as: :storefront_product
 
  get "storefront/checkout"
  
  get "storefront/review_order/:slug" => 'storefront#review_order', as: :storefront_review_order
  
  get "storefront/search"
  
  post "storefront/pay" => 'storefront#pay', as: :storefront_pay
  
  put "line_items/update_quantity" => 'line_items#update_quantity', as: :update_quantity
  
  get "stats/update_order_state" => 'stats#update_order_state', as: :update_order_state
  resources :orders, :stats
  get "front/index"
  get "/" => 'front#index'
  post "front/contact_us" => 'front#contact_us', as: :contact_us
  
 
  get "front/about"
  
  get "front/thanks"
  
  get "front/contact"
  get "index" => "front#index", as: :index
  get "contact" => "front#contact", as: :contact
  get "about" => "front#about", as: :about
  get "store" => "storefront#index", as: :store
  
  root to: "index#front"
  resources :products do
    
    member do
      get :revive
      get :stock
      get :unstock
      post :hard_destroy
    end
    
    resources :variants do
      member do
        get :revive
        get :weights
        get :edit_weight
        get :delete_price
        put :save_weight
        put :update_weight
        put :master
        get :stock
        get :unstock
        post :hard_destroy
      end
    end
    
  end
 
  resources :categories do
    resources :subcategories
  end
  resources :weights
  resources :pages
  get "show_cart" => 'carts#show', as: :show_cart
  resources :carts
  resources :line_items
  resources :sliders
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
