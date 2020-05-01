class NatExamsController < ApplicationController
  before_action :set_nat_exam, only: [:show, :edit, :update, :destroy]

  # GET /nat_exams
  # GET /nat_exams.json
  def index
    @academic_year = AcademicYear.current
    @students = NatExam.students(academic_year: @academic_year)
  end

  # GET /nat_exams/1
  # GET /nat_exams/1.json
  def scores
    @student = Student.find params[:student_id]
    @exam_scores = NatExam.detail_scores_for student_id: params[:student_id], academic_year_id: AcademicYear.current_id
  end

  def export
    @academic_year = AcademicYear.find(params[:year]) || AcademicYear.current
    students = NatExam.students(academic_year: @academic_year)
    @scores = []
    students.each do |student|
      @scores << NatExam.detail_scores_for(student_id: student.id, academic_year_id: @academic_year.id)
    end
    attributes = %w{name section course_id course sem1 sem2 sem3 sem4 sem5 avg}
    csv_data = CSV.generate(headers: true) do |csv|
      csv << %w{Name Class No Course Sem1 Sem2 Sem3 Sem4 Sem5 Avg}
      @scores.each do |student_score|
        student_score.each do |score|
          csv << attributes.map{ |attr| score.send(attr) }
        end
      end
    end
    respond_to do |format|
      format.csv { send_data csv_data, filename: "data.csv" }
      format.xls
    end
  end

  # GET /nat_exams/new
  def new
    @exam_scores = NatExam.new
  end

  def letter_ii
    @academic_year = AcademicYear.find params[:year] || AcademicYear.current
    @students = []
    @template = Template.where(target:'to_ii_letter').where(active:'true').take
    if params[:student_id].present?
      @students << Student.find(params[:student_id])
    else
      @students = NatExam.students(academic_year: @academic_year)
    end
  end

  def letter_of_grad
    @academic_year = AcademicYear.find params[:year] || AcademicYear.current
    @students = []
    @template = Template.where(target:'letter_of_grad').where(active:'true').take  
      
    if params[:student_id].present?
      @students << Student.find(params[:student_id])
      
      @diknas_ipa = DiknasConverted
        .joins("left join diknas_converted_items on diknas_converted_items.diknas_converted_id = diknas_converteds.id")
        .joins("left join diknas_conversions on diknas_conversions.id = diknas_converted_items.diknas_conversion_id")
        .joins("left join diknas_courses on diknas_courses.id = diknas_conversions.diknas_course_id")
        .where(diknas_converteds: {student_id: params[:student_id], academic_year_id: @academic_year}, diknas_courses: {name:"FISIKA"})
      
                

      @ipa = @diknas_ipa.first
      # @fisika = @nat_exam.map {|p| p.course}.any? {|s| s.upcase.include?('FISIKA')}
      
      if @ipa
        @nat_exam = NatExam.detail_scores_for_sk_ipa(student_id: params[:student_id], academic_year_id:@academic_year.id)
        @program = "ILMU PENGETAHUAN ALAM"
      else
        @nat_exam = NatExam.detail_scores_for_sk_ips(student_id: params[:student_id], academic_year_id:@academic_year.id)
        @program = "ILMU PENGETAHUAN SOSIAL"
      end
      @rata = @nat_exam.map {|p| p.avg}.sum / @nat_exam.size
    else
      @students = NatExam.students(academic_year: @academic_year)
    end
  end

  # GET /nat_exams/1/edit
  def edit
  end

  # POST /nat_exams
  # POST /nat_exams.json
  def create
    @nat_exam = NatExam.new(nat_exam_params)

    respond_to do |format|
      if @nat_exam.save
        format.html { redirect_to @nat_exam, notice: 'Nat exam was successfully created.' }
        format.json { render :show, status: :created, location: @nat_exam }
      else
        format.html { render :new }
        format.json { render json: @nat_exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nat_exams/1
  # PATCH/PUT /nat_exams/1.json
  def update
    respond_to do |format|
      if @nat_exam.update(nat_exam_params)
        format.html { redirect_to @nat_exam, notice: 'Nat exam was successfully updated.' }
        format.json { render :show, status: :ok, location: @nat_exam }
      else
        format.html { render :edit }
        format.json { render json: @nat_exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nat_exams/1
  # DELETE /nat_exams/1.json
  def destroy
    @nat_exam.destroy
    respond_to do |format|
      format.html { redirect_to nat_exams_url, notice: 'Nat exam was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /import
  def import
    authorize! :create, NatExam
    uploaded_io = params[:filename] 
    path = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
    File.open(path, 'wb') do |file|
      file.write(uploaded_io.read)
      if uploaded_io.content_type =~ /office.xlsx/ || uploaded_io.content_type =~ /officedocument/
        begin
          NatExam.import_to_ii_scores(xlsx_file:file, sheet:params[:sheet], academic_year_id:params[:academic_year_id])
        rescue  StandardError => e
          puts "Rescued: #{e.inspect}"
          redirect_to nat_exams_path, alert: e.inspect
          return
        end
        redirect_to nat_exams_url, notice: "Import succeeded"
      else
        redirect_to nat_exams_url, alert: 'Import failed: selected file is not an Excel file'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nat_exam
      @nat_exam = NatExam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nat_exam_params
      params.require(:nat_exam).permit(:student_id, :grade_level_id, :academic_year_id, :diknas_course_id, :try_out_1, :try_out_2, :try_out_3, :ujian_sekolah, :nilai_sekolah, :ujian_nasional)
    end
end
