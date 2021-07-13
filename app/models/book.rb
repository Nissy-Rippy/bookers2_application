class Book < ApplicationRecord
    has_many :users,dependent: :destroy
    
    
    validates :title, presence: true
    validates :body,presence: true
end
