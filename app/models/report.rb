class Report < ActiveRecord::Base
  belongs_to :doctor
  has_many :photos, dependent: :destroy
  accepts_nested_attributes_for :photos
  has_many :records, dependent: :destroy
end
