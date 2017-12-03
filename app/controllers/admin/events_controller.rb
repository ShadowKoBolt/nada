module Admin
  class EventsController < Admin::BaseController
    skip_before_action :verify_authenticity_token, only: [:reorder]

    def index
      @events = Event.all
    end

    def new
      @event = Event.new
    end

    def create
      @event = Event.new(event_params)
      if @event.save
        redirect_to admin_events_path, notice: 'Event added'
      else
        render action: :new
      end
    end

    def edit
      @event = Event.friendly.find(params[:id])
    end

    def update
      @event = Event.friendly.find(params[:id])
      if @event.update(event_params)
        redirect_to admin_events_path, notice: 'Event updated'
      else
        render action: :edit
      end
    end

    def destroy
      @event = Event.friendly.find(params[:id])
      @event.destroy
      redirect_to admin_events_path, notice: 'Event removed'
    end

    def reorder
      params[:event].each.with_index do |id, index|
        Event.friendly.find(id).update(position: index + 1)
      end
      render status: :ok, body: nil
    end

    def feature
      event = Event.friendly.find(params[:id])
      Event.update_all(featured: false)
      event.update(featured: true)
      redirect_to admin_events_path
    end

    private

    def event_params
      params.require(:event).permit(:name, :image, :date, :location,
                                    :published, :facebook_url, :body,
                                    :google_map_embed_code)
    end
  end
end
