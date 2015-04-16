class SessionsController < ApplicationController
  def new
  end

  def create
    doctor = Doctor.find_by(email: params[:session][:email].downcase)
    if doctor && doctor.authenticate(params[:session][:password])
      log_in doctor
      redirect_to doctor
    else
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
