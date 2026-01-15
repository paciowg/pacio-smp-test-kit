# @note includes RSpec shared context 'when testing a runnable'
RSpec.describe PacioSMPTestKit::PacioSMPV100::BundleGroup do
  let(:suite_id) { 'smp_v100' }
  let(:group) { suite.groups.find { |g| g.id.include?(described_class.id) } }
  let(:url) { 'http://example.com/fhir' }
  let(:bundle_id) { 'bundle-1' }
  let(:bundle) do
    FHIR::Bundle.new(
      id: bundle_id,
      type: 'collection',
      total: '1',
      entry: [
        {
          resource: FHIR::List.new(id: 'list')
        },        
        {
          resource: FHIR::Patient.new(id: 'patient-1')
        },
        {
          resource: FHIR::MedicationAdministration.new(id: 'med-admin')
        },        
        {
          resource: FHIR::MedicationStatement.new(id: 'med-statement')
        },        
        {
          resource: FHIR::Medication.new(id: 'med')
        },        
        {
          resource: FHIR::MedicationRequest.new(id: 'med-request')
        },        
        {
          resource: FHIR::MedicationDispense.new(id: 'med-dispense')
        },        
        {
          resource: FHIR::Bundle.new(id: 'smp-med-action-plan-bundle')
        },        
        {
          resource: FHIR::Practitioner.new(id: 'practitioner')
        },        
        {
          resource: FHIR::PractitionerRole.new(id: 'practitioner-role')
        },        

      ]
    )
  end

  describe 'read test' do
    let(:test) { group.tests.find { |t| t.id.include?('read') } }
    let(:test_scratch) { {} }

    it 'passes search with Bundle returned' do
      stub_request(:get, "#{url}/Bundle/#{bundle_id}")
        .to_return(status: 200, body: bundle.to_json)

      allow_any_instance_of(test)
        .to receive(:scratch).and_return(test_scratch)

      result = run(test, url: url, bundle_resource_ids: bundle_id)
      scratch_resources = test_scratch[:bundle_resources]

      expect(result.result).to eq('pass'), result.result_message
      expect(scratch_resources).to_not be_empty
    end
  end

  describe 'must support test' do
    let(:test) { group.tests.find { |t| t.id.include?('must_support') } }

    it 'passes if the Bundle has all must support elements' do
      allow_any_instance_of(test)
        .to receive(:scratch).and_return(
          {
            bundle_resources: {
              all: [
                bundle
              ]
            }
          }
        )

      result = run(test, url: url)
      expect(result.result).to eq('pass')
    end
  end
end
