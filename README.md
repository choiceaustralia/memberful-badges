# Memberful Integration

[![Build Status](https://travis-ci.org/choiceaustralia/memberful-integration.svg?branch=master)](https://travis-ci.org/choiceaustralia/memberful-integration)

Integrate Discourse with Memberful's API.

## Installation

Enter app: `sudo ./launcher enter app`

Follow these instructions to mount the engine: https://gist.github.com/rimian/170d480c1979b3b6b0880ed0cace31de

Restart app: `sudo ./launcher restart app`

## Upgrading

Enter app: `sudo ./launcher enter app`

`su discourse -c 'bundle install --no-deployment --verbose --without test --without development --path vendor/bundle'``

or

`bundle update --source memberful`

## Testing

Run the specs:

`bundle exec rspec`

To use the fixtures against a local install:

```
fixture=$(<fixtures/member_signup.json)
curl -H "Content-Type: application/json" -X POST -d $fixture http://0.0.0.0/memberful/memberful
```
