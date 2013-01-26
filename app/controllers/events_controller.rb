class EventsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def create
    @event = current_user.events.build(params[:event])
    if @event.save
      flash[:success] = "Event created!"
      redirect_to root_url
    else     
      @eventfeed_items = []
      render 'static_pages/home'
    end
  end


  def destroy
    @event.destroy
    redirect_to root_url
  end

  private

    def correct_user
      @event = current_user.events.find(params[:id])
    rescue
      redirect_to root_url
    end
end
