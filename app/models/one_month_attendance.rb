class OneMonthAttendance < ApplicationRecord
  belongs_to :user
  
  validates :month, presence: true
end
