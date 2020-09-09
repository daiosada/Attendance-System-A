class OvertimesController < ApplicationController
  before_action :set_user, only: [:show_overtime, :apply_overtime, :show_overtimes, :confirm_overtime]
  before_action :set_superiors, only: :show_overtime
  before_action :set_overtime, only: [:show_overtime, :confirm_overtime]
  before_action :set_overtimes, only: [:show_overtimes, :confirm_overtime]
  before_action :set_statuses, only: [:show_overtime, :show_overtimes, :confirm_overtime]
  
  def show_overtime
  end
  
  def apply_overtime
    ActiveRecord::Base.transaction do
      overtime_params.each do |id, item|
        overtime = Overtime.find(id)
        unless item[:approver].blank?
          if overtime.update_attributes!(item)
            overtime.update_attributes!(status: "申請中", checked: false)
            flash[:success] = "#{l(overtime.worked_on, format: :short)}の残業を申請しました。"
          end
        end
      end
      redirect_to current_user
    end
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "申請に失敗しました。やり直してください。"
    redirect_to current_user
  end
  
  def show_overtimes
  end
  
  def approve_overtimes
    ActiveRecord::Base.transaction do
      overtime_params.each do |id, item|
        if item[:checked]
          overtime = Overtime.find(id)
          if item[:status] == "承認"
            overtime.update_attributes!(item)
            flash[:success] = "残業申請を承認しました。"
          elsif item[:status] =="否認"
            overtime.update_attributes!(item)
            flash[:danger] = "残業申請を否認しました。"
          else
            overtime.update_attributes!(item)
          end
        else
          unless item[:checked] == "申請中"
            flash[:danger] = "確認欄にチェックを入れてください。"
          end
        end
      end
      redirect_to current_user
    end
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "承認に失敗しました。やり直してください。"
    redirect_to current_user
  end
  
  def confirm_overtime
  end
  
  private
    
    def overtime_params
      params.permit(overtimes: [:will_finish, :next_day, :status, :note, :approver, :checked])[:overtimes]
    end
end
