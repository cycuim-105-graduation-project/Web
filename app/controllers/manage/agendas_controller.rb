class Manage::AgendasController < Manage::BasicResourceController
  private
  def collection_scope
    Agenda.preload(:indoor_level, :event)
  end

  def object_params
    params.require(:agenda).permit(
      :name, :description, :event_id, :indoor_level_id, :start_at, :end_at
    )
  end

  def url_after_update
    url_for(action: :index)
  end

end
