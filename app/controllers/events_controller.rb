class EventsController < ApplicationController
  def index
    @events = Event.where(published: true).all
  end

  def show
    @event = Event.friendly
    unless current_user && current_user.admin?
      @event = @event.where(published: true)
    end
    @event = @event.find(params[:id])
  end
end
