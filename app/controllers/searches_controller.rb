class SearchesController < ApplicationController
	def index
		@searches = Course.search '*'
	end

	def create
		@search = params[:search][:term]
		@searches = Course.search @search
		not_found
	end

	private

	def not_found
		flash[:alert] = t('search.not_found', term: @search) if @searches.empty?
	end
end
