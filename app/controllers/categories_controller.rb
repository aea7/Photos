class CategoriesController < ApplicationController

  def index
    if(params[:id].empty?)
      @categories = Category.all
    else
      @category = Category.find(params[:id])
    end
  end

end
