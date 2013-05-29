Linda Skype
===========
send skype message with RocketIO::Linda

* https://github.com/shokai/linda-skype
* watch Tuples ["skype", "send", String] and send message.
* write a Tuple ["skype", "send", String, "success"] or ["skype", "send", String, "fail"].

Dependencies
------------
- Skype.app on MacOSX
- Ruby 1.8.7 (not support 1.9)
- [LindaBase](https://github.com/shokai/linda-base)


Install Dependencies
--------------------

    % gem install bundler foreman
    % bundle install


Run
---

check Chat IDs

    % bundle exec ruby show_chat_list.rb


set ENV var "LINDA_BASE", "LINDA_SPACE" and "CHAT"

    % export LINDA_BASE=http://linda.example.com
    % export LINDA_SPACE=test
    % export CHAT_ID='#shokai/$a1b2cdef3456'
    % bundle exec ruby linda-mac-say.rb

or

    % LINDA_BASE=http://linda.example.com LINDA_SPACE=test CHAT_ID='#shokai/$a1b2cdef3456' bundle exec ruby linda-skype.rb


Install as Service
------------------

for launchd (Mac OSX)

    % sudo foreman export launchd /Library/LaunchDaemons/ --app linda-skype -u `whoami`
    % sudo launchctl load -w /Library/LaunchDaemons/linda-skype-skype-1.plist
