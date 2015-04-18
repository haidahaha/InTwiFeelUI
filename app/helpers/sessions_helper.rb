module SessionsHelper
    def log_in(user_id, username, password)
        session[:user_id] = user_id
        session[:username] = username
        session[:password] = password
    end

    def logged_in?
        !session[:user_id].nil?
    end

    def log_out
        session.delete(:user_id)
        session.delete(:username)
        session.delete(:password)
    end
end
