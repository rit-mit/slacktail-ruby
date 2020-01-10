RSpec.describe ::Slacktail::History::Content::Converter::Base do
  module TestModule
  end
  module TestModule
    module Converter
    end
  end
  module TestModule
    module Converter
      class File < ::Slacktail::History::Content::Converter::Base
        def convert_huga!(_content_obj, _content); end
      end
    end
  end
  module TestModule
    class File < ::Slacktail::History::Content::Converter::Base
    end
  end

  describe '#convert' do
    let(:message) { [{ huga: 'huga' }] }
    let(:content_obj) { double }
    let(:options) { {} }
    let(:obj) { ::TestModule::Converter::File.new(options) }

    subject { obj.convert(message) }

    it 'should call convert method' do
      expect(::TestModule::File).to receive(:new).and_return(content_obj)
      expect_any_instance_of(::TestModule::Converter::File).to receive(:convert_huga!).with(content_obj, message.first)

      subject
    end
  end
end
