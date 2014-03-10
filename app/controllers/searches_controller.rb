class SearchesController < ApplicationController
	def index
		@searches = Course.search '*'
	end

	def create
		@searches = Course.search params[:search][:term]
		not_found
	end

	private

	def not_found
		flash[:alert] = t('search.not_found') if @searches.empty?
	end
end
