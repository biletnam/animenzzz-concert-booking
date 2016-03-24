module Admin
  class VideosController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # simply overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Video.all.paginate(10, params[:page])
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Video.find_by!(slug: param)
    # end

    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information

    def update
      video = Video.find(params[:id])
      if params[:screenshot] then
        video.screenshot = nil
        video.save
      end
      video.update(video_params)
      redirect_to admin_video_path(video)
    end

    private

    def video_params
      params.require(:video).permit!
    end
  end
end
