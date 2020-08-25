class OvertimesController < ApplicationController
  before_action :set_user, only: :show_overtime
  before_action :set_superiors, only: :show_overtime
  before_action :set_overtime, only: [:show_overtime, :apply_overtime]
  
  def show_overtime
    # debugger
  end
  
  def apply_overtime
    # debugger
  end
  
  def show_overtimes
  end
  
  def approve_overtimes
  end
  
  private
    
    def overtime_params
    end
end
