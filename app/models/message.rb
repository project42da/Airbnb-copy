class Message < ApplicationRecord
  belongs_to :contact
  belongs_to :user

  validates_presence_of :content, :contact_id, :user_id

  def message_time
    created_at.strftime("%m월 %d일")
  end
end
