require 'haml'

RSpec.describe ::Slacktail::Presenter do
  describe '.output' do
    let(:content_text) { build :history_content_text }
    let(:content_files) { build_collection :history_content_file, 3 }
    let(:content_attachments) { build_collection :history_content_attachment, 3 }

    let(:content_list) do
      ::Slacktail::History::ContentList.new(
        text: content_text,
        files: content_files,
        attachments: content_attachments
      )
    end
    let(:history) { double(content_list: content_list, filtered?: false) }

    subject { described_class.new.output(history) }

    context 'text message' do
      let(:content_files) { nil }
      let(:content_attachments) { nil }

      it 'should include given text' do
        is_expected.to include(content_text.text)
      end
    end
  end
end
