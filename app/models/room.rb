class Room < ApplicationRecord
  belongs_to :user
  has_many :photos
  has_many :reservations
  has_many :reviews

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  # 필터링할 욕의 종류
  words = ["shit", "fuck", "hell"]
  
  # 저장전에 실행
  before_save{ 
    words.each do |word| 
      len = word.length
      self.summary.gsub!(/#{word}/, '*'*len) if(self.summary.include?(word))
    end
  }


  validates :home_type, presence: true
  validates :room_type, presence: true
  validates :accommodate, presence: true
  validates :bed_room, presence: true
  validates :bath_room, presence: true
  validates :listing_name, presence: true, length: {maximum: 50}
  validates :summary, presence: true, length: {maximum: 500}
  validates :address, presence: true
  validates :price, presence: true

  def average_rating(key)
    reviews.count == 0 ? 0 : reviews.average(key).to_i.round(1)
  end
end
