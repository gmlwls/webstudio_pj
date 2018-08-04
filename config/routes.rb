Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'books#index'
  get 'books/find', as: 'books_find'

  get '/mypage', to: 'books#mypage', as: 'mypage'
  
  resources :books do
  	post '/like', to: 'books#like_toggle'
    post '/sell', to: 'books#sell'
    resources :comments, only: [:create, :destroy, :edit, :update] do
      resources :replies, only: [:new, :create, :destroy, :edit, :update]
    end
  end
  resources :conversations, only: [:create] do
  	member do
  		post :close
  	end
  	resources :messages, only: [:create]
  end
  get '/new_notifications/read_all' => 'new_notifications#read_all'
  resources :new_notifications
end
