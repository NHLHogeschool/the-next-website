Rails.application.routes.draw do
  root to: 'posts#index'
  get 'handboek' => 'static_pages#guide', as: :guide
  resources :posts, path: 'berichten'
end
