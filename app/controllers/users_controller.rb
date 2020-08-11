class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :admin_or_correct_user, only: [:show, :edit, :update]
  before_action :admin_user, only: [:index, :destroy, :edit_basic_info, :update_basic_info]
  before_action :set_one_month, only: :show
  before_action :set_superiors, only: :show
  before_action :set_one_month_attendance, only: :show
  
  def index
    @users = User.paginate(page: params[:page]).search(params[:search])
  end
  
  def show
    @worked_sum = @attendances.where.not(started_at: nil).count
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "新規作成に成功しました。"
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to users_url
    else
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end
  
  def import
    if User.import(params[:file])
      flash[:success] = "ユーザを追加しました。"
      redirect_to users_url
    else
      flash[:danger] = "ユーザの追加に失敗しました。"
      redirect_to users_url
    end
  end
  
  def edit_basic_info
  end
  
  def update_basic_info
    if @user.update_attributes(basic_info_params)
      users = User.all
      users.each do |user|
        user.update_attributes(basic_info_params)
      end
      flash[:success] = "基本情報を更新しました。"
    else
      flash[:danger] = "基本情報の更新は失敗しました。<br>" + @users.errors.full_messsages.join("。<br>")
    end
    redirect_to edit_basic_info_user_url
  end
  
  def show_employees_at_work
    @attendances = Attendance.where(worked_on: Date.current).where.not(started_at: nil).where(finished_at: nil)
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :affiliation, :password, :password_confirmation)
    end
    
    def basic_info_params
      params.require(:user).permit(:basic_work_time, :designated_work_start_time, :designated_work_end_time)
    end
end