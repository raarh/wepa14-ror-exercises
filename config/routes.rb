Ratebeer::Application.routes.draw do
  resources :memberships

  resources :beer_clubs

  resources :users

  resources :beers

  resources :breweries

  resources :ratings, :only => [:index, :new, :create,:destroy]
  resources :sessions, :only => [:new, :create, :destroy]

  root 'breweries#index'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  resources :places, only:[:index, :show]
  post 'places', to:'places#search'


end
