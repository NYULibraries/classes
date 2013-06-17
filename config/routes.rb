Classes::Application.routes.draw do
  
  root :to => "catalog#index"
  
  post :create, :to => "catalog#create"
  get :create, :to => "catalog#index"
  post "create_suggestion" => "catalog#create_suggestion"
  get "suggest" => "catalog#new_suggestion"
  post "autofill_user_fields" => "catalog#autofill_user_fields"
  
  scope "admin" do
    post "class_dates/send_follow_up", :to => "class_dates#send_follow_up", :as => :send_follow_up
    delete "suggestions/destroy_all", :to => "suggestions#clear_suggestions", :as => :clear_suggestions
    delete "clear_users", :to => "users#clear_users"
    delete "destroy_registration", :to => "users#destroy_registration"
    match "populate_sub_categories_select", :to => "library_classes#populate_sub_categories_select", :via => [:post, :put]
    post "class_categories_sort", :to => "class_categories#sort"
    post "class_sub_categories_sort", :to => "class_sub_categories#sort"
    post "library_classes_sort", :to => "library_classes#sort"
    resources :library_classes do 
      post :sort, on: :collection
    end
    resources :class_dates 
    resources :class_categories do
      post :sort, on: :collection
    end
    resources :class_sub_categories do
      post :sort, on: :collection
    end
    resources :users
    resources :registrations
    resources :response_emails
    resources :application_details
    resources :suggestions
  end
  
  match 'login', :to => 'user_sessions#new', :as => :login
  match 'logout', :to => 'user_sessions#destroy', :as => :logout
  match 'validate', :to => 'user_sessions#validate', :as => :validate
  resources :user_sessions

end
