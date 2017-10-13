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
    character = Character.includes(roleplay: [:user]).find(params[:character])
    character.update(user: current_user) if character.roleplay.user == current_user
    redirect_to '/dashboard'
  end

  def destroy
    character = Character.includes(roleplay: [:user]).find(params[:character])
    character.destroy! if character.roleplay.user == current_user
    redirect_to '/dashboard'
  end

  def unbind
    character = Character.includes(roleplay: [:user]).find(params[:character])
    character.update(user: nil) if character.roleplay.user == current_user
    redirect_to '/dashboard'
  end

  def assign
    character = Character.includes(roleplay: [:user]).find(params[:character])
    character.update(user: User.find_by_username(params[:username])) if character.roleplay.user == current_user
    redirect_to '/dashboard'
  end

  private
  def character_params
    params.permit(:name, :description, :roleplay, :image)
  end


end
