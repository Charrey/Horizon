class CharactersController < ApplicationController
  def create
    params = character_params
    roleplay_id = params[:roleplay]
    roleplay = Roleplay.find(roleplay_id)
    params.delete :roleplay
    character = Character.new(params.merge(user: nil, roleplay: roleplay))

    if character.save
      redirect_to '/dashboard'
    else
      render 'new'
    end
  end


  def claim
    character = Character.find(params[:character])
    character.update(user: current_user)
    redirect_to '/dashboard'
  end

  def destroy
    character = Character.find(params[:character])
    character.destroy!
    redirect_to '/dashboard'
  end

  def unbind
    character = Character.find(params[:character])
    character.update(user: nil)
    redirect_to '/dashboard'
  end

  def assign
    character = Character.find(params[:character])
    user = User.find_by_username(params[:username])
    character.update(user: user)
    redirect_to '/dashboard'
  end

  private
  def character_params
    params.permit(:name, :description, :roleplay, :image)
  end


end
