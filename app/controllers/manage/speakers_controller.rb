class Manage::SpeakersController < Manage::BasicResourceController
  private
  def collection_scope
    Speaker.preload(:agenda).where(agenda_id: params[:agenda_id])
  end

  def current_object
    @current_object ||= collection_scope.first
  end

  def object_params
    params.require(:speaker).permit(:name, :description, :image)
                             .merge(agenda_id: params[:agenda_id])
  end

  def url_after_create
    manage_agendas_path
  end

  def url_after_update
    manage_agendas_path
  end
end
