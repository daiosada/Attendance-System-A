class OvertimesController < ApplicationController
  before_action :set_user, only: [:show_overtime, :apply_overtime, :show_overtimes]
  before_action :set_superiors, only: :show_overtime
  before_action :set_overtime, only: [:show_overtime, :apply_overtime]
  before_action :set_overtimes, only: :show_overtimes
  before_action :set_statuses, only: :show_overtimes
  
  def show_overtime
  end
  
  def apply_overtime
    if @overtime.update_attributes(overtime_params)
      @overtime.update_attributes(status: "申請中")
      flash[:success] = "#{l(@overtime.worked_on, format: :short)}の残業を申請しました。"
    else
      flash[:danger] = "申請に失敗しました。やり直してください。"
    end
    redirect_to @user
  end
  
  def show_overtimes
  end
  
  def approve_overtimes
  end
  
  private
    
    def overtime_params
      params.require(:user).permit(:will_finish, :next_day, :note, :approver)
    end
end
