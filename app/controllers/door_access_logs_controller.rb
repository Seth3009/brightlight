class DoorAccessLogsController < ApplicationController
  before_action :sortable_columns
  def index
    authorize! :read, DoorAccessLog
    @item_per_pages = 20
    respond_to do |format|
      format.html {           
        if params[:direction]
          @logs = DoorAccessLog.loc_params(params[:loc])
            .order("#{sort_column} #{sort_direction}") 
            .order(:created_at => "desc")                
            .paginate(page: params[:page], per_page: @item_per_pages)
        else    
          @logs = DoorAccessLog.loc_params(params[:loc]).order(:created_at => "desc")
              .order("#{sort_column} #{sort_direction}")                 
              .paginate(page: params[:page], per_page: @item_per_pages)
        end
        if params[:search]
          @logs = DoorAccessLog.loc_params(params[:loc]).where('UPPER(door_access_logs.name) LIKE ?', "%#{params[:search].upcase}%")                
                .order(:created_at => "desc")
                .paginate(page: params[:page], per_page: @item_per_pages)
        end
        @locations = DoorAccessLog.select(:location).uniq.order(:location)
      }
      
    end   
  end

  private
  def sortable_columns     
    [:created_at, :name, :location, :kind ]
  end
end
