Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :request_logs, only: %i[index]

  namespace :api do
    namespace :v1 do
      resources :notes, only: %i[index show create update destroy]
    end
  end
end
