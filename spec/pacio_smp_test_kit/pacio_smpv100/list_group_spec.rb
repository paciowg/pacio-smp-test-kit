# @note includes RSpec shared context 'when testing a runnable'
RSpec.describe PacioSMPTestKit::PacioSMPV100::ListGroup do
  let(:suite_id) { 'smp_v100' }
  let(:group) { suite.groups.find { |g| g.id.include?(described_class.id) } }
  let(:url) { 'http://example.com/fhir' }
  let(:patient_id) { 'abc123' }
  let(:list_coding) do
    FHIR::Coding.new(
      system: 'http://loinc.org',
      code: '104203-5'
    )
  end
  let(:list) do
    FHIR::List.new(
      id: 'bsj1-smp-medListNew-4',
      code: {
        coding: [list_coding]
      }
    )
  end
  let(:bundle) do
    FHIR::Bundle.new(entry: [{ resource: list }])
  end

  describe 'code search test' do
    let(:test) { group.tests.find { |t| t.id.include?(described_class.id) } }

    before do
      allow_any_instance_of(test)
        .to receive(:scratch_resources).and_return(
          {
            all: [list],
            patient_id => [list]
          }
        )
    end

    it 'passes if a List with code was received' do
      stub_request(:get, "#{url}/List?code=#{list_coding.code}")
        .to_return(status: 200, body: bundle.to_json)
      stub_request(:get, "#{url}/List?code=#{list_coding.system}%7C#{list_coding.code}")
        .to_return(status: 200, body: bundle.to_json)

      result = run(test, url: url)

      expect(result.result).to eq('pass'), result.result_message
    end
  end
end
