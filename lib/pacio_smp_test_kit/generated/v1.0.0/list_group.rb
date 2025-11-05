require_relative 'list/list_patient_search_test'
require_relative 'list/list_code_search_test'
require_relative 'list/list_read_test'
require_relative 'list/list_validation_test'
require_relative 'list/list_must_support_test'
require_relative '../../custom_groups/v1.0.0/operation_retrieve_test'
require_relative '../../custom_groups/v1.0.0/operation_submit_test'

module PacioSMPTestKit
  module PacioSMPV100
    class ListGroup < Inferno::TestGroup
      title 'Standardized Medication - Medication List Tests'
      short_description 'Verify support for the server capabilities required by the Standardized Medication Profile - Medication List.'
      description %(
  # Background

The SMP Standardized Medication - Medication List sequence verifies that the system under test is
able to provide correct responses for List queries. These queries
must contain resources conforming to the Standardized Medication Profile - Medication List as
specified in the SMP v1.0.0 Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient
* code

### Search Parameters
The first search uses the selected resources from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. If a value cannot be found this way, the search is skipped.

### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
List resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html).


## Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the List resources found in the first test for these
elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [Standardized Medication Profile - Medication List](http://hl7.org/fhir/us/smp/StructureDefinition/smp-medication-list). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

## Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.

      )

      id :smp_v100_list
      run_as_group

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'list', 'metadata.yml'), aliases: true))
      end
  
      test from: :smp_v100_list_patient_search_test
      test from: :smp_v100_list_code_search_test
      test from: :smp_v100_list_read_test
      test from: :smp_v100_list_validation_test
      test from: :smp_v100_list_must_support_test
      test from: :smp_v100_operation_retrieve_test, optional: true
      test from: :smp_v100_operation_submit_test, optional: true
    end
  end
end
