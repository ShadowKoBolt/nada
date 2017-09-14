class ClassesController < ApplicationController
  def index
  end

  def markers
    dance_classes = DanceClass.all
    dance_classes = dance_classes.near("#{params[:location]}, United Kingdom", params[:distance]) if params[:location].present?
    dance_classes = dance_classes.where(style: params[:style]) if params[:style].present?
    dance_classes = dance_classes.page(params[:page]).per(8)
    class_markers = Gmaps4rails.build_markers(dance_classes) do |dance_class, marker|
      marker.lat dance_class.latitude
      marker.lng dance_class.longitude
      marker.infowindow dance_class.name
      marker.title dance_class.name
      marker.json({ id: dance_class.id,
                    style: dance_class.style,
                    level: dance_class.level,
                    description: dance_class.description,
                    teacher_name: dance_class.user.name })
    end
    render json: { markers: class_markers.as_json,
                   meta: { next: dance_classes.next_page, prev: dance_classes.prev_page } }
  end

  def show
    @dance_class = DanceClass.find(params[:id])
  end
end
