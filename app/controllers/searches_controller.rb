class SearchesController < ApplicationController
	def index
		@searches = Course.search '*', per_page: 24
	end

	def create
		@search = params[:search][:term]
		Search.create! params[:search]
		@searches = Course.search @search, per_page: 24
		not_found
	end

	private

	def not_found
		flash[:alert] = t('search.not_found', term: @search) if @searches.empty?
	end
end
