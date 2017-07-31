Rails.application.routes.draw do
  root 'calculate#index'

  get 'calculate/index'
  post 'calculate/sum'
  post 'calculate/prod'
  post 'calculate/tr'
  post 'calculate/det'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
