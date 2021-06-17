class Contact < ApplicationRecord
  
  validates :name, presence: true
  validates :email, presence: true
  validates :contact_message, presence: true, length: {maximum: 300 }
  
end
