RSpec.describe ::Slacktail::History::History do
  describe '.filtered?' do
    let(:text) { 'hello slacktail' }
    let(:content_text) { double(text: text) }
    let(:contents_list) { double(text: content_text) }

    let(:include) { ['hello'] }
    let(:exclude) { ['exclude'] }
    let(:parameter) { double(include: include, exclude: exclude) }
    let(:channel) { double(parameter: parameter) }

    let(:message) { double }

    before do
      allow_any_instance_of(described_class)
        .to receive(:contents_list)
        .and_return(contents_list)
    end

    subject { described_class.new(channel: channel, message: message).filtered? }

    context 'text contains "include"' do
      it { is_expected.to be false }
    end

    context 'text contains "exclude"' do
      let(:text) { 'some exclude' }

      it { is_expected.to be true }
    end

    context 'text not contains either' do
      let(:text) { 'some hoge' }

      it { is_expected.to be false }
    end

    context 'text contains both' do
      let(:text) { 'some hello exclude' }

      it { is_expected.to be false }
    end

    context 'text is empty' do
      let(:text) { '' }

      it { is_expected.to be false }
    end
  end
end
