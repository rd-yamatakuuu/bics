class Speciality < ApplicationRecord

  has_many :user_specialities, dependent: :destroy
end
