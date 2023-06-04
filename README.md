## Introduction 

Funny movies project:

- User module: sign-in, sign-out, sign-up
- Video module: share a Youtube video and integrate to Youtube to get video metadata, see list of shared videos
- Notification module: you will receive a notification when someone sharing a video with you immediately

## Prerequisites

List required software and tools:
- Git
- Ruby 3.1.2
- Node `14.16.1 on macOS` or `14.16.0 on ubuntu`.
- sqlite3
- Redis 7.0.11.
- chromedriver 113.0.5672.63

## Installation & Configuration

Use ruby version manager to install ruby e.g [rvm](https://rvm.io/rvm/install). After installed rvm just run simple command

```
rvm install 3.1.2
```

Check ruby version by `ruby -v` you will see similar message

```
ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [arm64-darwin22]
```

Use node version manager to install node e.g [nvm](https://github.com/nvm-sh/nvm). After installed nvm just run simple command

```
nvm install 14.16.0 # on Ubuntu
or
nvm install 14.16.1 # on macOS
```

Check node version by `node --version` you will see similar message

```
v14.16.1 # on macOS
OR
v14.16.0 # on Ubuntu
```

Install sqlite3 on ubuntu jsut do `sudo apt-get install sqlite3`. Install on macOS just do `brew install sqlite`. Check sqlite is ready by `sqlite3 --version` you will see similar message

```
3.39.5 2022-10-14 20:58:05 554764a6e721fab307c63a4f98cd958c8428a5d9d8edfde951858d6fd02daapl
```

Download chromedriver [here](https://chromedriver.chromium.org/downloads). On macOS just use [brew](https://formulae.brew.sh/cask/chromedriver). Check chromedriver is ready by `which chromedriver` you will see similar message

```
/opt/homebrew/bin/chromedriver
```

Install redis on ubuntu `sudo apt-get install redis-server`. Install on macOS just do `brew install redis`. Check redis-server is ready by `redis-cli ping`  you will see similar message

```
PONG
```

Then create workspace directory and clone project

```
mkdir ~/workspaces && cd ~/workspaces && git clone git@github.com:dangquangthai/funny_movies.git
```

Bundling

```
cd funny_movies && bundle install
```

## Database Setup

Create databases

```
bundle exec rails db:create db:migrate
```

Import/re-import demo data

```
bundle exec rails db:schema:load db:fixtures:load
```

## Running the Application

Start server on development environment

```
bin/dev
```

Run unit tests

```
bundle exec rspec spec/
```

Run integration tests

```
RAILS_ENV=test rails db:schema:load db:fixtures:load && INTEGRATION_TEST=true bundle exec rspec spec/integration/
```

## (BE/FS) Docker Deployment

Instructions for deploying the application using Docker, including building the Docker image and running containers (optional for Backend developer)

## Usage

### Quick test

Please import demo data then start development server on local machine, lets test:

- Open link http://localhost:3000 on your browser.
- Sign in with email=`smith@remitano.com`, password=`ThisIs@Very5Pass`
- Open another browser with same link
- Sign in with email=`john@remitano.com`, password=`ThisIs@Very5Pass`
- Open first browser (logged-in as Smith), click on `Share a video` button then put a youtube url. After shared a video you will got message and on second browser (logged-in as John) you will see a notification message immediately.

Do some tests based on requirement.

### Technical review

The important point when choosing an technical is less code but still cover requirement

- Async load sign-up form and welcome banner by hotwire turbo-frame. I will tell you `why we need to async-load for this part ?`.
- Load realtime notification messages by hotwire turbo-stream.
- Designed notification module ready to make it bigger in future if has requirement.
- Used stimulus-controller to eaiser control javascript code.
- Used view-component to render and re-use views instead of partical.
- Used [CurrentAttributes](https://api.rubyonrails.org/classes/ActiveSupport/CurrentAttributes.html) to easier get `current_user` in services, components without pass it.
- Used simple coverage to check test coverage. After run all unit tests open `coverage/index.html` to see coverage report.
- Used ruboop, brakeman to scan smell code for ruby.
- We should use eslint to scan smell code for typescript (Not implemented yet).
- Used bullet to raise when getting N+1 issues on development environment. In my opinion we toally check N+1 issues when building source code like rubocop, brakeman and eslint. Please ask me more if you are really interested.
- Automation testing - very clear for each use case
- Used [fixtures data](https://guides.rubyonrails.org/testing.html#the-low-down-on-fixtures) instead of `FactoryBot#create` to make test with many data faster.

## Troubleshooting


