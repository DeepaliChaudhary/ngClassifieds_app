Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations'}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  ## create only route for cutom methods inside users resource
  namespace :users do
      post 'login_user'
  end
  #resources :users, only: [:index, :new, :create]

  match '/login_user' => 'users#login_user', :constraints => {:method => 'OPTIONS'}, via: [:options]

  resources :classifieds do
    member do 
        delete 'delete_classified'
    end
  end
  match '/classifieds/:id' => 'classifieds#update', :constraints => {:method => 'OPTIONS'}, via: [:options]
  match '/classifieds/:id/delete_classified' => 'classifieds#delete_classified', :constraints => {:method => 'OPTIONS'}, via: [:options]
  root 'users#index'


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
