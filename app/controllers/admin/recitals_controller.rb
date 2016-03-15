module Admin
  class RecitalsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # simply overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Recital.all.paginate(10, params[:page])
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Recital.find_by!(slug: param)
    # end

    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information

    def update
      recital = Recital.find(params[:id])
      if params[:venue_image] then
        recital.venue_image = nil
        recital.save
      end
      recital.update(recital_params)
      redirect_to admin_recital_path(recital)
    end

    private

    def recital_params
      params.require(:recital).permit!
    end
  end
end
