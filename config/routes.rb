Rails.application.routes.draw do
  resources :logs, :only => [:index, :show]
end
