require 'us_core_test_kit/generator/validation_test_generator'
require_relative 'naming'

module PacioSMPTestKit
  class Generator
    class ValidationTestGenerator < USCoreTestKit::Generator::ValidationTestGenerator
      class << self
        def generate(ig_metadata, base_output_dir)
          ig_metadata.groups
            .each { |group| new(group, base_output_dir: base_output_dir).generate }
        end
      end

      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'validation.rb.erb'))
      end

      def directory_name
        Naming.snake_case_for_profile(medication_request_metadata || group_metadata)
      end

      def profile_identifier
        Naming.snake_case_for_profile(group_metadata)
      end

      def test_id
        "smp_#{group_metadata.reformatted_version}_#{profile_identifier}_validation_test"
      end

      def class_name
        "#{Naming.upper_camel_case_for_profile(group_metadata)}ValidationTest"
      end

      def module_name
        "PacioSMP#{group_metadata.reformatted_version.upcase}"
      end
      def generate
        FileUtils.mkdir_p(output_file_directory)
        File.write(output_file_name, output)

        test_metadata = {
          id: test_id,
          file_name: base_output_file_name
        }

        group_metadata.add_test(**test_metadata)
      end

      def description
        <<~DESCRIPTION
          This test verifies resources returned from the first search conform to
          the [#{profile_name} profile](#{profile_url}).

          Systems must demonstrate at least one valid example in order to pass this test.
          It verifies the presence of mandatory elements and that elements with
          required bindings contain appropriate values. CodeableConcept element
          bindings will fail if none of their codings have a code/system belonging
          to the bound ValueSet. Quantity, Coding, and code element bindings will
          fail if their code/system are not found in the valueset.
        DESCRIPTION
      end
    end
  end
end
