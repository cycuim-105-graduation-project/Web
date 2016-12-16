class Api::CheckinsController < ::ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user!

  def create
    checkin = Agenda.find(params[:agenda_id]).checkins.new(user: current_user)
    if checkin.save
      return head :no_content
    else
      render json: checkin.errors, status: :unprocessable_entity
    end
  end
end
