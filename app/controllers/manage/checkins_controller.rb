class Manage::CheckinsController < Manage::BasicResourceController
  def collection_scope
    current_user.checkins.preload(agenda: :event)
  end
end
