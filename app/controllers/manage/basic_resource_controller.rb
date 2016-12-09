class Manage::BasicResourceController < Manage::BaseController
  helper_method :current_collection, :current_object

  def index
  end

  def new
    @current_object = collection_scope.new
  end

  def create
    @current_object = collection_scope.new(object_params)
    if @current_object.save
      flash[:success] = t(".created_successfully")
      redirect_to url_after_create
    else
      render :new
    end
  end

  def edit
  end

  def update
    if current_object.update(object_params)
      flash[:success] = t('flash.successfully_updated')
      redirect_to url_after_update
    else
      render action: :edit
    end
  end

  def destroy
    current_object.destroy
    flash[:success] = t('.destroyed_successfully')
    redirect_to url_after_destroy
  end

  private
  def url_after_create
    url_for(action: :index)
  end

  def url_after_update
    url_for(action: :show)
  end

  alias url_after_destroy url_after_create

  def collection_scope
    # Need to implement individually in child Controller
  end

  def object_params
    # Need to implement individually in child Controller
  end

  def current_collection
    @collection ||= collection_scope.all
  end

  def current_object
    @current_object ||= collection_scope.find(params[:id])
  end
end
