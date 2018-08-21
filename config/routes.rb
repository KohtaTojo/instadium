Rails.application.routes.draw do
  get 'favorites/index'
  root 'pictures#index'
  devise_for 'users'
  resources 'pictures' do
    resources 'favorites', only: [:create, :destroy]
    resources 'thumbnails'
    resources 'comments', only: [:create, :destroy]
  end
  resources 'users'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
