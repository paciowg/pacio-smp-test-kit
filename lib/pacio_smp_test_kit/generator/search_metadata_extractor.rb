require 'us_core_test_kit/generator/search_metadata_extractor'
require 'us_core_test_kit/generator/search_definition_metadata_extractor'

module PacioSMPTestKit
  class Generator
    class SearchMetadataExtractor < USCoreTestKit::Generator::SearchMetadataExtractor
      def basic_searches
        result = super
        
        if resource_capabilities.type == 'Patient' 
          result << { names: ['_id'], expectation: 'SHALL' }
        elsif resource_capabilities.type == 'MedicationRequest' 
          result << { names: ['patient'], expectation: 'SHALL' }
        end
        
        result
      end
    end
  end
end
