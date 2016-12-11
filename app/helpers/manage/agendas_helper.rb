module Manage::AgendasHelper
  def link_for_speaker(agenda)
    if agenda.speaker.present?
      link_to edit_manage_speaker_path(agenda_id: agenda.id), class: 'text-warning' do
        capture do
          concat content_tag :i, nil, class: 'fa fa-user'
          concat content_tag :span, ' 講者', class: 'lbl'
        end
      end
    else
      link_to new_manage_speaker_path(agenda_id: agenda.id), class: 'text-success' do
        capture do
          concat content_tag :i, nil, class: 'fa fa-user-plus'
          concat content_tag :span, ' 講者', class: 'lbl'
        end
      end
    end
  end
end
