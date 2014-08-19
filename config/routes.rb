Rails.application.routes.draw do
  resources :woodchucks, :only => [:index, :show]
end
