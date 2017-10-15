class DashboardController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @characters = current_user.characters.includes(roleplay: [:user])
    @new_character = Character.new
    @participations = []
    @characters.each do |character|
      @participations.append(character.roleplay)
    end
    @participations.uniq!
    @participations.sort! do |x, y|
      Roleplay.sorter(x, y, current_user)
    end
  end


  # sort first by ownership, then by online status, then by alphabetical order

end
