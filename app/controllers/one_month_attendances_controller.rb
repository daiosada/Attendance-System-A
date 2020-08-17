class OneMonthAttendancesController < ApplicationController
  before_action :set_user, only: [:show_one_month_attendances, :approve_one_month_attendances]
  before_action :set_one_month_attendances, only: :show_one_month_attendances
  before_action :set_statuses, only: :show_one_month_attendances
  
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
  
  def approve_one_month_attendances
    ActiveRecord::Base.transaction do
      one_month_attendances_params.each do |id, item|
        if item[:checked]
          one_month_attendance = OneMonthAttendance.find(id)
          one_month_attendance.update_attributes!(item)
        end
      end
    end
    flash[:success] = "1ヶ月分勤怠申請を承認しました。"
    redirect_to @user
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "承認に失敗しました。やり直してください。"
    redirect_to @user
  end
  
  private
    
    def one_month_attendances_params
      params.permit(one_month_attendances: [:status, :checked])[:one_month_attendances]
    end
    
    def set_statuses
      @statuses = {"なし": "なし",
                   "申請中": "申請中",
                   "承認": "承認",
                   "否認": "否認"}
    end
end
