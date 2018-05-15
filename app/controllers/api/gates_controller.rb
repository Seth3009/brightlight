class Api::GatesController < Api::BaseController

  def create
    if params[:id].present?
      @badge = Badge.where(code:params[:id]).select('badges.*').first
      if @badge.present?
        if @badge.kind = "Employee"
          @employee = Employee.joins('left join badges on badges.employee_id = employees.id')
                    .select('employees.name as nama,badges.*')
                    .where(badges: {code: params[:id]}).first
          if @employee.present?
            DoorAccessLog.insert_door_log(@employee.employee_id, @employee.kind, params[:id],params[:loc],@employee.nama)            
              render json: "code:"+@employee.code + " name:" + @employee.nama + " kind:" + @employee.kind
          else
            now = Time.parse(Time.now.to_s)
            @year_id = AcademicYear.current_id           
              @student = ActivitySchedule.filter_day
                        .joins('left join student_activities on student_activities.activity_schedule_id = activity_schedules.id')
                        .joins('left join students on students.id = student_activities.student_id')
                        .joins('left join badges on badges.student_id = students.id')
                        .select('students.name,badges.code, badges.student_id, badges.kind, activity_schedules.academic_year_id')
                        .where(is_active:true)
                        .where(badges: {code: params[:id]}).first                                                                        
            if @student.present?
              DoorAccessLog.insert_door_log(@student.student_id, @student.kind, params[:id],params[:loc],@student.name)
                render json: "code:"+@student.code + " name:" + @student.name + " kind:" + @student.kind
            else
              render json: "{Invalid Card}"
            end
          end
        end
      else        
          render json: "{Invalid Card}"
      end    
    end
  end
end
