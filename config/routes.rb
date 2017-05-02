Rails.application.routes.draw do
  get 'ganacias/mes'

  get 'ganacias/semana'

  get 'ganacias/ano'

  resources :expenses
  get 'avanzar/:id',to: 'bags#avanzar',as:'avanzar'
  resources :bags
  
  get "historial",to:'orders#historial', as:'historial'
  get 'pedido',to:'mesero#pedido',as:'pedido'
  get 'orders/query', :to => "orders#query",as:'order_query'
  get 'orders/domicilio', :to => "orders#domicilio",as:'domicilio'
  post 'create_bag', :to=> 'saucer_orders#create_bag', :as=>'create_bag'
  resources :customers
  post 'customers/create_order' ,to:'customers#create_order'
  devise_for :admin_users, ActiveAdmin::Devise.config
  get 'cocina/show'
  get 'cocina/terminados' , to:'cocina#terminados',as:'terminados'
  get 'cocina/barra_fria' , to:'cocina#barra_fria',as:'barra_fria'
  get 'cocina/barra_caliente',to:'cocina#barra_caliente',as:'barra_caliente'
  resources 'cocina'
  get 'welcome/index'
  
  devise_for :users,:skip => :registrations
  ActiveAdmin.routes(self)
  resources :ingredients
  resources :measurement_units
  resources :groups
  resources :categories
  resources :saucer_orders 
  resources :tables do
    resources :orders, shallow: true do 
      resources :saucer_orders 
    end
  end
  
  get 'pay/:id', :to => "orders#pay",as:'pay'
  post 'pay/:id', :to => "orders#paynow",as:'paynow'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
 
  authenticated :user do
    root 'mesero#pedido', as: :authenticated_root
  end
   root 'welcome#index'

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
