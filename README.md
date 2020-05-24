<h1 align="center">
  <a href="https://www.youtube.com/watch?v=dQw4w9WgXcQ">
    <img alt="Job Seeker" title="Job Seeker" src=".github/full_logo_title.png" width="200px" />
  </a>
</h1>

<h3 align="center">
  Capus Code Challenge: Job Seeker
</h3>

<p align="center">
  <a href="https://www.ruby-lang.org/en/news/2019/10/01/ruby-2-6-5-released/">
    <img alt="Ruby Version" src="https://img.shields.io/badge/ruby-2.6.5-red?logo=ruby&color=CC342D" />
  </a>

  <a href="https://weblog.rubyonrails.org/2020/5/6/Rails-6-0-3-has-been-released/">
    <img alt="Rails Version" src="https://img.shields.io/badge/rails-6.0.3-red?logo=rails&color=CC0000" />
  </a>

  <img alt="GitHub language count" src="https://img.shields.io/github/languages/count/librity/campus_code_job_seeker?color=%2304D361" />

  <a href="https://github.com/librity">
    <img alt="Made by Librity" src="https://img.shields.io/badge/made%20by-Librity-%2304D361" />
  </a>

  <img alt="License" src="https://img.shields.io/badge/license-MIT-%2304D361" />

  <a href="https://github.com/librity/campus_code_job_seeker/stargazers">
    <img alt="Stargazers" src="https://img.shields.io/github/stars/librity/campus_code_job_seeker?style=social" />
  </a>
</p>

<p align="center">
  <a href="#-deploys">Deploys</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-about">About</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-layout">Layout</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-requirements">Requirements</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-instructions">Instructions</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-dependencies">Dependencies</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-main-features">Main Features</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-bonus-features">Bonus Features</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-license">License</a>
</p>

## 🏭 Deploys

