class OneMonthAttendancesController < ApplicationController
  before_action :set_user, only: [:show_one_month_attendances, :show_one_month_attendance, :approve_one_month_attendances]
  before_action :set_one_month, only: [:show_one_month_attendance]
  before_action :set_one_month_attendances, only: :show_one_month_attendances
  before_action :set_one_month_attendance, only: :show_one_month_attendance
  before_action :set_statuses, only: [:show_one_month_attendances, :show_one_month_attendance]
  
  def update
    @user = User.find(params[:user_id])
    @one_month_attendance = OneMonthAttendance.find(params[:id])
    approver = params[:one_month_attendance][:approver]
    if approver.blank?
      flash[:danger] = "所属長を選択してください。"
    else
      if @one_month_attendance.update_attributes(approver: approver, status: "申請中", checked: false)
        flash[:success] = "#{@one_month_attendance.month.month}月分の勤怠承認を申請しました。"
      else
        flash[:danger] = "申請に失敗しました。やり直してください。"
      end
    end
    redirect_to @user
  end
  
  def show_one_month_attendances
  end
  
  def show_one_month_attendance
  end
  
  def approve_one_month_attendances
    ActiveRecord::Base.transaction do
      one_month_attendances_params.each do |id, item|
        one_month_attendance = OneMonthAttendance.find(id)
        if item[:checked]
          if item[:status] == "承認"
            one_month_attendance.update_attributes!(item)
            flash[:success] = "1ヶ月分勤怠申請を承認しました。"
          elsif item[:status] == "否認"
            one_month_attendance.update_attributes!(item)
            flash[:danger] == "1ヶ月分勤怠申請を否認しました。"
          else
            one_month_attendance.update_attributes!(item)
          end
        else
          unless item[:status] == "申請中"
            flash[:danger] = "確認欄にチェックを入れてください。"
          end
        end
      end
    end
    redirect_to current_user
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "承認に失敗しました。やり直してください。"
    redirect_to current_user
  end
  
  private
    
    def one_month_attendances_params
      params.permit(one_month_attendances: [:status, :checked])[:one_month_attendances]
    end
end
