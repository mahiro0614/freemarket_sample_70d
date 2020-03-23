class ItemsController < ApplicationController
  before_action :set_item, except: [:index,:new,:create,:destroy]

  def index
    @items = Item.includes(:images).order('created_at DESC').limit(5)
    @images = Image.all
  end
  def new
    @item = Item.new
    @images = @item.images.build
  end
  def create
    # binding.pry
    @item = Item.new(item_params)
    # Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render new_items_path
    end
  end
  def edit

  end
  def show

  end
  def update
    @item.update(item_update_params)
  end
  def destroy
    @item.destroy
    redirect_to root_path
  end



  private
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :brand, :prefecture_code_id, :category_id,  :item_condition_id, :preparation_day_id, :postage_payer_id, :user_id, images_attributes: [:src, :item_id, :created_at, :update_at]).merge(user_id: current_user.id)

  end


  def set_item
    @item = Item.find(params[:id])

  end
end
