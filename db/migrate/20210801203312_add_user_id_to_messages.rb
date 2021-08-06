class AddUserIdToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :UserId, :integer
  end
end
