class Doctor < ActiveRecord::Base
    mount_uploader :photo, PhotoUploader
    has_many :reports, dependent: :destroy
    has_secure_password
end
