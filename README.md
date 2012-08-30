## logaling-server

[![Build Status](https://secure.travis-ci.org/logaling/logaling-server.png)](http://travis-ci.org/logaling/logaling-server)

logaling-server is a Web application that allows you to easily search on the Web glossaries that are created using [the logaling-command](http://logaling.github.com/).

### To setup:

    % bundle install
    % bundle exec rake db:migrate
    % bundle exec rake loga:index

### To start web application

    % bundle exec rails server

You can see your logaling-server site at http://localhost:3000/.

### To import external-glossaries

    % bundle exec rake loga:import

### License

  GNU GENERAL PUBLIC LICENSE Version 3. See COPYING.<br/>
(Miho Suzuki has a right to change the license including contributed patches.)

