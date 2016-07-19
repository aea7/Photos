class CategoriesController < ApplicationController

  def index
    if(params[:id].empty?)
      redirect_to images_path
    else
      @category = Category.find(params[:id])
    end
  end

end
