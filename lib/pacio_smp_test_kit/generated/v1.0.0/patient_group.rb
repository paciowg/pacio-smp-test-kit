require_relative 'patient/patient_id_search_test'
require_relative 'patient/patient_read_test'

module PacioSMPTestKit
  module PacioSMPV100
    class PatientGroup < Inferno::TestGroup
      title 'Patient Tests'
      short_description 'Verify support for the server capabilities required by the US Core Patient Profile.'
      description %(
  # Background

The SMP Patient sequence verifies that the system under test is
able to provide correct responses for Patient queries. These queries
must contain resources conforming to the US Core Patient Profile as
specified in the SMP v1.0.0 Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* _id

### Search Parameters
The first search uses the selected resources from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. If a value cannot be found this way, the search is skipped.

### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Patient resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html).


## Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Patient resources found in the first test for these
elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [US Core Patient Profile](http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient). Each element is checked against
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

      id :smp_v100_patient
      run_as_group

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'patient', 'metadata.yml'), aliases: true))
      end
  
      test from: :smp_v100_patient__id_search_test
      test from: :smp_v100_patient_read_test
    end
  end
end
