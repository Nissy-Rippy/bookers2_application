class Message < ApplicationRecord
  after_create_commit { MessageBroadcastJob.perform_later self }
  validates :message,length: {maximum: 140}
end
