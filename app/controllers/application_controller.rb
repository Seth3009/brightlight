class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  helper_method :current_user
  helper_method :sort_column, :sort_direction
  helper_method :unread_messages

  layout :layout_by_controller
  before_action :set_current_academic_year

  # Authorization using CanCanCan gem
  include CanCan::ControllerAdditions

  # Uncomment the next line to ensure authorization check for every single controller acion
  # check_authorization
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { render nothing: true, status: :forbidden }
      format.html { redirect_to root_url, :alert => exception.message }
      format.js   { 
        render js: "Materialize.toast('You are not authorized to perform that operation.', 4000, 'red');"
      }
    end
  end
  before_action :configure_permitted_parameters, if: :devise_controller?

  def layout_by_controller
    if params[:controller] =~ /users.*/ || params[:controller] =~ /devise\/.*/
      'user'
    elsif params[:controller] == 'welcome'
      'home'
    else
      "application"
    end
  end

  def set_current_academic_year
    AcademicYear.current_id = session[:year_id] || AcademicYear.current.id
    AcademicYear.current_name = session[:year] || AcademicYear.current.name
    session[:year_id] ||= AcademicYear.current_id
    session[:year] ||= AcademicYear.current_name
  end

  def current_academic_year_id
  	session[:year_id] ||= AcademicYear.current_id
  end

  # rescue_from (ActiveRecord::RecordNotFound) { |exception| handle_exception(exception, 404) }
  
  def sort_column    
    columns_to_sort = sortable_columns.map &:to_s
    columns_to_sort.include?(params[:column]) ? params[:column] : columns_to_sort.first
  end

  def sort_direction    
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end 

  def unread_messages
    Message.all.unread(current_user).includes(:creator)
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  # def current_user
  #   User.find  1 #35 #75 # 1 #
  # end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up)  { |u| u.permit(  :email, :password, :password_confirmation, roles: [] ) }
    end

end
