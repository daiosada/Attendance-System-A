class Attendance < ApplicationRecord
  belongs_to :user
  
  validates :worked_on, presence: true
  validates :note, length: { maximum: 50 }
  
  validate :finished_at_is_invalid_without_a_started_at
  validate :started_at_is_invalid_without_a_finished_at
  validate :started_at_than_finished_at_fast_if_invalid
  
  validate :changed_finished_at_is_invalid_without_a_changed_started_at
  validate :changed_started_at_is_invalid_without_a_changed_finished_at
  validate :changed_started_at_than_changed_finished_at_fast_if_invalid
  
  def finished_at_is_invalid_without_a_started_at
    errors.add(:started_at, "が必要です") if started_at.blank? && finished_at.present?
  end
  
  def started_at_is_invalid_without_a_finished_at
    unless worked_on == Date.current
      errors.add(:finished_at, "が必要です") if finished_at.blank? && started_at.present?
    end
  end
  
  def started_at_than_finished_at_fast_if_invalid
    if started_at.present? && finished_at.present?
      errors.add(:started_at, "より早い退勤時間は無効です") if started_at > finished_at
    end
  end
  
  def changed_finished_at_is_invalid_without_a_changed_started_at
    errors.add(:changed_started_at, "が必要です") if changed_started_at.blank? && changed_finished_at.present?
  end
  
  def changed_started_at_is_invalid_without_a_changed_finished_at
    unless worked_on == Date.current
      errors.add(:changed_finished_at, "が必要です") if changed_finished_at.blank? && changed_started_at.present?
    end
  end
  
  def changed_started_at_than_changed_finished_at_fast_if_invalid
    if changed_started_at.present? && changed_finished_at.present?
      errors.add(:changed_started_at, "より早い退勤時間は無効です") if changed_started_at > changed_finished_at
    end
  end
end
