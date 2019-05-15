class StandardBooksController < ApplicationController
  before_action :set_standard_book, only: [:show, :edit, :update, :destroy]
#  before_action :sortable_columns, only: [:index]
  autocomplete :book_edition, :title,
    full: true,
    extra_data: [:book_title_id, :isbn10, :isbn13, :authors],
    display_value: :title_for_autocomplete,
    limit:50

  # GET /standard_books
  # GET /standard_books.json
  def index
    authorize! :read, StandardBook
    @items_per_page = 25
    
    @standard_books = StandardBook.all.includes([:book_title,:book_edition,:subject, :academic_year,:book_category])

    if params[:year].present?
      @academic_year = AcademicYear.find_by_id params[:year]
      @standard_books = @standard_books.where(academic_year:@academic_year) if params[:year].upcase != 'ALL'
    else
      @standard_books = @standard_books.where(academic_year:current_academic_year_id)
    end

    if params[:grade_level_id].present?
      @grade_level = GradeLevel.find params[:grade_level_id]
      @standard_books = @standard_books.where(grade_level:@grade_level)

      if params[:track].present?
        if params[:track].upcase != 'ALL'
          @track = params[:track]
          @standard_books = @standard_books.where(track:@track)
        end
      end
    end
    if params[:subject] && params[:subject] != 'all'
      @subject = Subject.find params[:subject]
      @standard_books = @standard_books.where(subject_id: params[:subject])
    end

    if params[:category].present? and params[:category].upcase != 'ALL'
      @category = BookCategory.find_by_code params[:category]
      @standard_books = @standard_books.where(book_category:@category)
    end

    # @standard_books = @standard_books.order("#{sort_column} #{sort_direction}") if params[:column].present?
    @standard_books = @standard_books.paginate(page: params[:page], per_page: @items_per_page)
    @starting_num = (@standard_books.current_page-1) * @items_per_page

    respond_to do |format|
      format.html
      format.json do
        @standard_books = @standard_books.to_a.uniq {|x| x.book_edition_id }
      end
    end 
  end

  # GET /standard_books/1
  # GET /standard_books/1.json
  def show
    authorize! :read, StandardBook
  end

  # GET /standard_books/new
  def new
    authorize! :manage, StandardBook
    @standard_book = StandardBook.new
    @grade_level = GradeLevel.find params[:grade_level_id]
    @academic_year = AcademicYear.where(id:params[:year]).take || AcademicYear.current
    @subjects = Subject.all
  end

  # GET /standard_books/1/edit
  def edit
    authorize! :update, StandardBook
    @grade_level = @standard_book.grade_level
    @academic_year = @standard_book.academic_year
    @subjects = Subject.all
  end

  # POST /standard_books
  # POST /standard_books.json
  def create
    authorize! :manage, StandardBook
    @standard_book = StandardBook.new(standard_book_params)

    respond_to do |format|
      if @standard_book.save
        format.html { redirect_to @standard_book, notice: 'Standard book was successfully created.' }
        format.json { render :show, status: :created, location: @standard_book }
        format.js
      else
        format.html {
          @academic_year = AcademicYear.find(params[:year]) || AcademicYear.current
          render :new
        }
        format.json { render json: @standard_book.errors, status: :unprocessable_entity }
        format.js { render :save_error }
      end
    end
  end

  # PATCH/PUT /standard_books/1
  # PATCH/PUT /standard_books/1.json
  def update
    authorize! :update, StandardBook
    respond_to do |format|
      if @standard_book.update(standard_book_params)
        format.html { redirect_to standard_books_path(grade_level_id:@standard_book.grade_level_id,year:@standard_book.academic_year.id, track:@standard_book.track), notice: 'Standard book was successfully updated.' }
        format.json { render :show, status: :ok, location: @standard_book }
      else
        format.html { 
          @grade_level = @standard_book.grade_level
          @academic_year = @standard_book.academic_year
          render :edit 
        }
        format.json { render json: @standard_book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /standard_books/1
  # DELETE /standard_books/1.json
  def destroy
    authorize! :destroy, StandardBook
    @standard_book.destroy
    respond_to do |format|
      format.html { redirect_to standard_books_url, notice: 'Standard book was successfully destroyed.' }
      format.json { head :no_content }
      format.js { head :no_content }
    end
  end

  # POST /standard_books/prepare.js
  def prepare
    authorize! :manage, StandardBook
    academic_year_id = params[:standard_book_year].to_i

    respond_to do |format|
      format.js do
        grade_levels = params[:initialize_standard_books].reject {|k,v| k == "all"}.keys
        if StandardBook.where(academic_year_id:academic_year_id, grade_level_id: grade_levels).count > 0
          @error = "Error: records are not empty for selected grade(s) in the academic year #{AcademicYear.find(academic_year_id).name}"
        else
          StandardBook.initialize_from_previous_year academic_year_id-1, academic_year_id, grade_levels
          @message = "Standard books initialized."
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_standard_book
      @standard_book = StandardBook.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def standard_book_params
      params.require(:standard_book).permit(:book_title_id, :book_edition_id, :book_category_id, :isbn, :refno, :quantity,  :subject_id, :grade_subject_code, :grade_name, :grade_level_id, :grade_section_id, :group, :category, :bkudid, :notes, :academic_year_id, :track)
    end

    # def sortable_columns 
    #   [:title, :subject_id, :category_id]
    # end

    # def sort_column    
    #   columns_to_sort = sortable_columns.map &:to_s
    #   case params[:column] 
    #   when 'title'
    #     'book_editions.title'
    #   when 'subject'
    #     'book_titles.subject_id'
    #   when 'book_category_id'
    #     'book_categories.name'
    #   else
    #     params[:column]
    #   end
    # end
end
