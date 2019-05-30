# class UserCategoriesController < ApplicationController
#   before_action :set_category, only: %i[index create destroy]

#   def index
#     @user_categories = UserCategory.all
#   end

#   def create
#     @user_category.create(user: current_user, category: @category)
#   end

#   def destroy
#     @user_category.where(category: @category, user: current_user)
#     @user_category.destroy
#   end

#   private

#   def set_category
#     @category = Category.find(params[:id])
#   end

#   def user_params
#     params.require(:user_categories).permit(:user_id, :category_id)
#   end

# end
# (1) THESE ACTIONS FOR 'USERCATEGORIES' MAY NEED TO BE EMBEDDED IN THE ITINERARIES CONTROLLER
# (2) WE NEED TO MAKE THE HOME PAGE CATEGORY TILES A 'FORM' IN ORDER TO PERSIST THE USER SELECTIONS
