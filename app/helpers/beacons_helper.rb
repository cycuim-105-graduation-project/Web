module BeaconsHelper
  def eddystone_namespace(advertised_id)
    advertised_id.unpack("H*")[0].first(20)
  end

  def eddystone_instance(advertised_id)
    advertised_id.unpack("H*")[0].last(12)
  end

  def link_to_modify_status(beacon)
    case beacon.status.downcase.to_sym
    when :active
      link_to URI.decode(manage_beacon_deactivate_path(beacon_id: beacon.beacon_name)), method: :delete, class: 'text-danger' do
        capture do
          concat content_tag :i, nil, class: 'fa fa-power-off'
          concat content_tag :span, ' 停用', class: 'lbl'
        end
      end
    when :inactive
      link_to URI.decode(manage_beacon_activate_path(beacon_id: beacon.beacon_name)), method: :put, class: 'text-success' do
        capture do
          concat content_tag :i, nil, class: 'fa fa-power-off'
          concat content_tag :span, ' 啟用', class: 'lbl'
        end
      end
    else
    end
  end
end
