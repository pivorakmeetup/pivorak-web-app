# PivorakWebApp

**PivorakWebApp**

[![Build Status](https://travis-ci.org/pivorakmeetup/pivorak-web-app.svg?branch=development)](https://travis-ci.org/pivorakmeetup/pivorak-web-app)
[![codecov](https://codecov.io/gh/pivorakmeetup/pivorak-web-app/branch/development/graph/badge.svg)](https://codecov.io/gh/pivorakmeetup/pivorak-web-app)
[![Code Climate](https://codeclimate.com/github/pivorakmeetup/pivorak-web-app/badges/gpa.svg)](https://codeclimate.com/github/pivorakmeetup/pivorak-web-app)
[![Issue Count](https://codeclimate.com/github/pivorakmeetup/pivorak-web-app/badges/issue_count.svg)](https://codeclimate.com/github/pivorakmeetup/pivorak-web-app)

# Setup
```sh
$ git clone git@github.com:pivorakmeetup/pivorak-web-app.git
$ cd pivorak-web-app
$ rvm use ruby-2.3.1@pivorak --create
$ bundle
$ cp config/database.yml.example config/database.yml
$ rails db:setup
$ cp config/environments/development.rb.example config/environments/development.rb
$ rails s
```

# Chat

Join our [slack](http://pivorak-slack.herokuapp.com) chat!
We have special `#pivorak-web-app` channel for contributors.

# Git Branches

* `master` - stable code, production deployment.
* `development` - dev branch, staging deployment. Please checkout your new branch from it.

# Contribution

1. Detect which [issue](https://github.com/pivorakmeetup/pivorak-web-app/issues) you want to resolve. Write comment about this and how you supposed to do this.
2. Fork project (if you don't have permissions to push).
3. Checkout new branch with name `"#{issue_id}-#{add or fix or improve}-#{job-done-description}"` (`77-add-feature`), **write tests**, write code, compose nice commit message `"##{issue-id} commit message text"`(`#77 Add feature :tada:` -> you may use emoji) and push your branch to origin.
4. Create merge request into **development** branch, add reviewers.
5. Thank you!

# Layers

## Model
Model should containe only data-logic.
- Processing -> to service/interactor.
- Complex queries -> to finders
- Predicates -> to policy.

## View
View should be clean as much as possible. Please, use helpers to avoid call methods with some params at template.

## Controller
Skinny controller. Only REST. Only 7 allowed actions (index, show, new, create, edit, update, destroy). If you need additional action - extract to new sub-controller


## Service
Single responsibility resource action that represents business logic.
Only one public method allowed `.call`. Everething else - to private

## Finder
QueryObject.


## Policy
Domain predicates store. Knows answers for all questions.

# Info

1. [Travis CI](https://github.com/pivorakmeetup/pivorak-web-app/wiki/Services#travis-ci)
2. [Code Climate CLI](https://github.com/pivorakmeetup/pivorak-web-app/wiki/Services#codeclimate)

# How to report a bug

1. Go to [issue tracker](https://github.com/pivorakmeetup/pivorak-web-app/issues/new)
2. Add descriptive **title**
3. Add **steps** to reproduce with screenshots
4. Add label **bug**
5. What **happens** and what you **expected to happen**
6. Browser if it is UI related issue
