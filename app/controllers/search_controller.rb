class SearchController < ApplicationController
  before_action :search
  
  def keyword
  end

  def sort_order
  end

  private

  def search
    @p = Item.ransack(params[:q])
    @result = @p.result
  end
end
