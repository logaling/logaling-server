## logaling-server

[![Build Status](https://secure.travis-ci.org/logaling/logaling-server.png)](http://travis-ci.org/logaling/logaling-server)

logaling-server is a Web application that allows you to easily search on the Web glossaries that are created using [the logaling-command](http://logaling.github.com/).

### To setup:

Copy .env.sample to .env.

    % cp .env.sample .env

Edit .env for your environment.

    % vim .env

Copy config/database.yml.example to config/database.yml

    % cp config/database.yml.example config/database.yml

Edit config/database.yml for your environment (and setup database if you need).

    % vim config/database.yml

Install related packages.

    % bundle install

Migrate your database.

    % bundle exec rake db:migrate

Index logaling db in your environment.

    % bundle exec rake loga:index

### To start web application

    % bundle exec foreman run rails server

You can see your logaling-server site at http://localhost:3000/.

### To import external-glossaries

    % bundle exec rake loga:import

### To deploy

Copy config/deploy.rb.example to config/deploy.rb.

    % cp config/deploy.rb.example config/deploy.rb

Edit config/deploy.rb.

    % vim config/deploy.rb

Deploy your logaling-server.

   % cap deploy

### License

  GNU GENERAL PUBLIC LICENSE Version 3. See COPYING.<br/>
(Miho Suzuki has a right to change the license including contributed patches.)

