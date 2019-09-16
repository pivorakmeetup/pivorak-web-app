# Contributing to PivorakWebApp
:+1::tada: Greetings, contributor! From the #pivorak Ruby usergroup we want to say thank you for joining us on this path to community development. We appreaciate your effort, every change counts!
 :tada::+1:

The following is a set of guidelines for contributing to PivorakWebApp. We've tried our best to ease this process for you, so please read it carefully.

#### Table Of Contents
- [Code of conduct](https://pivorak.com/code-of-conduct)
- [How to setup project](#how-to-setup-project)
    - [Option 1: Without docker](#option-1-without-docker)
    - [Option 2: With docker](#option-2-with-docker)
- [How to report a bug](#how-to-report-a-bug)
- [What should I know before I get started?](#what-should-i-know-before-i-get-started)
    - [Git Branches](#git-branches)
    - [Design Decisions](#design-decisions)

# How to setup project
## Option 1: Without docker
#### Step 1: Clone the repo
```sh
$ git clone https://github.com/pivorakmeetup/pivorak-web-app.git
```
#### Step 2: Install dependencies
- Install ruby 2.3.1
```sh
$ cd pivorak-web-app
$ rvm install ruby-2.3.1
```
- Install gems
```sh
$ rvm use ruby-2.3.1@pivorak --create
$ bundle
```
- Setup database
    **Notice:** Before database setup you should install *Redis*. Look install instructions here:
    - for Ubuntu: https://goo.gl/PbG00W
    - for MacOS: https://goo.gl/W8xQMJ

    **Notice:**  You should have PostgreSQL >= 9.4
    To check your version
```sh
$ psql --version
```

```sh
$ cp config/database.yml.example config/database.yml
$ rails db:setup
$ rails s
```

## Option 2: With docker
#### Step 1: Install [Docker](https://docs.docker.com/install/) and [Docker Compose](https://docs.docker.com/compose/install/)
#### Step 2: Clone the repo
```sh
$ git clone https://github.com/pivorakmeetup/pivorak-web-app.git
```
#### Step 3: Clone database config
```sh
$ cd pivorak-web-app
$ cp config/database.yml.example config/database.yml
```
#### Step 4: Build project
```sh
$ docker-compose build
$ docker-compose run runner bundle install
```

**Notice:** How to deal with docker?

**Test environment:**
To run tests, first setup test database
```sh
$ docker-compose run -e RAILS_ENV=test runner bundle exec rails db:setup
```
and then run test suite

```sh
$ docker-compose run runner bundle exec rspec
```

**Development environment:**
To run the app in development, first prepare development database
```sh
$ docker-compose run runner bundle exec rails db:setup
```
and then execute
```sh
$ docker-compose up rails
```

# How to contribute

1. Detect which [issue](https://github.com/pivorakmeetup/pivorak-web-app/issues) you want to resolve. Write comment about this and how you supposed to do this.
2. Fork project *(if you don't have permissions to push)*.
3. Prepare your solution step by step:
    - Checkout new branch: `"#{issue_id}-#{add or fix or improve}-#{job-done-description}"`

        *For example:* `77-add-payments-feature`

    - **Write tests**
    - Write code

    - Compose descriptive commit message `"##{issue-id} commit message text"`

        *For example:* `#77 Add payments feature :tada:` -> *you may use emoji*

    -  Push your branch to origin.

4. Create merge request into **development** branch, add reviewers.
5. **Thank you!**


# What should I know before I get started?
## Git Branches

The main and the most up-to-date branch of the project is `development` branch.
Please checkout your new branch from `development` branch.
And use `development` branch for deployment to production.

## Design Decisions
- We use Ruby on Rails as a framework but with some additional application design layers.
### Layers:
- Model
- View
- Controller
- Service
- Finder
- Policy

#### Model
Model should containe only data-logic.
- Processing -> to service/interactor.
- Complex queries -> to finders
- Predicates -> to policy.

#### View
View should be clean as much as possible. Please, use helpers to avoid call methods with some params at template.

#### Controller
Skinny controller. Only REST. Only 7 allowed actions (index, show, new, create, edit, update, destroy). If you need additional action - extract to new sub-controller


#### Service
Single responsibility resource action that represents business logic.
Only one public method allowed `.call`. Everething else - to private

#### Finder
QueryObject.


#### Policy
Domain predicates store. Knows answers for all questions.

# How to report a bug

1. Go to [issue tracker](https://github.com/pivorakmeetup/pivorak-web-app/issues/new)
2. Add descriptive **title**
3. Add **steps** to reproduce with screenshots
4. Add label **bug**
5. What **happens** and what you **expected to happen**
6. Browser if it is UI related issue

Congratulations with achievement - you've made it till the end of the file! These are mostly guidelines, not rules. Use your best judgment, and feel free to propose changes to this document in a pull request.
