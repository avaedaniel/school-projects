
Rails.application.routes.draw do
  resources :trips do
    resources :participants
    resources :expenses do
      member do
        get 'select_participants'
        patch 'update_participants'
      end
    end
    member do
      get 'settle'
    end
  end
  get "static_pages/home"
  resources :users
  resources :trips do
    resources :expenses
    member do
      get 'settle'
    end
    resources :participants
    resources :expenses do
      # Add route to select participants for an expense
      member do
        get 'select_participants'
        patch 'update_participants'
      end
    end
    resources :payments
  end
  resources :categories
  root "static_pages#home"
  get 'users', to: 'users#index'

end


