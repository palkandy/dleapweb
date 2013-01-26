class StaticPagesController < ApplicationController
 def home
    if signed_in?
      @micropost  = current_user.microposts.build
      @event      = current_user.events.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @eventfeed_items = current_user.eventsfeed.paginate(page: params[:page])
      
      @json = JSON.parse(@eventfeed_items.to_gmaps4rails) + JSON.parse(current_user.to_gmaps4rails)
      @json = @json.to_json
    end
  end


  def help
  end

  def about
  end

  def contact
  end
end
