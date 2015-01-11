Rails.application.routes.draw do

  root 'recipes#index'
  get 'search/' => 'recipes#search'

end
