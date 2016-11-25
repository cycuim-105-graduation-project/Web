require 'google/api_client/client_secrets'
require 'google/apis/proximitybeacon_v1beta1'

class Manage::BeaconsController < Manage::BaseController
  before_action :check_oauth_credentials, only: :index
  before_action :set_auth_client, only: :oauth2callback
  before_action :set_proximity_beacon_instance, except: :oauth2callback

  ProximityBeacon = Google::Apis::ProximitybeaconV1beta1

  def index
    render plain: @proximity_beacon.list_beacons.to_json
  end


  def show
    render plain: @proximity_beacon.get_beacon(params[:beacon_id]).to_json
  end

  def oauth2callback
    unless params[:code].present?
      auth_uri = @auth_client.authorization_uri.to_s
      redirect_to(auth_uri)
    else
      @auth_client.code = params[:code]
      @auth_client.fetch_access_token!
      @auth_client.client_secret = nil
      session[:google_oauth_credentials] = @auth_client.to_json
      redirect_to manage_beacons_path
    end
  end

  private
  def set_auth_client
    client_secrets = ::Google::APIClient::ClientSecrets.load Rails.root.join('config', 'google_credentials.json')
    @auth_client = client_secrets.to_authorization
    @auth_client.update!(
      scope: 'https://www.googleapis.com/auth/userlocation.beacon.registry',
      redirect_uri: oauth2callback_manage_beacons_url
    )
  end

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
