module SessionsHelper
    def log_in(user_id)
        session[:user_id] = user_id
    end

    def current_doctor
        @current_doctor ||= Doctor.find_by(id: session[:doctor_id])
    end

    def logged_in?
        !current_doctor.nil?
    end

    def log_out
        session.delete(:user_id)
        @current_doctor = nil
    end
end
