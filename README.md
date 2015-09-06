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
Store configuration value in envorinment variables.
They are easy to change between deploys without changing any code.

All you need to use your favorite plugins is to write their names into Gemfile.
Prpr will load them before running.

```ruby
# Gemfile
gem "prpr", github: "mzp/prpr"
gem "prpr-slack", github: "mzp/prpr-slack"
gem "prpr-checklist", github: "mzp/prpr-checklist"
gem "prpr-conflict_label", github: "mzp/prpr-conflict_label"
....
```

## LICENSE

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
