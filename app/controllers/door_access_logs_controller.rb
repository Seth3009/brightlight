class DoorAccessLogsController < ApplicationController
  before_action :sortable_columns
  def index
    authorize! :read, DoorAccessLog
    respond_to do |format|
      format.html {
        items_per_page = 20
        @logs = DoorAccessLog.loc_params(params[:loc])
            .order("#{sort_column} #{sort_direction}")            
            .paginate(page: params[:page], per_page: items_per_page)
        if params[:search]
          @logs = DoorAccessLog.loc_params(params[:loc]).where('UPPER(door_access_logs.name) LIKE ?', "%#{params[:search].upcase}%")       
        end
        @locations = DoorAccessLog.select(:location).uniq.order(:location)
      }
      
    end   
  end

  private
  def sortable_columns 
    [:created_at, :name, :location, :kind]
  end
end
