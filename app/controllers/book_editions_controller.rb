class BookEditionsController < ApplicationController
  before_action :set_book_edition, only: [:show, :edit, :update, :destroy]

  # GET /book_editions
  # GET /book_editions.json
  def index
    if params[:v] == 'list'
      items_per_page = 20
      @view_style = :list
      session[:view_style] = 'list'
    else
      items_per_page = 10
      @view_style = :block
      session[:view_style] = ''
    end
    
    if params[:search]
      @book_editions = BookEdition.search_query(params[:search]).paginate(page: params[:page], per_page: items_per_page)
    else
      @book_editions = BookEdition.paginate(page: params[:page], per_page: items_per_page)
    end
  end

  # GET /book_editions/1
  # GET /book_editions/1.json
  def show
  end

  # GET /book_editions/new
  def new
    @book_edition = BookEdition.new
  end

  # GET /book_editions/1/edit
  def edit
  end

  # POST /book_editions
  # POST /book_editions.json
  def create
    @book_edition = BookEdition.new(book_edition_params)

    respond_to do |format|
      if @book_edition.save
        nested_form = book_edition_params[:book_copies_attributes].present?
        format.html { redirect_to nested_form ? book_edition_book_copies_path(@book_edition) : @book_edition, notice: 'Book edition was successfully created.' }
        format.json { render :show, status: :created, location: @book_edition }
      else
        format.html { render :new }
        format.json { render json: @book_edition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /book_editions/1
  # PATCH/PUT /book_editions/1.json
  def update
    respond_to do |format|
      if @book_edition.update(book_edition_params)
        nested_form = book_edition_params[:book_copies_attributes].present?
        format.html { redirect_to nested_form ? book_edition_book_copies_path(@book_edition) : @book_edition, notice: 'Book edition was successfully updated.' }
        format.json { render :show, status: :ok, location: @book_edition }
      else
        format.html { render :edit }
        format.json { render json: @book_edition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_editions/1
  # DELETE /book_editions/1.json
  def destroy
    @book_edition.destroy
    respond_to do |format|
      format.html { redirect_to book_editions_url, notice: 'Book edition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_edition
      @book_edition = BookEdition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_edition_params
      params.require(:book_edition).permit(
        :google_book_id, :isbndb_id, :title, :subtitle, :authors, :publisher, :published_date,
        :description, :isbn10, :isbn13, :page_count, :small_thumbnail, :thumbnail, 
        :language, :edition_info, :tags, :subjects, :book_title_id,
        {:book_copies_attributes => [:id, :book_edition_id, :book_condition_id, :status_id, :barcode, :copy_no, :_destroy]}
      )
    end
end
