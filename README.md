# Prpr [![Build Status](https://travis-ci.org/mzp/prpr.svg?branch=master)](https://travis-ci.org/mzp/prpr) [![Code Climate](https://codeclimate.com/github/mzp/prpr/badges/gpa.svg)](https://codeclimate.com/github/mzp/prpr)

Prpr is pull requests' reaction bot.

## Plugins
### Handler
Handler provides various behaviors.

 * [prpr-checklist](https://github.com/mzp/prpr-checklist)
 * [prpr-conflict_label](https://github.com/mzp/prpr-conflict_label)
 * [prpr-review_label](https://github.com/mzp/prpr-review_label)
 * [prpr-mention_comment](https://github.com/mzp/prpr-mention_comment)
 * [prpr-gemfile](https://github.com/mzp/prpr-gemfile)

### Publisher adapter
Publish adapter provides bridge to some chat service.

 * [prpr-slack](https://github.com/mzp/prpr-slack)

## Configuration
### Env
Store configuration value in envorinment variables.
They are easy to change between deploys without changing any code.

```
GITHUB_ACCESS_TOKEN - access token for your bot
GITHUB_HOST - github host for github enterprise
```

Your personal access token could be created at [settings](https://github.com/settings/tokens).

### Gemfile

All you need to use your favorite plugins is to write their names into Gemfile.
Prpr will load them before running.

```ruby
# Gemfile
gem "prpr"
gem "prpr-slack"
gem "prpr-checklist"
gem "prpr-conflict_label"
....
```

## Setup
### Deploy
See [prpr-template](https://github.com/mzp/prpr-template) for example.

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/mzp/prpr-template)

### Setup webhook

Open webhook setting of your github repository, and input lik following.

 * Payload URL: http://prpr.example.com
 * Content type: `application/x-www-form-url-encoded`
 * Which events would you like to trigger this webhook?: `Send me everytihng`

![Webhook](https://raw.githubusercontent.com/mzp/prpr/master/docs/webhook.png)

## LICENSE

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
