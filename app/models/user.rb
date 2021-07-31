class User < ApplicationRecord
      
      def self.search(search,word)
            
            if search == "forward_match"
                  @user = User.where("name LIKE?","#{word}%")
            elsif search == "backword_match"
                  @user = User.where("name LIKE?","%#{word}")
            elsif search == "perfect_match"
                  @user = User.where("name LIKE?","#{word}")
            elsif search == "partial_match"
                  @user = User.where("name LIKE?","%#{word}%")
            else
                  User.all
            end

      end
      
      
      
      def follow(user_id)
            relationships.create(followed_id: user_id)
      end 

      def unfollow(user_id)
            relationships.find_by(followed_id: user_id).destroy
      end

      def followings?(user)
            followings.include?(user)
      end


      has_many :books,dependent: :destroy
      has_many :favorites,dependent: :destroy
      has_many :post_coments,dependent: :destroy 
      
      has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
      has_many :followers, through: :reverse_of_relationships, source: :follower
      has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
      has_many :followings, through: :relationships, source: :followed

      attachment :profile_image
      validates :name,length: {minimum: 2,maximum: 20},uniqueness: true
      validates :introduction,length:{maximum: 50}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
      devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
end
