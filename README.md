Linda Skype
===========
send skype message with RocketIO::Linda

* https://github.com/shokai/linda-skype
* watch Tuples ["skype", "send", String] and send message.
* write a Tuple ["skype", "send", String, "success"].

Dependencies
------------
- Skype
- Mac or Linux
- Ruby 1.8.7~2.0.0
- [LindaBase](https://github.com/shokai/linda-base)


Install Dependencies
--------------------

    % gem install bundler foreman
    % bundle install


Run
---

set ENV var "LINDA_BASE", "LINDA_SPACE" and "CHAT_TOPIC"

    % export LINDA_BASE=http://linda.example.com
    % export LINDA_SPACE=test
    % export CHAT_TOPIC='linda chat'
    % bundle exec ruby linda-mac-say.rb

or

    % LINDA_BASE=http://linda.example.com LINDA_SPACE=test CHAT_TOPIC='linda chat' bundle exec ruby linda-skype.rb


Install as Service
------------------

for launchd (Mac OSX)

    % sudo foreman export launchd /Library/LaunchDaemons/ --app linda-skype -u `whoami`
    % sudo launchctl load -w /Library/LaunchDaemons/linda-skype-skype-1.plist

for upstart (Ubuntu)

    % sudo foreman export upstart /etc/init/ --app linda-skype -d `pwd` -u `whoami`
    % sudo service linda-skype start
