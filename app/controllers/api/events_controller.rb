class Api::EventsController < ::ApplicationController
  def index
    @events = Event.all
    render json: ActiveModelSerializers::SerializableResource.new(@events).as_json
  end

  def show
    @event = Event.find(params[:id])
    render json: ActiveModelSerializers::SerializableResource.new(@event).as_json
  end

  def agendas
    @agendas = Agenda.preload(:indoor_level, :speaker)
                     .where(event_id: params[:event_id])
                     .select("*, DATE(start_at) as start_at_date")
                     .order(start_at: :asc)
    render json: ActiveModelSerializers::SerializableResource.new(@agendas)
      .serializable_hash
      .group_by{ |x| x[:start_at_date] }
      .map { |d, o| { "#{d}" => o.group_by { |o| o[:start_at_time] } } }.to_json
  end
end
