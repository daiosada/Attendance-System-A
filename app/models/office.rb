class Office < ApplicationRecord
  validates :office_id, presence: true, uniqueness: true, numericality: { only_integer: true, greater_than_or_equal_to: 1}
  validates :name, presence: true, length: { maximum: 50 }
  validates :attendance, presence: true
end
