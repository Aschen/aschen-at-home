class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy]

  # GET /folders
  def index
    @folders = current_user.folders
  end

  # GET /folders/1
  def show
    @documents = @folder.documents
  end

  # GET /folders/new
  def new
    @folder = Folder.new
  end

  # GET /folders/1/edit
  def edit
  end

  # POST /folders
  # POST /folders.json
  def create
    @folder = Folder.new(folder_params)

    if @folder.save
      redirect_to @folder, notice: 'Folder was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /folders/1
  def update
    if @folder.update(folder_params)
      redirect_to :back, notice: 'Folder was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /folders/1
  def destroy
    @folder.destroy
    redirect_to folders_url, notice: 'Folder was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_folder
    @folder = Folder.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list
  def folder_params
    params['folder']['user_id'] = current_user.id
    params.require(:folder).permit(:name, :user_id)
  end
end
