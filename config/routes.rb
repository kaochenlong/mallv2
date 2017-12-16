Rails.application.routes.draw do
  resources :products, only: [:index, :show]

  resource :cart, only: [:show, :destroy] do
    collection do
      post :add, path:'add/:id'
      get :checkout
    end
  end

  resources :orders, only: [:create] do
    member do
      delete :cancel
    end
  end

  root "products#index"
end
