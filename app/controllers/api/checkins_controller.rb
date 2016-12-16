class Api::CheckinsController < ::ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user!

  def create
    checkin = Agenda.find(params[:agenda_id]).checkins.new(user: current_user)
    return head :no_content if checkin.save
  end
end
