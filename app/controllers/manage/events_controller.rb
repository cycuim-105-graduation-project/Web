class Manage::EventsController < Manage::BasicResourceController
  def create
    @current_object = collection_scope.new(object_params.merge(vacancy: params[:quantity]))
    if @current_object.save
      flash[:success] = t(".created_successfully")
      redirect_to url_after_create
    else
      render :new
    end
  end

  private
  def collection_scope
    Event.preload(:place)
  end

  def object_params
    params.require(:event).permit(
      :name,
      :description,
      :feature_img,
      :start_at,
      :end_at,
      :registration_start_at,
      :registration_end_at,
      :quantity,
      :place_id
    )
  end
end
