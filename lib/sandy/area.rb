module Sandy
  class Area
    attr_reader :name, 
      :region, 
      :customers_affected, 
      :latitude, 
      :longitude, 
      :total_customers,
      :estimated_recovery_time

    def initialize(customers_affected, location, options = {})
      @name = location
      @customers_affected = customers_affected
      @region = options[:region]
      @total_customers = options[:total_customers]
      @latitude = options[:latitude]
      @longitude = options[:longitude]
      @estimated_recovery_time = options[:estimated_recovery_time]
    end
  end
end
