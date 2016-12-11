require 'google/api_client/client_secrets'
require 'google/apis/proximitybeacon_v1beta1'

class Manage::Attachments::IndoorLevelsController < Manage::BaseController
  before_action :check_oauth_credentials, except: %i(new)
  before_action :set_proximity_beacon_instance

  def index
    render plain: @proximity_beacon.list_beacon_attachments(params[:beacon_id]).to_json
  end

  def new
    @form_indoor_level = Form::Beacon::Attachment::IndoorLevel.new
  end

  def create
    namespace = @proximity_beacon.list_namespaces.namespaces.first.namespace_name.split(/\//).second
    attachment_object = Form::Beacon::Attachment::IndoorLevel.new(
      announcement_params.merge(namespace: namespace)
    ).attachment_object
    @proximity_beacon.create_beacon_attachment(params[:beacon_id], attachment_object)
    redirect_to manage_beacons_path
  end

  private
  def announcement_params
    params.require(:form_beacon_attachment_indoor_level)
          .permit(:name)
  end
end
