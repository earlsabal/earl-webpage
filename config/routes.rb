Rails.application.routes.draw do

  root 'pages#home'
  
  resource :admin_session

  resources :posts do
    resources :comments
  end

  resources :admin_sessions

  get '/home' => 'pages#home'
  get '/about' => 'pages#about'

end