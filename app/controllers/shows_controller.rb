class ShowsController < ApplicationController
  before_action :set_show!, only: [:edit, :show, :update, :destroy]
  before_action :redirect_if_not_logged_in
  before_action :deny_unauthorized_access, only: [:new, :edit, :destroy]

  def new
    @show = Show.new
    3.times { @show.characters.build }
  end

  def create
    @show = Show.new(show_params)
    @show.save ? (redirect_to user_shows_path(current_user)) : (render :new)
  end

  # def update
  #   @show.update(show_params) ? (redirect_to user_show_path(@show)) : (render :edit)
  # end

  def destroy
    @show.destroy
    redirect_to user_shows_path(current_user)
  end

  def index
    @shows = Show.where("user_id = ?", current_user.id)
  end

  private

  def set_show!
    @show = Show.find(params[:id])
  end

  def show_params #add id for nested_attributes
    params.require(:show).permit(:name, :user_id, characters_attributes: [:note, :quote, :show_id, :dislike, :deceased, :name])
  end

end
