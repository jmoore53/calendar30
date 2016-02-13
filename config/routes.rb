Rails.application.routes.draw do
  
  get 'feed' => 'user#feed'
  get 'signup' => 'user#new'
  get 'index' => 'user#index'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'service_agreement' => 'static_pages#serviceAgreement'
  get 'contact' => 'static_pages#contact'

  #Gets users based on profile number
  get 'user/:id' => 'user#show'

  resources :schedule_event
  #resources :group
  get 'group' => 'group#index'
  #match 'user/:firstN', to: 'user#show', via: [:get, :post], :constrain => { :username => /[a-zA-Z-]+/ }
  
  resources :user do 
    member do
      get :following, :followers
    end
  end

  
  get 'schedule/:id' => 'user#schedule'
  #resources :schedule_event, only: [:create, :edit, :update, :destroy]
  resources :relationships,       only: [:create, :destroy]
  root 'static_pages#home'
end
