class WishesController < ApplicationController
  before_action :set_wish, only: [:show, :edit, :update, :destroy]

  # GET /wishes
  def index
    @wishes = Wish.all
  end

  # GET /wishes/1
  #def show
  #end

  # GET /wishes/new
  def new
    @wish = Wish.new
  end

  # GET /wishes/1/edit
  def edit
  end

  # POST /wishes
  def create
    @wish = Wish.new(wish_params)

    if @wish.save
      redirect_to wishes_path, notice: 'Wish was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /wishes/1
  def update
    if @wish.update(wish_params)
      redirect_to wishes_path, notice: 'Wish was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /wishes/1
  def destroy
    @wish.destroy
    redirect_to wishes_path, notice: 'Wish was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wish
      @wish = Wish.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wish_params
      params["wish"]["user_id"] = current_user.id
      params.require(:wish).permit(:name, :price, :user_id, :link)
    end
end
