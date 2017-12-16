Rails.application.routes.draw do
  resources :products, only: [:index, :show]

  resource :cart, only: [:show, :destroy] do
    collection do
      post :add, path:'add/:id'
    end
  end

  root "products#index"
end
