class Manage::IndoorLevelsController < Manage::BasicResourceController
  private
  def collection_scope
    IndoorLevel.preload(:place)
  end

  def object_params
    params.require(:indoor_level).permit(:name, :place_id)
  end
end
