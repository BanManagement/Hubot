# hubot-BanBot

Our customized hubot instance which is used in `#BanManger` IRC channel in the EsperNet.

hubot is a chat bot built on the [Hubot][hubot] framework. It was
initially generated by [generator-hubot][generator-hubot], and configured to be
deployed on [Heroku][heroku] to get you up and running as quick as possible.

[heroku]: http://www.heroku.com
[hubot]: http://hubot.github.com
[generator-hubot]: https://github.com/github/generator-hubot

### Running hubot Locally

You can test your hubot by running the following, however some plugins will not
behave as expected unless the [environment variables](#configuration) they rely
upon have been set.

You can start hubot locally by running:

    % . ./hubot.conf
    % bin/hubot

### Scripts

* Adjusted version of @[odaillyjp](https://github.com/odaillyjp)'s [hubot-github-comments-notifier](https://github.com/odaillyjp/hubot-github-comments-notifier)
