Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



  resources :customers do
    collection do
      post :create_customer
    end
  end

  put 'customers/update/:id', :to => "customers#update"
  get 'customers', :to => "customers#index"
  get 'customers/:id', :to => "customers#show"
  delete 'customers/:id', :to => "customers#destroy"
end
