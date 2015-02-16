Rails.application.routes.draw do
  root to: 'static_pages#guide'

  resources :posts, path: 'berichten', only: [:show, :index]
  get '/feed' => 'posts#index', as: :feed, defaults: { format: :atom }

  get 'handboek' => 'static_pages#guide', as: :guide

  get '/admin' => 'admin/posts#index', as: :admin
  namespace :admin do
    resources :posts
  end

  # Calendar
  get 'google_calendar' => redirect('https://www.google.com/calendar/embed?src=mo7vph6l2neh6m3bcju1ncon4k@group.calendar.google.com&ctz=Europe/Amsterdam'), as: :google_calendar
  get 'auth/google_oauth2/callback' => 'static_pages#callback'
end
