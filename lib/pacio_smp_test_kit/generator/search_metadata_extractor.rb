require 'us_core_test_kit/generator/search_metadata_extractor'
require_relative 'search_definition_metadata_extractor'

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

      def search_definitions
        search_param_names.each_with_object({}) do |name, definitions|
          definitions[name.to_sym] =
            SearchDefinitionMetadataExtractor.new(name, ig_resources, profile_elements,
                                                  group_metadata).search_definition
        end
      end
    end
  end
end
