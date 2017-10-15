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
    character.destroy! if character.roleplay.user == current_user && !character.is_narrator
    redirect_to '/roleplays/' + character.roleplay_id.to_s + '/edit?result=success&reason=deleted'
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

  def update
    character = Character.find(params[:id])
    user_found = User.find_by_username(params[:character][:owner])
    if user_found.nil?
      redirect_to '/roleplays/' + character.roleplay_id.to_s + '/edit?result=fail&reason=nosuchuser'
      return
    end
    changed = false
    changed = true unless user_found == character.user
    character.user = user_found
    changed = true unless params[:character][:name] == character.name
    character.name = params[:character][:name]
    changed = true unless params[:character][:description] == character.description
    character.description = params[:character][:description]
    unless params[:character][:image].nil?
      changed = true unless params[:character][:image] == character.image
      character.image = params[:character][:image]
    end
    unless changed
      redirect_to '/roleplays/' + character.roleplay_id.to_s + '/edit?result=fail&reason=nochanges'
      return
    end
    character.save!
    redirect_to '/roleplays/' + character.roleplay_id.to_s + '/edit?result=success&reason=saved&selected=' + character.id.to_s
  end

  private

  def character_params
    params.permit(:name, :description, :roleplay, :image)
  end
end
