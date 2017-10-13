class RoleplaysController < ApplicationController
  before_action :authenticate_user!, only: %i[new create destroy start stop show]

  def new
    @roleplay = Roleplay.new
  end

  def create
    roleplay = Roleplay.new(roleplay_params.merge(user: current_user, online: false))
    if roleplay.save
      redirect_to '/dashboard'
    else
      render 'new'
    end
  end

  def show
    @roleplay = Roleplay.includes(:characters).find(params[:id])
    @my_characters = @roleplay.characters.where(user: current_user.id)
    @message = Message.new
  end

  def destroy
    roleplay = Roleplay.find(params[:roleplay_id])
    roleplay.destroy! if roleplay.user == current_user
    redirect_to '/dashboard'
  end

  def start
    roleplay = Roleplay.find(params[:id])
    roleplay.update!(online: true) if roleplay.user == current_user
    redirect_to '/dashboard'
  end

  def stop
    roleplay = Roleplay.find(params[:id])
    roleplay.update!(online: false) if roleplay.user == current_user
    redirect_to '/dashboard'
  end

  def edit
    @roleplay = Roleplay.find(params[:id])
  end

  private

  def roleplay_params
    params.require(:roleplay).permit(:name, :image, :description)
  end
end
