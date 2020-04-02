Rails.application.routes.draw do
  devise_for :users

  root 'attachments#index'

  resources :attachments, except: [:edit, :update, :show]

  resources :attachments, only: :show, param: :code
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
