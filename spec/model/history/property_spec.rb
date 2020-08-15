RSpec.describe ::Model::History::Property do
  describe 'Converter' do
    let(:token) { ::Faker::Lorem.characters(10) }
    let(:options) { { token: token } }
    let(:converter) { ::Model::History::Property::Converter.new(from_object, options) }

    describe '#time' do
      let(:now) { Time.parse('2020-01-10 13:40:30') }
      let(:from_object) { double(ts: now.to_i.to_s) }

      subject { converter.time }

      it { is_expected.to eq '2020年01月10日 13:40:30' }
    end
  end
end
