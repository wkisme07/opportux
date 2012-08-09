Opportux::Application.routes.draw do
  devise_for :users, :controllers => {
    :sessions => "sessions",
    :registrations => "registrations",
    :passwords => "passwords",
    :omniauth_callbacks => "omniauth_callbacks"
  }

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  get '/p/:slug' => 'home#show', :as => 'detail'
  get '/p/:slug' => 'home#show', :as => 'home'
  get '/p/:slug/photo/:id' => 'home#photo', :as => 'photo'
  get '/business' => 'home#business', :as => 'business'
  get '/people' => 'home#people', :as => 'people'

  resources :home do
    collection do
      get   :photo
      get   :business
      get   :people
    end
  end

  get '/uploads' => 'posts#new', :as => 'new_post'
  get '/p/:slug/edit' => 'posts#edit', :as => 'edit_post'
  get '/p/review/:slug' => 'posts#review', :as => 'review_posts'
  get '/p/publish/:slug' => 'posts#publish', :as => 'publish_posts'
  get '/p/renew/:slug' => 'posts#renew', :as => 'renew_posts'
  get '/p/like/:slug' => 'posts#like', :as => 'like_posts'
  get '/p/report/:slug' => 'posts#report', :as => 'report_posts'

  resources :posts do
    collection do
      get   :report
      get   :like
      get   :renew
      get   :review
      get   :publish
      get   :autocomplete_tag_name
    end
  end


  get '/u/:slug' => 'users#show', :as => "user"
  get '/u/:slug/edit' => 'users#edit', :as => "edit_user"
  put '/u/:slug/update' => 'users#update', :as => "update_user"
  get '/u/:slug/draft' => 'users#draft', :as => "user_draft"

  resources :users, :only => [:show, :edit, :update] do
  end


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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
