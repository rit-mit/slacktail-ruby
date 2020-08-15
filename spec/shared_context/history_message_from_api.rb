require 'slack-ruby-client'

shared_context 'history message from api' do
  # rubocop:disable all
  let(:response_of_files) do
    {"ok"=>true,
        "latest"=>"1553300582",
        "oldest"=>"1553246793",
        "messages"=>
            [{"type"=>"message",
              "text"=>"this is image",
              "files"=>
                  [{"created"=>1553300578,
                    "timestamp"=>1553300578,
                    "name"=>"image.png",
                    "title"=>"Pasted image at 2019-05-23, 9:22 AM",
                    "mimetype"=>"image/png",
                    "url_private_download"=>"https://files.slack.com/files-pri/AAABBB/download/image.png",
                    "filetype"=>"png",
                    "pretty_type"=>"PNG",
                    "editable"=>false,
                   }],
              "upload"=>true,
              "display_as_bot"=>false}],
        "has_more"=>false,
        "unread_count_display"=>0}
  end

  let(:response_of_text) do
    {"ok"=>true,
     "latest"=>"1553301196",
     "oldest"=>"1553300582",
     "messages"=>
         [{"text"=>"this is text"}],
     "has_more"=>false,
     "unread_count_display"=>0}
  end

  # NOTE: attachmentの内容は https://api.slack.com/docs/message-attachments から。
  let(:response_of_attachments) do
    {"ok"=>true,
     "latest"=>"1553301196",
     "oldest"=>"1553300582",
     "messages"=>
         [{"type"=>"message",
           "text"=>"this is attachment",
           "attachments"=> [
               {
                   "fallback"=> "Required plain-text summary of the attachment.",
                   "color"=> "#2eb886",
                   "pretext"=> "Optional text that appears above the attachment block",
                   "author_name"=> "Bobby Tables",
                   "author_link"=> "http=>//flickr.com/bobby/",
                   "author_icon"=> "http=>//flickr.com/icons/bobby.jpg",
                   "title"=> "Slack API Documentation",
                   "title_link"=> "https=>//api.slack.com/",
                   "text"=> "Optional text that appears within the attachment",
                   "fields"=> [
                       {
                         "title"=> "Priority",
                         "value"=> "High",
                         "short"=> false
                       }
                   ],
                   "image_url"=> "http=>//my-website.com/path/to/image.jpg",
                   "thumb_url"=> "http=>//example.com/path/to/thumb.png",
                   "footer"=> "Slack API",
                   "footer_icon"=> "https=>//platform.slack-edge.com/img/default_application_icon.png",
                   "ts"=> 123456789
               }]
           }],
     "has_more"=>false,
     "unread_count_display"=>0}
  end
  # rubocop:enable all

  let(:response_from_api) { response_of_text }
  before do
    allow_any_instance_of(::Slack::Web::Client).to receive(:conversations_history).and_return(response_from_api)
  end
end
