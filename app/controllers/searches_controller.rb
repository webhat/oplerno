class SearchesController < ApplicationController
  def index
    @searches = Course.search '*', per_page: 24
  end

  def create
    @search = search_params[:term]
    puts @search
    Search.create! search_params
    @searches = Course.search @search, per_page: 24, fields: [{name: :word_start}, {description: :word}]
    not_found
  end

  private

  def search_params
    params[:search]
  end

  def not_found
    flash[:alert] = t('search.not_found', term: @search) if @searches.empty?
  end
end
