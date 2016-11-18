require 'google/api_client/client_secrets'

class Manage::BeaconsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_auth_client, only: :oauth2callback

  def oauth2callback
    unless params[:code].present?
      auth_uri = @auth_client.authorization_uri.to_s
      redirect_to(auth_uri)
    else
      @auth_client.code = params[:code]
      @auth_client.fetch_access_token!
      @auth_client.client_secret = nil
      session[:google_oauth_credentials] = @auth_client.to_json
      render plain: @auth_client.to_json
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

end
