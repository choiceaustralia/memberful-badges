# Memberful Integration

[![Build Status](https://travis-ci.org/choiceaustralia/memberful-integration.svg?branch=master)](https://travis-ci.org/choiceaustralia/memberful-integration)

Integrate Discourse with Memberful's API via a Rails Engine

## Web Hooks

This app currently responds to the following web hooks:

* `order.purchased`
* `order.suspended`
* `member_signup`

Controllers and specs are copied into discourse and the plugin creates the relevant routes.

## Installation

<<<<<<< HEAD
Set your secret key in your config (do not save this key to a repository):

`DISCOURSE_MEMBERFUL_WEBHOOK_SECRET: secret`
=======
Add the following to your app in the `after_code` hook:

```
hooks:
  after_code:
    - exec:
        cd: $home
        cmd:
          - git clone https://github.com/choiceaustralia/memberful-integration --depth 1 plugins/memberful
          - cp -r plugins/memberful/app/controllers/memberful app/controllers/
          - cp -r plugins/memberful/spec/controllers/memberful spec/controllers/
```
>>>>>>> as-plugin

Enter app: `sudo ./launcher enter app`

Follow these instructions to mount the engine: https://gist.github.com/rimian/170d480c1979b3b6b0880ed0cace31de

Restart app: `sudo ./launcher restart app`

<<<<<<< HEAD
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
=======
```
cp -r plugins/memberful/app/controllers/memberful app/controllers/
cp -r plugins/memberful/spec/controllers/memberful spec/controllers/
```

To test the fixtures with curl:

```
fixture=$(<spec/fixtures/member_signup.json)
curl -H "Content-Type: application/json" -X POST -d $fixture http://0.0.0.0/memberful/memberful
```

## Testing

Copy the specs (as above)

```
bundle exec rspec spec/controllers/memberful
>>>>>>> as-plugin
```

Run the specs:

`bundle exec rspec`

## Status

You can check what version is currently installed here:

* https://choice.community/memberful/status
