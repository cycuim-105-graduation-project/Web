class Manage::PlacesController < Manage::BasicResourceController

  private
  def collection_scope
    Place
  end

  def object_params
    params.require(:place).permit(:name, :description, :address, :google_place_id)
  end
end
