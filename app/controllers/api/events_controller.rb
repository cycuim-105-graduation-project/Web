class Api::EventsController < ::ApplicationController
  def index
    @events = Event.all
    render json: ActiveModelSerializers::SerializableResource.new(@event).as_json
  end

  def show
    @event = Event.find(params[:id])
    render json: ActiveModelSerializers::SerializableResource.new(@event).as_json
  end
end
