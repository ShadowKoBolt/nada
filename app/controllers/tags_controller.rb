class TagsController < ApplicationController
  def index
    render json: ActsAsTaggableOn::Tag.where('taggings_count > 0').pluck(:name).to_json
  end
end
