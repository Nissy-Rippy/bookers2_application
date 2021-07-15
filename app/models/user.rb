class User < ApplicationRecord
      has_many :books,dependent: :destroy
      attachment :profile_image
      validates :name,length: {minimum: 2}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
     devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
