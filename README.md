# slacktail-ruby

- watcher for Slack messages on CUI like `tail -f`
- multi account
- colorize each slack channels
- except message include certain words
- show image on CUI

# how to

- Copy confing files "channels_config" dir
	- channels_config.yml.sample -> channels_config.yml
	- slack_tokens.yml.sample -> slack_tokens.yml
- Update Slack tokens in slack_tokens.yml
	- your Slack tokens: https://api.slack.com/custom-integrations/legacy-tokens
- Update channels which your are going to check
- Run slacktail
	- `bin/slacktail`
	- or `bin/slacktail_on_docker` for using docker
 
# ToDO

- fix bugs
- CI
- Add specs
- Use new Slack token 