RSpec.describe GeocoderService::Client, type: :client do
  subject { described_class.new(connection: connection) }

  let(:status) { 200 }
  let(:headers) { { 'Content-type' => 'application/json' } }
  let(:body) { {} }

  before do
    stubs.get('geocoder') {
      [status, headers, body.to_json]
    }
  end

  describe '#geocoder (exist city)' do
    let(:city) { 'Екатеринбург' }
    let(:body) { [56.8385216, 60.6054911] }

    it 'returns body' do
      expect(subject.coordsByCity(city)).to eq(body)
    end
  end
end
