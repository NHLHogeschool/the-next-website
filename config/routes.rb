Rails.application.routes.draw do
  root to: 'posts#index'

  resources :posts, path: 'berichten'
  get 'handboek' => 'static_pages#guide', as: :guide

  # Calendar
  get 'google_calendar' => redirect('https://www.google.com/calendar/embed?src=mo7vph6l2neh6m3bcju1ncon4k@group.calendar.google.com&ctz=Europe/Amsterdam'), as: :google_calendar
  get 'auth/google_oauth2/callback' => 'static_pages#callback'
end
