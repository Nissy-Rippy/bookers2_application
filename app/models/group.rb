class Group < ApplicationRecord
      attachment :image
      has_many :group_users,dependent: :destroy

      def grouped_by?(user)
          group_users.where(user_id: user.id).exists?
      end

end
