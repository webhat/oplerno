require 'active_admin'

module ActiveAdmin
  module Ical
    class Builder
      def initialize(resource_class=nil, options={}, &block)
        @resource = options.delete(:resource)
        @block = [], options, block
      end
      def serialize(collection)
        cal = Icalendar::Calendar.new
        collection.each do |resource|
          cal.event do |e|
            e.dtstart     = resource.start_date
            #e.dtend       = Icalendar::Values::Date.new('20050429')
            e.summary     = resource.name
            e.description = resource.description
            e.ip_class    = "PRIVATE"
          end unless resource.start_date.nil?
        end
        cal.to_ical
      end
    end
    module DSL
      def ical
        'poekoemaboelie'
      end
    end
    module Resource
      def ical_builder=(builder)
        @ical_builder = builder
      end
      def ical_builder
        @ical_builder ||= ActiveAdmin::Ical::Builder.new
      end
    end
    module ResourceController
      def self.included(base)
        base.send :alias_method_chain, :per_page, :ical
        base.send :alias_method_chain, :index, :ical
        base.send :respond_to, :ical
      end

      # patching the index method to allow the xlsx format.
      def index_with_ical(options={}, &block)
        index_without_ical(options) do |format|
          format.ical do
            ical = active_admin_config.ical_builder.serialize(collection)
            send_data ical, :filename => "#{ical_filename}", :type => Mime::Type.lookup_by_extension(:ical)
          end
        end
      end

      # patching per_page to use the CSV record max for pagination when the format is ical
      def per_page_with_ical
        if request.format ==  Mime::Type.lookup_by_extension(:ical)
          return max_csv_records
        end
        per_page_without_ical
      end

      # Returns a filename for the ical file using the collection_name
      # and current date such as 'my-articles-2011-06-24.ical'.
      def ical_filename
        "#{resource_collection_name.to_s.gsub('_', '-')}-#{Time.now.strftime("%Y-%m-%d")}.ical"
      end
    end
  end
end
