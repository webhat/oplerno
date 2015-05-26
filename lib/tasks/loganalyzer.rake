# -*- encoding : utf-8 -*-

namespace :logs do
  desc 'Load logs'
  task :load => :environment do
    def normalize loghash, name, symbol
      loghash[symbol] = loghash[name]
      loghash.delete name
    end

    def line_to_analytic line
      loghash = process_line line
      begin
        Analytic.create! loghash
      rescue ActiveRecord::RecordNotUnique => e
        Rails.logger.warn(e)
        #p e
      end
    end

    def process_line line
      format = '%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"'
      parser = ApacheLogRegex.new(format)
      loghash = parser.parse(line)

      loghash[:method], loghash[:path], loghash[:protocol] = loghash['%r'].split ' '
      loghash.delete '%l'
      loghash.delete '%u'
      loghash.delete '%r'

      normalize loghash, '%h', :remote
      normalize loghash, '%t', :time
      normalize loghash, '%>s', :status
      normalize loghash, '%b', :bytes
      normalize loghash, '%{Referer}i', :referer
      normalize loghash, '%{User-Agent}i', :user_agent

      datetime = loghash[:time].gsub(/[\[\]]/, '')
      loghash[:time] = DateTime.strptime datetime, '%d/%b/%Y:%H:%M:%S %Z'

      loghash
    end

    [ 'log/access.log', 'log/access.log'].each do |logfile|
      File.readlines(logfile).collect do |line|
        line_to_analytic line
      end
    end

    (2..50).each do |num|
      infile = open("log/access.log.#{num}.gz")
      gz = Zlib::GzipReader.new(infile)

      gz.each_line do |line|
        line_to_analytic line
      end
    end
  end
end
