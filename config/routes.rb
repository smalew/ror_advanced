Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'questions#index'

  resources :questions, only: %i[index new show create update destroy] do
    resources :answers, shallow: true, only: %i[create update destroy] do
      resources :attachments, shallow: true, only: %i[destroy]
      patch :choose_as_best, on: :member
    end

    resources :attachments, only: :destroy
  end
end
