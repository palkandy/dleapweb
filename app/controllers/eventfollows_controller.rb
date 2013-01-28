class EventfollowsController < ApplicationController
  before_filter :signed_in_user

def create
    @event = Event.find(params[:eventfollow][:event_id])
    current_user.eventfollow!(@event)
     respond_to do |format|
      format.html { redirect_to current_user }
      format.js
  end
end

  def destroy
    @event = Event.find(params[:eventfollow][:event_id])
    current_user.eventunfollow!(@event)
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end

end
