class Manage::PagesController < Manage::BaseController
  before_action :set_auth_client, only: :oauth2callback

  def dashboard
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
end
