F5m::Application.routes.draw do
  
  root :to => "bip_configs#index"
    
  #get "bipclasses/index"
  #get "bipclasses/show"
  #get "biprules/index"
  #get "biprules/show"
  #get "bipmonitors/index"
  #get "bipmonitors/show"
  #get "bipnodes/index"
  #get "bipnodes/show"
  #get "bippools/index"
  #get "bippools/show"
  #get "bipselfips/show"

  resources :bip_configs do
    resources :bipselfips
    resources :virtuals do
        put 'migrate'
        put 'unmigrate'
      end
    resources :bipclasses do
        put 'migrate'
        put 'unmigrate'
      end
    resources :bipmonitors do
        put 'migrate'
        put 'unmigrate'
      end
    resources :bippools do
        put 'migrate'
        put 'unmigrate'
      end
    resources :biprules do
        put 'migrate'
        put 'unmigrate'
      end
    resources :bipnodes do
        put 'migrate'
        put 'unmigrate'
      end
  end
  
  match 'bip_configs/upload' => 'bip_configs#upload'

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
