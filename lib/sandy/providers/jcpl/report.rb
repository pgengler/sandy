module Sandy::Provider
  module JCPL
    class Report
      include Sandy::Provider::StormCenter
      attr_reader :areas

      def initialize
        raw_report = JSON.parse(HTTParty.get(jcpl_url))
        @areas = raw_report.fetch('file_data').map do |place|
          name = place['title'].gsub(/"/, '')
          customers_out = place['desc'].first['cust_a'].gsub(/[<,]/, '')

          options = {
            :total_customers => place['desc'].first['cust_s'].gsub(/[<,]/, ''),
            :estimated_recovery_time => place['desc'].first['etr']
          }

          Sandy::Area.new(customers_out, name, options)
        end

      rescue
        raise LoadError, "JCP&L response was not recognizable."
      end

      private

      def jcpl_url
        base_uri = "http://outages.firstenergycorp.com"
        directory_url = "#{base_uri}/data/interval_generation_data/metadataNJ.xml"
        response = HTTParty.get(directory_url, format: :xml)
        directory = response.parsed_response.fetch("root").fetch("directory")
        "#{base_uri}/data/interval_generation_data/#{directory}/thematicctv/thematic_areas.js"
      end

    end
  end
end
