require 'vcr'

RSpec.describe 'text' do
  let(:token) { ENV['TOKEN_FOR_TEST'] || ::Faker::Lorem.characters(number: 32) }
  let(:account) { build :account, token: token }
  let(:channel) { build :channel, name: 'bot-test', account: account }
  let(:queues) { double(:queues, pop: true, push: true) }

  before do
    allow(::Cache).to receive(:fetch).and_return(nil)
  end

  subject(:tail_history) { ::Operation::Tailer.new.tail(channel, queues) }

  describe 'standard output via api response' do
    context 'api response', vcr: { cassette_name: 'text_api_response' } do
      it 'should contain target text in output' do
        expect { subject }.to output(/test text\!/).to_stdout
      end
    end
  end
end
