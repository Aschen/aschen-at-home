class DocumentsController < ApplicationController
  before_action :set_document, only: [:edit, :update, :destroy]
  before_action :set_user_folders, only: [:new, :edit]
  before_action :set_document_folder, only: [:create, :update, :destroy]

  # GET /documents
  def index
    @documents = Document.all
  end

  # GET /documents/1
  # def show
  #  @folder = @document.folder
  # end

  # GET /documents/new
  def new
    @document = Document.new
    @folders = Folder.where(id: params['folder']) if params.key?('folder')
  end

  # GET /documents/1/edit
  def edit
    @folder = @folders.select { |f| f.id == @document.folder_id }
  end

  # POST /documents
  def create
    @document = Document.new(document_params)

    if @document.save
      redirect_to :back, notice: 'Document was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /documents/1
  def update
    if @document.update(document_params)
      redirect_to :back, notice: 'Document was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /documents/1
  def destroy
    @document.destroy
    redirect_to @folder, notice: 'Document was successfully destroyed.'
  end

  private

  def set_user_folders
    @folders = current_user.folders
  end

  def set_document
    @document = Document.find(params[:id])
  end

  def set_document_folder
    @folder = Folder.find(document_params[:folder_id])
  end

  # Never trust parameters from the scary internet, only allow the white list
  def document_params
    params.require(:document).permit(:name, :folder_id, :file)
  end
end
