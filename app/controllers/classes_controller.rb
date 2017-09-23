class ClassesController < ApplicationController
  def index
  end

  def markers
    dance_classes = DanceClass.all
    dance_classes = dance_classes.near("#{params[:location]}, United Kingdom", params[:distance]) if params[:location].present?
    dance_classes = dance_classes.where(style: params[:style]) if params[:style].present?
    dance_classes = dance_classes.search(params[:teacher_name]) if params[:teacher_name].present?
    class_markers = Gmaps4rails.build_markers(dance_classes) do |dance_class, marker|
      marker.lat dance_class.latitude
      marker.lng dance_class.longitude
      marker.infowindow "<a href='#{class_path(dance_class)}'><h3>#{dance_class.name}</h3>More info</a>"
    end
    render json: { markers: class_markers.as_json }
  end

  def show
    @dance_class = DanceClass.find(params[:id])
  end
end
