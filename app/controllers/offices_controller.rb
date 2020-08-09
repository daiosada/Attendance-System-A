class OfficesController < ApplicationController
  before_action :set_office, only: [:edit, :update, :destroy]
  before_action :sort_office, only: [:index, :new]
  
  def index
  end
  
  def new
    # num = 1
    max = Office.maximum(:office_id)
    # @offices.each do |office|
    # end
    @office = Office.new(office_id: max + 1)
  end
  
  def create
    @office = Office.new(office_params)
    if @office.save
      flash[:success] = "拠点情報を追加しました。"
      redirect_to offices_url
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @office.update_attributes(office_params)
      flash[:success] = "拠点情報を更新しました。"
      redirect_to offices_url
    else
      render :edit
    end
  end
  
  def destroy
  end
  
  private
    
    def set_office
      @office = Office.find(params[:id])
    end
    
    def sort_office
      @offices = Office.all.order(office_id: "ASC")
    end
    
    def office_params
      params.require(:office).permit(:office_id, :name, :attendance)
    end
end
