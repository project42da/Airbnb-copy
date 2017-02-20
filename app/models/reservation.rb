class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  #start_date는 end_date보다 무조건 빠른 날짜여야한다.
  validates :start_date, date: { before: :end_date }, presence: true
  #end_date는 start_date와 같거나 나중 날자여야한다(하지만 당연히 잘못되어있다는걸 알아서 알아주길)
  validates :end_date, date: { after_or_equal_to: :start_date}, presence: true
end
