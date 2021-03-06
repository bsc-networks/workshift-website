class CategoriesController < ApplicationController
  before_filter :set_category, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html, :json

  def index
    @categories = Category.where(unit_id: current_user.unit)
    respond_with(@categories)
  end

  def show
    respond_with(@category)
  end

  def new
    @category = Category.new
    @category.unit_id = current_user.unit
    authorize @category
    respond_with(@category)
  end

  def edit
    #@category = Category.find(params[:id])
    authorize @category
  end

  def create
    @category = Category.new(params[:category])
    authorize @category
    if @category.save
      User.create_preferences(@category)
      respond_with(@category)
    else
      render :new
    end
  end

  def update
    authorize @category
    @category.update_attributes(params[:category])
    respond_with(@category)
  end

  def destroy
    authorize @category
    @category.destroy
    respond_with(@category)
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end
