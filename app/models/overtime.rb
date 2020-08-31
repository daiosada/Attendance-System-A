class Overtime < ApplicationRecord
  belongs_to :user
  
  validates :worked_on, presence: true
  validates :note, presence: true, length: { maximum: 50 }, allow_nil: true
end
