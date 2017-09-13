class ClassesController < ApplicationController
  def index
  end

  def markers
    @dance_classes = DanceClass.all
    @dance_classes = @dance_classes.near("#{params[:location]}, United Kingdom", params[:distance]) if params[:location].present?
    @dance_classes = @dance_classes.where(style: params[:style]) if params[:style].present?
    class_markers = Gmaps4rails.build_markers(@dance_classes) do |dance_class, marker|
      marker.lat dance_class.latitude
      marker.lng dance_class.longitude
      marker.infowindow dance_class.name
      marker.title dance_class.name
    end
    render json: class_markers.to_json
  end
end
