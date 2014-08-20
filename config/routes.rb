Rails.application.routes.draw do
  root to: 'posts#index'
  get 'handboek' => 'static_pages#guide', as: :guide
  get 'auth/google_oauth2/callback' => 'static_pages#callback'
  resources :posts, path: 'berichten'
end
