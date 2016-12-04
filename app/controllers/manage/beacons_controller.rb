require 'google/api_client/client_secrets'
require 'google/apis/proximitybeacon_v1beta1'

class Manage::BeaconsController < Manage::BaseController
  before_action :check_oauth_credentials
  before_action :set_proximity_beacon_instance

  def index
    @beacons = @proximity_beacon.list_beacons.beacons
  rescue ArgumentError
    # Should save refresh_token when get permissions for the first time, and use
    # it to retrieve access token
    redirect_to oauth2callback_manage_beacons_path
  end

  def show
    render plain: @proximity_beacon.get_beacon(params[:beacon_id]).to_json
  end

  def new
    @form_beacon = Form::Beacon.new
  end

  def create
    beacon_object = Form::Beacon.new(form_beacon_params).beacon_object
    @proximity_beacon.register_beacon(beacon_object)
    redirect_to manage_beacons_path
  end

  def edit
    @beacon = @proximity_beacon.get_beacon(params[:beacon_id])
    @form_beacon = Form::Beacon.build_from_beacon_object @beacon
  end

  def update
    beacon_object = Form::Beacon.new(form_beacon_params).beacon_object
    @proximity_beacon.update_beacon(params[:beacon_id], beacon_object)
    redirect_to URI.decode manage_beacon_edit_path
  end

  def activate
    @proximity_beacon.activate_beacon(params[:beacon_id])
    redirect_to manage_beacons_path
  end

  def deactivate
    @proximity_beacon.deactivate_beacon(params[:beacon_id])
    redirect_to manage_beacons_path
  end

  private
  def form_beacon_params
    params.require(:form_beacon).permit(
      :namespace, :instance, :beacon_type,:status, :expected_stability,
      :place_id, :indoor_level, :description
    )
  end
end
