class NatExamsController < ApplicationController
  before_action :set_nat_exam, only: [:show, :edit, :update, :destroy]

  # GET /nat_exams
  # GET /nat_exams.json
  def index
    @students = NatExam.students(academic_year: AcademicYear.current)
  end

  # GET /nat_exams/1
  # GET /nat_exams/1.json
  def scores
    @exam_scores = NatExam.for_academic_year(AcademicYear.current_id).scores_for student_id: params[:student_id]
    @avg_pilihan = @exam_scores.avg_pilihan.take
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
    @exam_scores = NatExam.for_academic_year @academic_year.id
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
