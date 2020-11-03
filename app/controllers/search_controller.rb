class SearchController < ApplicationController

  def keyword
    search
  end

  def sort_order
   if params[:q][:category_id_eq] == "0"
    params[:q][:category_id_eq] = ""
   end
   search
  end

  private

  def search
    @p = Item.ransack(params[:q])
    @result = @p.result
  end
end
