class EpisodesController < ApplicationController
  before_action :set_episode, only: [:show, :edit, :update, :destroy]

  # GET /episodes
  # GET /episodes.json
  def index
    @episodes = Episode.all
  end

  # GET /episodes/1
  # GET /episodes/1.json
  #def show
  #  @season = Season.find(@episode.season_id)
  #end

  # GET /episodes/new
  def new
    @episode = Episode.new
  end

  # GET /episodes/1/edit
  def edit
  end

  # POST /episodes
  def create
    @episode = Episode.new(episode_params)

    if @episode.save
      redirect_to :back, notice: 'Episode was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /episodes/1
  def update
    if @episode.update(episode_params)
      redirect_to :back, notice: 'Episode was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /episodes/1
  # DELETE /episodes/1.json
  def destroy
    @episode.destroy
    redirect_to episodes_url, notice: 'Episode was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_episode
    @episode = Episode.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow white list
  def episode_params
    params.require(:episode).permit(:number, :watched, :downloaded,
                                    :season_id, :original_file, :mp4_file)
  end
end
