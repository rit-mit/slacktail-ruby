require 'catpix'

RSpec.describe ::Model::History::Converter do
  describe '.convert_from' do
    include_context 'history message from api'

    before do
      allow(::Catpix).to receive(:build_image_string).and_return('')
    end

    let(:options) { { token: Faker::Crypto.md5 } }
    let(:message) { response_from_api.fetch('messages').first }
    let(:channel_message) { ::Repository::SlackApi::History::Message.new(message) }

    subject { described_class.new(options).convert_from(channel_message) }

    context 'message is text' do
      let(:response_from_api) { response_of_text }

      it 'should be expected content_list' do
        content_list = subject

        expect(content_list.text.text).to eq 'this is text'

        expect(content_list.attachments).to be_nil
        expect(content_list.files).to be_nil
      end
    end

    context 'message contains files' do
      let(:response_from_api) { response_of_files }

      it 'should be expected content_list' do
        content_list = subject

        expect(content_list.text.text).to eq 'this is image'
        expect(content_list.attachments).to be_nil

        expect(content_list.files.first.content_text).not_to be_nil
        expect(content_list.files.first.name).to eq 'image.png'
      end
    end

    context 'message contains attachments' do
      let(:response_from_api) { response_of_attachments }

      it 'should be expected content_list' do
        content_list = subject

        expect(content_list.text.text).to eq 'this is attachment'
        expect(content_list.files).to be_nil

        expect(content_list.attachments.first.pretext)
          .to eq 'Optional text that appears above the attachment block'
        expect(content_list.attachments.first.text)
          .to eq 'Optional text that appears within the attachment'
        expect(content_list.attachments.first.image_context_text).not_to be_nil
        expect(content_list.attachments.first.title).to eq 'Slack API Documentation'
        expect(content_list.attachments.first.fields.first.title).to eq 'Priority'
        expect(content_list.attachments.first.fields.first.value).to eq 'High'
        expect(content_list.attachments.first.fields.first.short).to eq false
      end
    end
  end
end
