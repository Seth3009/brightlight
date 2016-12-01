class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  # GET /subjects
  # GET /subjects.json
  def index
    authorize! :read, Subject
    respond_to do |format|
      format.html {
        items_per_page = 20
        if params[:search]
          @subjects = Subject.where('UPPER(name) LIKE ?', "%#{params[:search].upcase}%").paginate(page: params[:page], per_page: items_per_page).order(:name)
        else
          @subjects = Subject.paginate(page: params[:page], per_page: items_per_page).order(:name)
        end
      }
      
      format.csv {
        @subjects = Subject.all.order(:name)
        render text: @subjects.to_csv
      }
    end
    
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
    authorize! :read, Subject
    @subject = Subject.where(id: params[:id]).first
    @books = BookTitle.where(subject_id: @subject).all.order(:title)
  end

  # GET /subjects/new
  def new
    authorize! :create, Subject
    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit
    authorize! :update, Subject
  end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = Subject.new(subject_params)

    respond_to do |format|
      if @subject.save
        format.html { redirect_to subjects_url, notice: 'Subject was successfully created.' }
        format.json { render :show, status: :created, location: @subject }
        format.js
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to subjects_url, notice: 'Subject was successfully updated.' }
        format.json { render :show, status: :ok, location: @subject }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_url, notice: 'Subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(:subject).permit(:code, :name, :description)
    end
end
