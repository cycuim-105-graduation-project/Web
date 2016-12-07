require 'google/api_client/client_secrets'
require 'google/apis/proximitybeacon_v1beta1'

class Manage::AttachmentsController < Manage::BaseController
  before_action :check_oauth_credentials
  before_action :set_proximity_beacon_instance

  def index
    attachments = @proximity_beacon.list_beacon_attachments(params[:beacon_id]).attachments
    @attachments = attachments&.map do |attachment|
      Form::Beacon::Attachment.new(
        namespaced_type: attachment.namespaced_type,
        attachment_name: attachment.attachment_name,
        beacon_id: params[:beacon_id],
        data: attachment.data.force_encoding("UTF-8")
      ).attachment
    end
    # render plain: @proximity_beacon.list_beacon_attachments(params[:beacon_id]).to_json
  end

  def destroy
    @proximity_beacon.delete_beacon_attachment(patams[:id])
    flash[:success] = '成功刪除 Beacon Attachment!'
    redirect_to manage_beacon_attachments_path
  end
end
