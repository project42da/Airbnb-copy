class Contact < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, scope: :recipient_id

  scope: :involving, -> (user) do
    where("contacts.sender_id = ? OR contacts.recipient_id = ?", user.id, user.id)
  end
  # 위의 기능은 아래와 같다.
  # def self.involving(user)
  #   where("contacts.sender_id = ? OR contacts.recipient_id = ?", user.id, user.id)
  # end

  # Contact.involving(current_user)

  # sender, recipient 사이의 contact가 있었는지 확인
  scope: :between, -> (sender_id, recipient_id) do
    where("(contacts.sender_id = ? AND contacts.recipient_id = ?) OR (contacts.sender_id = ? AND contacts.recipient_id = ?)",
      sender_id, recipient_id, recipient_id, sender_id)
  end
end
