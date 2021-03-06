module Admin
  class PicturesController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # simply overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Picture.all.paginate(10, params[:page])
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Picture.find_by!(slug: param)
    # end

    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information

    def update
      picture = Picture.find(params[:id])
      if params[:photo] then
        picture.photo = nil
        picture.save
      end
      picture.update(picture_params)
      redirect_to admin_picture_path(picture)
    end

    private

    def picture_params
      params.require(:picture).permit!
    end
  end
end