- Production URL: [https://www.jobseeeker.com](https://www.youtube.com/watch?v=dQw4w9WgXcQ)

## 👀 About

**Part of [TreinaDev](https://treinadev.com.br/), by [Capus Code](https://campuscode.com.br/) São Paulo.**

The first of TreinaDev's [final challenges](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/fcd713b8-7b9d-4e09-98a8-0cb5f32bbf4d/TDProjeto_Final_-_Etapa01.pdf?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20200510%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20200510T050439Z&X-Amz-Expires=86400&X-Amz-Signature=e806bb30607a428e907c3049af329c1e143f945849ce0595f16ae5c6513b1412&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22%255BTD%255DProjeto%2520Final%2520-%2520Etapa01.pdf%22): a fully-featured, fully-tested employment-oriented application. It allows employers to publish and propose jobs offers to job seekers. They can then propose salaries, schedule interviews and chat with each other.

- 🇳 [Notion Project](https://www.notion.so/Job-Seeker-App-d552bcce80d44ec6acca0cf9e0fa7177)
- 🧠 [Mind Map](https://whimsical.com/YC614KMAmRZd2xQFVx5hej)

<a href="https://whimsical.com/YC614KMAmRZd2xQFVx5hej">
  <img alt="Application's Mind Map" title="Application's Mind Map" src=".github/mindmap_2020_05_10.png" />
</a>

- ↪️ [Flow Chart](https://whimsical.com/DAm28ZodewYVsAwZ2aJ4va)

<a href="https://whimsical.com/DAm28ZodewYVsAwZ2aJ4va">
  <img alt="Application's Flowchart" title="Application's Flowchart" src=".github/flowchart_2020_05_10.png.png" />
</a>

## 💅 Layout

- 🌈 [Colors](https://coolors.co/32292f-575366-777da7-23278a-d1e3dd)
- 🌠 [Logo](https://www.figma.com/file/wKpOwyyQikL7DAhEkIY4mA/Job-Seeker-Logo?node-id=1%3A36)
- 🚧 [Wire Frame](https://whimsical.com/MzhTuvjhYFbKREoBfBdnR8)
- 📜 [Font](https://fonts.google.com/specimen/Raleway?selection.family=Raleway:400,700)

## 🤖 Requirements

- [Ruby 2.6.5](https://www.ruby-lang.org/en/news/2019/10/01/ruby-2-6-5-released/), [**RBENV recommended**](https://github.com/rbenv/rbenv#installation)
- [Bundle 2.1.4](https://bundler.io/)
- [Rails 6.0.3](https://weblog.rubyonrails.org/2020/5/6/Rails-6-0-3-has-been-released/)
- [Node 12.16.x](https://nodejs.org/en/download/), [**NVM recommended**](https://github.com/nvm-sh/nvm#install--update-script)
- [Yarn 1.22.4](https://yarnpkg.com/getting-started/install#global-install)

## 🗺️ Instructions

After installing all requirements, clone the repo locally:

```bash
$ git clone git@github.com:librity/campus_code_job_seeker.git
```

Navigate into the repo and install all the gems:

```bash
$ cd campus_code_job_seeker
$ bundle install
```

Install all the npm packages with yarn:

```bash
$ yarn install
```

Create, migrate and seed the SQLite database:

```bash
$ bundle exec rails db:create db:migrate db:seed
```

Run all the tests with rspec:

```bash
$ bundle exec rspec
```

Run a development server with:

```bash
$ bundle exec rails s
```

And connect to it through http://localhost:3000.

You can also interact directly with the application using the rails console:

```bash
$ bundle exec rails c
```

<small>`bundle exec` makes sure that every command uses the gem versions specified within the `Gemfile`</small>

## ⛓️ Dependencies

### 💎 Gems

- Registration, authentication & authorization: [Devise](https://github.com/heartcombo/devise)

🧪 Tests

- Testing framework: [RSpec](https://github.com/rspec/rspec-rails)
- Integration tests: [Capybara](https://github.com/teamcapybara/capybara)
- Test coverage report: [SimpleCov](https://github.com/colszowka/simplecov)
- Factory generator: [Factory Bot Rails](https://github.com/thoughtbot/factory_bot_rails)
- Arbitrary data generator: [Faker](https://github.com/faker-ruby/faker)
- Awesome things: [Nyancat test progressbar](https://github.com/mattsears/nyan-cat-formatter)

### 📦 Node Packages

- CSS Framework: [Boostsrap](https://github.com/twbs/bootstrap)
- HTML manipulation: [JQuery](https://github.com/jquery/jquery)
- Input masking and formatter: [jQuery Mask Plugin](https://github.com/igorescobar/jQuery-Mask-Plugin)
- Pop-overs: [Popper](https://github.com/popperjs/popper-core)
- Icons: [Font Awesome Free](https://github.com/FortAwesome/Font-Awesome)

## 🏁 Main Features

Application:

- [x] Basic app setup
- [x] Logo & color palette
- [x] Mind map and Flow chart
- [x] Root/Home page

Head Hunters:

- [x] Signup, Login and Dashboard
- [x] Creates a Job Opening
- [x] Can browse Applicants
- [x] Can comment on Applicant's profile
- [x] Can check a Job Application as a standout
- [x] Can reject an Applicant
- [x] Can propose Job Offers to Applicants
- [x] Recieves feedback for accepted/rejected Job Offers
- [x] Can retire a Job Opening

Job Seeker:

- [x] Signup, Login and Dashboard
- [x] Creates and manages a profile-resume
- [x] Browses active Job Openings
- [x] Searches active Job Openings by title and description
- [x] Applies to a Job Opening
- [x] Can browse rejected Job Applications
- [x] Can browse Job Offers
- [x] Can accept Job Offers
- [x] Can reject Job Offers

## 🏆 Bonus Features

Application:

- [ ] React Rails for Chat interface and notifications
- [ ] Add pagination
- [ ] Add breadcrumbs
- [ ] Implement Omniauth Signup and Login for Head Hunters and Job Seekers
- [ ] Implement Email Confirmation for Head Hunters and Job Seekers

Head Hunters:

- [ ] Can invite applicants to an Interview
- [ ] Can write a feedback after the interview
- [ ] Can Chat with Applicants
- [ ] All Head Hunters with the same email domain are associated with a Company
- [ ] Can't change their email
- [ ] Must have profile pic

Job Seeker:

- [ ] Gets notified when invited to an Interview
- [ ] Can accept Interview invitation
- [ ] Can reject Interview invitation
- [ ] Recieves Interview feedback
- [ ] Can Chat with Head Hunters

## ⚖️ License

This software is distributed under the MIT license. Read the [LICENSE](LICENSE.md) file for further details.

---

Made with [💖](https://www.youtube.com/watch?v=ZtWTUt2RZh0) by [Librity](https://github.com/librity) 👋
