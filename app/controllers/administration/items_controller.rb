# frozen_string_literal: true

module Administration
  class ItemsController < AdministrationController
    before_action :find_item, only: %i[show edit update]
    def index
      @items = Item.all
    end

    def show; end

    def new; end

    def edit; end

    def create; end

    def update
      @item.update(item_params)
      redirect_to administration_items_path
    end

    def destroy; end

    private

    def item_params
      params.require(:item).permit(:original_price, :has_discount, :discount_percentage)
    end

    def find_item
      @item = Item.find(params[:id])
    end
  end
end
