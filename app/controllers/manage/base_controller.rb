require 'google/api_client/client_secrets'
require 'google/apis/proximitybeacon_v1beta1'

class Manage::BaseController < ApplicationController
  layout 'backend'
  before_action :authenticate_user!

  ProximityBeacon = Google::Apis::ProximitybeaconV1beta1

  private
  def check_oauth_credentials
    redirect_to oauth2callback_manage_beacons_path unless session[:google_oauth_credentials].present?
  end

  def set_proximity_beacon_instance
    client_opts = JSON.parse(session[:google_oauth_credentials])
    auth_client = Signet::OAuth2::Client.new(client_opts)
    @proximity_beacon = ProximityBeacon::ProximitybeaconService.new
    @proximity_beacon.authorization = auth_client
  end
end
