# @note includes RSpec shared context 'when testing a runnable'
RSpec.describe PacioSMPTestKit::PacioSMPV100::BundleGroup do
  let(:suite_id) { 'smp_v100' }
  let(:group) { suite.groups.find { |g| g.id.include?(described_class.id) } }
  let(:url) { 'http://example.com/fhir' }
  let(:bundle_id) { 'bundle-1' }
  let(:bundle) do
    FHIR::Bundle.new(
      id: bundle_id
    )
  end

  describe 'read test' do
    let(:test) { group.tests.find { |t| t.id.include?('read') } }

    it 'passes search with Bundle returned' do
      stub_request(:get, "#{url}/Bundle/#{bundle_id}")
        .to_return(status: 200, body: bundle.to_json)

      result = run(test, url: url, bundle_resource_ids: bundle_id)

      expect(result.result).to eq('pass'), result.result_message
    end
  end
end
