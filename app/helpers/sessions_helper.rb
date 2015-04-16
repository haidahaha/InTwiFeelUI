module SessionsHelper
    def log_in(doctor)
        session[:doctor_id] = doctor.id
    end

    def current_doctor
        @current_doctor ||= Doctor.find_by(id: session[:doctor_id])
    end

    def logged_in?
        !current_doctor.nil?
    end

    def log_out
        session.delete(:doctor_id)
        @current_doctor = nil
    end
end
