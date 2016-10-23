# Memberful Integration

[![Build Status](https://travis-ci.org/choiceaustralia/memberful-integration.svg?branch=master)](https://travis-ci.org/choiceaustralia/memberful-integration)

Integrate Discourse with Memberful's API.

## Installation

Add the following to your app container in the `after_code` hook:

```
hooks:
  after_code:
    - exec:
        cd: $home
        cmd:
          - git clone https://github.com/choiceaustralia/memberful-integration --depth 1 plugins/memberful
          - cp -r plugins/memberful/app/controllers/memberful app/controllers/
```

This will copy your controller into discourse and install the plugin which appends the routes.

## Developing

Install this plugin to a local instance of discourse and the following directories:

```
cp -r plugins/memberful/app/controllers/memberful app/controllers/
```

## Testing

To use the fixtures against a local install:

```
fixture=$(<fixtures/member_signup.json)
curl -H "Content-Type: application/json" -X POST -d $fixture http://0.0.0.0/memberful/memberful
```
