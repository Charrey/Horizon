class RoleplaysController < ApplicationController
  before_action :authenticate_user!

  def new
    @roleplay = Roleplay.new
  end

  def create
    roleplay = Roleplay.new(roleplay_params.merge(user: current_user, online: false))
    if roleplay.save
      roleplay.createNarrator(roleplay)
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
    redirect_to '/roleplays/' + roleplay.id.to_s + '/edit?result=started'
  end

  def stop
    roleplay = Roleplay.find(params[:id])
    roleplay.update!(online: false) if roleplay.user == current_user
    redirect_to '/roleplays/' + roleplay.id.to_s + '/edit?result=stopped'
  end

  def edit
    @roleplay = Roleplay.find(params[:id])
  end

  def update
    roleplay = Roleplay.find(params[:id])
    changed = false
    changed = true unless params[:roleplay][:name] == roleplay.name
    roleplay.name = params[:roleplay][:name]
    changed = true unless params[:roleplay][:description] == roleplay.description
    roleplay.description = params[:roleplay][:description]
    unless params[:roleplay][:image].nil?
      changed = true unless params[:roleplay][:image] == roleplay.image
      roleplay.image = params[:roleplay][:image]
    end
    unless changed
      redirect_to '/roleplays/' + roleplay.id.to_s + '/edit?result=fail&reason=nochanges'
      return
    end
    roleplay.save!
    redirect_to '/roleplays/' + roleplay.id.to_s + '/edit?result=success&reason=saved&selected=-1'
  end

  def add_dummy
    roleplay = Roleplay.find(params[:id])
    character = Character.new
    character.roleplay = roleplay
    character.user = current_user
    character.name = 'New character'
    character.description = 'Boring new character.'
    character.save!
    redirect_to '/roleplays/' + roleplay.id.to_s + '/edit?result=success&reason=created&selected=' + character.id.to_s
  end

  def message_to_append
    @character_id = params[:character_id]
    @character = Character.find_by_id(@character_id)
    render :layout => false
  end

  def save_message
    @character_id = Character.find_by_id(params[:character_id])

  end

  def last_message_id
    @roleplay_id = params[:roleplay_id]
    @message_id = Message.last_message_id(@roleplay_id)
    render :layout => false
  end

  def roleplay_messages
    @roleplay = Roleplay.find(params[:roleplay_id])
    @messages = @roleplay.messages
    render :layout => false
  end

  private

  def roleplay_params
    params.require(:roleplay).permit(:name, :image, :description)
  end
end
