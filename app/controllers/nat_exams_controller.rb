class NatExamsController < ApplicationController
  before_action :set_nat_exam, only: [:show, :edit, :update, :destroy]

  # GET /nat_exams
  # GET /nat_exams.json
  def index
    @students = NatExam.students academic_year: AcademicYear.current
  end

  # GET /nat_exams/1
  # GET /nat_exams/1.json
  def show
  end

  # GET /nat_exams/new
  def new
    @nat_exam = NatExam.new
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
