case Rails.env
when "development"
    REST_SERVER_URI = "http://127.0.0.1:8080"
when "production"
    REST_SERVER_URI = ""
end