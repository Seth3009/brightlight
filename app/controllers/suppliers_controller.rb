class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :edit, :update, :destroy]

  # GET /suppliers
  # GET /suppliers.json
  def index
    authorize! :read, Supplier
    @suppliers = Supplier.all.order(:company_name)
  end

  # GET /suppliers/1
  # GET /suppliers/1.json
  def show
    authorize! :read, Supplier
  end

  # GET /suppliers/new
  def new
    authorize! :create, Supplier
    @supplier = Supplier.new
  end

  # GET /suppliers/1/edit
  def edit
    authorize! :update, Supplier
  end

  # POST /suppliers
  # POST /suppliers.json
  def create
    authorize! :create, Supplier
    @supplier = Supplier.new(supplier_params)

    respond_to do |format|
      if @supplier.save
        format.html { redirect_to suppliers_url, notice: 'Supplier was successfully created.' }
        format.json { render :show, status: :created, location: @supplier }
      else
        format.html { render :new }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suppliers/1
  # PATCH/PUT /suppliers/1.json
  def update
    authorize! :update, Supplier
    respond_to do |format|
      if @supplier.update(supplier_params)
        format.html { redirect_to suppliers_url, notice: 'Supplier was successfully updated.' }
        format.json { render :show, status: :ok, location: @supplier }
      else
        format.html { render :edit }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suppliers/1
  # DELETE /suppliers/1.json
  def destroy
    authorize! :destroy, Supplier
    @supplier.destroy
    respond_to do |format|
      format.html { redirect_to suppliers_url, notice: 'Supplier was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /import
  def import
    authorize! :create, Supplier
    uploaded_io = params[:filename] 
    path = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
    File.open(path, 'wb') do |file|
      file.write(uploaded_io.read)
      if uploaded_io.content_type =~ /office.xlsx/
        Supplier.import_xlsx(file)
        redirect_to suppliers_path, notice: "Import succeeded"
      else
        redirect_to suppliers_path, alert: 'Import failed: selected file is not an Excel file'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplier
      @supplier = Supplier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supplier_params
      params.require(:supplier).permit(:company_name, :contact_name, :address1, :address2, :city, :province, :post_code, :country, :phone, :mobile, :email, :website, :notes, :logo, :category, :status, :type, :group)
    end
end
