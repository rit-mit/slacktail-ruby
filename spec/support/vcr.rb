require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = false

  c.configure_rspec_metadata!
  c.default_cassette_options = {
    record: :new_episodes, # カセットがなければAPIをコールしてそれを記録する
    match_requests_on: %i[method uri] # カセットを引き当てる条件
  }

  c.filter_sensitive_data('<TOKEN>') { ENV['TOKEN_FOR_TEST'] } unless ENV['TOKEN_FOR_TEST'].nil?
end
