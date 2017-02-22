class Message < ApplicationRecord
  belongs_to :contact
  belongs_to :user

  validates_presence_of :content, :contact_id, :user_id

  def message_time
    created_at.strftime("%v")
    # 주단위
  end
end
