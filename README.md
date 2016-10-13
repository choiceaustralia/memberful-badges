# Memberful Integration

[![Build Status](https://travis-ci.org/choiceaustralia/memberful-badges.svg?branch=master)](https://travis-ci.org/choiceaustralia/memberful-badges)

Integrate Discourse with Memberful's API.

## Installation

Add the following to your app container in the `after_code` hook:

```
hooks:
  after_code:
    - exec:
        cd: $home
        cmd:
          - git clone https://github.com/choiceaustralia/memberful-integration --depth 1 tmp/memberful
          - cp -r tmp/memberful/app/controllers/memberful-integration app/controllers/
          - cp -r tmp/memberful plugins/
```

This will copy your controller into discourse and install the plugin which appends the routes.
