class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def reset
    Doctor.destroy_all
    Report.destroy_all
    Rails.application.load_seed
    redirect_to root_path
  end
end
