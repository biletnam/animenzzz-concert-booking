module Admin
  class UsersController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # simply overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = User.all.paginate(10, params[:page])
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   User.find_by!(slug: param)
    # end

    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information

    def update
      user = User.find(params[:id])
      if params[:avatar] then
        recital.avatar = nil
        recital.save
      end
      user.update(user_params)
      redirect_to admin_user_path(user)
    end

    private

    def user_params
      params.require(:user).permit!
    end
  end
end
