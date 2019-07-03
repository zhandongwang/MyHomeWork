module Spaceship
  module Tunes
    # Represents the information about remaining number of promo codes for an app version
    class AppVersionPromocodes < TunesBase
      # @return
      attr_reader :app_id
      attr_reader :app_name
      attr_reader :version
      attr_reader :platform
      attr_reader :number_of_codes
      attr_reader :maximum_number_of_codes
      attr_reader :contract_file_name

      attr_mapping({
        'id' => :app_id,
        'appName' => :app_name,
        'version' => :version,
        'platform' => :platform,
        'numberOfCodes' => :number_of_codes,
        'maximumNumberOfCodes' => :maximum_number_of_codes,
        'contractFileName' => :contract_file_name
      })

      class << self
        # Create a new object based on a hash.
        # This is used to create a new object based on the server response.
        def factory(attrs)
          obj = self.new(attrs)
          return obj
        end
      end
    end
  end
end
