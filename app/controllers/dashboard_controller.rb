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
      rp_sorter(x, y)
    end
  end

  private

  # sort first by ownership, then by online status, then by alphabetical order
  def rp_sorter(a, b)
    if b.user == current_user
      return 1 unless a.user == current_user
    end
    if a.user == current_user
      return -1 unless b.user == current_user
    end
    if a.online != b.online
      return b.online ? 1 : -1
    end
    a.name <=> b.name
  end
end
