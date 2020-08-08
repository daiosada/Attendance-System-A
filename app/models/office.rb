class Office < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :attendance, presence: true
end
