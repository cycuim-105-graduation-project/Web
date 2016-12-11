class Manage::IndoorLevelsController < Manage::BaseResourceController
  private
  def collection_scope
    InddorLevel.preload(:place)
  end

  def object_params
    params.require(:indoor_level).perimt(:name, :place_id)
  end
end
