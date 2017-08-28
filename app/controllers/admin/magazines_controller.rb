module Admin
  class MagazinesController < Admin::BaseController
    skip_before_action :verify_authenticity_token, only: [:reorder]

    def index
      @magazines = Magazine.all
    end

    def new
      @magazine = Magazine.new
    end

    def create
      @magazine = Magazine.new(magazine_params)
      if @magazine.save
        redirect_to admin_magazines_path, notice: 'Magazine added'
      else
        render action: :new
      end
    end

    def edit
      @magazine = Magazine.find(params[:id])
    end

    def update
      @magazine = Magazine.find(params[:id])
      if @magazine.update(magazine_params)
        redirect_to admin_magazines_path, notice: 'Magazine updated'
      else
        render action: :edit
      end
    end

    def destroy
      @magazine = Magazine.find(params[:id])
      @magazine.destroy
      redirect_to admin_magazines_path, notice: 'Magazine removed'
    end

    def reorder
      params[:magazine].each.with_index do |id, index|
        Magazine.find(id).update(position: index + 1)
      end
      render status: :ok, body: nil
    end

    private

    def magazine_params
      params.require(:magazine).permit(:name, :file)
    end
  end
end
