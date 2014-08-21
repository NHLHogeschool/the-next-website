class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :logged_in?, :upcoming_events_by_date

  def logged_in?
    session.key?(:logged_in)
  end

  def upcoming_events_by_date
    @upcoming_events_by_date ||= Event.upcoming_by_date
  end
end
