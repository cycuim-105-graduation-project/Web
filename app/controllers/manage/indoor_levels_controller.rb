class Manage::IndoorLevelsController < Manage::BasicResourceController
  private
  def collection_scope
    IndoorLevel.preload(:place)
  end

  def object_params
    params.require(:indoor_level).permit(:name, :place_id)
  end

  def url_after_update
    url_for(action: :index)
  end
end
