class Api::GatesController < Api::BaseController

  def create
    if params[:ip].present? && params[:id].present?
      @room = Room.where(ip_address:params[:ip]).first
      @badge = Badge.where(code:params[:id]).first
      if @badge.present? && @room.present?
        @room_access = RoomAccess.where(room_id:@room.id,badge_id:@badge.id).first
        if @badge.kind == "Employee"
          @employee = Employee.joins('left join badges on badges.employee_id = employees.id')
                    .select('employees.name as nama,badges.*')
                    .where(badges: {code: params[:id]}).first
          if (@employee.present? && @room_access.present?) || @room.public_access?
            DoorAccessLog.insert_door_log(@employee.employee_id, @employee.kind, params[:id],params[:loc],@employee.nama)            
            render json: "code:"+@employee.code + " name:" + @employee.nama + " kind:" + @employee.kind
            response.header["result"] = 'name:' + @employee.nama + ' kind:' + @employee.kind + '^'
            # @name_part = @employee.nama.split
            # response.header["code"] = @employee.code
            # response.header["name"] = @name_part[0]
            # response.header["kind"] = @employee.kind + '^'
          else
            #render json: "denied"
            render json: {errors:"Denied"}, status: :unprocessable_entity
            response.header["result"] = 'denied^'
          end        
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
          if (@student.present? && @room_access.present?)
            DoorAccessLog.insert_door_log(@student.student_id, @student.kind, params[:id],params[:loc],@student.name)
            render json: "code:"+@student.code + " name:" + @student.name + " kind:" + @student.kind
            response.header["result"] = 'name:' + @student.name + ' kind:' + @student.kind + '^'
            # @name_part = @student.name.split
            # response.header["code"] = @student.code
            # response.header["name"] = @name_part[0]
            # response.header["kind"] = @student.kind + '^'
          else
            render json: {errors:"Denied"}, status: :unprocessable_entity
            response.header["result"] = 'denied^'
          end
        end
      else
        if @badge.present? == false
          render json: "invalid"
          response.header["result"] = 'invalid^'
        else
          render json: "disconnect"
          response.header["result"] = 'disconnect^'
        end
      end            
    end
  end

  def tap
    if params[:ip].present? && params[:id].present?
      @room = Room.where(ip_address:params[:ip]).first
      @badge = Badge.where(code:params[:id]).first
      if @badge.present? && @room.present?
        @room_access = RoomAccess.where(room_id:@room.id, badge_id:@badge.id).first
        if @badge.kind == "Employee"
          @employee = @badge.employee
          if (@employee.present? && @room_access.present?) || @room.public_access?
            DoorAccessLog.insert_door_log(@employee.id, @badge.kind, params[:id], @room.location, @employee.name)            
            render json: {code: @badge.code, name: @employee.name, kind: @badge.kind}
          else
            render json: {errors:"Denied"}, status: :unprocessable_entity
          end        
        elsif @badge.kind == "Student"        
          @permit = ActivitySchedule.filter_day.permit_for_badge_id @badge.id                                                                       
          if (@permit.present? && @room_access.present?)
            DoorAccessLog.insert_door_log(@permit.student_id, @permit.kind, params[:id], @room.location, @permit.name)
            render json: {code: @permit.code, name: @permit.name, kind: @permit.kind}
          else
            render json: {errors:"Denied"}, status: :unprocessable_entity
          end
        else
          render json: {errors:"Invalid"}, status: :unprocessable_entity
        end
      else
        if @badge.present? == false
          render json: {errors:"Invalid"}, status: :unprocessable_entity
        else
          render json: {errors:"Disconnect"}, status: :unprocessable_entity
        end
      end            
    end
  end
end
