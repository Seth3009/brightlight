class Api::GatesController < Api::BaseController

  def create
    if params[:id].present?
      @badge = Badge.where(code:params[:id]).select('badges.*').first
      if @badge.present?
        if @badge.kind = "Employee"
          @employee = Employee.joins('left join badges on badges.employee_id = employees.id')
                    .select('employees.*,badges.*').where(badges: {code: params[:id]}).first
          if @employee.present?
            DoorAccessLog.insert_door_log(@employee.employee_id, @employee.kind, params[:id],params[:loc],@employee.name)
            if params[:wifi].present?
              render json: "code:"+@employee.code + " name:" + @employee.name + " kind:" + @employee.kind
            else
              response.header["result"] = '{code:' + @employee.code + ' name:' + @employee.name + ' kind:' + @employee.kind + '}'
            end
          else
            now = Time.parse(Time.now.to_s)
            @year_id = AcademicYear.current_id
            if now < Time.parse("16:01")
              @student = Student.joins('left join badges on badges.student_id = students.id')
                        .select('students.*,badges.*').where(badges: {code: params[:id]}).first
            else
              @student = ActivitySchedule.filter_day
                        .joins('left join student_activities on student_activities.activity_schedule_id = activity_schedules.id')
                        .joins('left join students on students.id = student_activities.student_id')
                        .joins('left join badges on badges.student_id = students.id')
                        .select('students.*,badges.*,activity_schedules.academic_year_id').where(badges: {code: params[:id]}).first                                                
            end
            
            if @student.present?
              DoorAccessLog.insert_door_log(@student.student_id, @student.kind, params[:id],params[:loc],@student.name)
              if params[:wifi].present?
                render json: "code:"+@student.code + " name:" + @student.name + " kind:" + @student.kind
              else
                response.header["result"] = '{code:' + @student.code + ' name:' + @student.name + ' kind:' + @student.kind + '}'          
              end
            else
              if params[:wifi].present?
                render json: "{Invalid Card}"
              else
                response.header["result"] = '{Invalid Card}'
              end
            end
          end
        end
      else
        if params[:wifi].present?
          render json: "{Invalid Card}"
        else
          response.header["result"] = '{Invalid Card}'
        end
      end    
    end
  end
end
