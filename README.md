# Memberful Integration

[![Build Status](https://travis-ci.org/choiceaustralia/memberful-integration.svg?branch=master)](https://travis-ci.org/choiceaustralia/memberful-integration)

Integrate Discourse with Memberful's API via a Rails Engine

## Web Hooks

This app currently responds to the following web hooks:

* `order.purchased`
* `order.suspended`
* `member_signup`

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

There are example users that respond to test web hooks:

https://choice.memberful.com/admin/settings/integrate/webhooks

Developers might like to use the fixtures against a local install:

```
fixture=$(<spec/support/fixtures/member_signup.json)
curl -H "Content-Type: application/x-www-form-urlencoded" -v -X POST -d $fixture http://0.0.0.0/memberful/hooks
```

Run the specs:

`bundle exec rspec`

## Status

You can check what version is currently installed here:

* https://choice.community/memberful/status
