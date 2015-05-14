# Description:
#   Returns title and description when links are posted
#
# Dependencies:
#   "jsdom": "~3.0.0"
#   "underscore": "1.3.3"
#
# Configuration:
#   HUBOT_HTTP_INFO_IGNORE_URLS - RegEx used to exclude Urls
#   HUBOT_HTTP_INFO_IGNORE_USERS - Comma-separated list of users to ignore
#   HUBOT_HTTP_INFO_IGNORE_DESC - Optional boolean indicating whether a site's meta description should be ignored
#   HUBOT_HTTP_INFO_NEWLINE_SEPARATOR - Optional split description and title in a new line (new message)
#
# Commands:
#   http(s)://<site> - prints the title and meta description for sites linked.
#
# Author:
#   ajacksified

jsdom = require 'jsdom'
_     = require 'underscore'

module.exports = (robot) ->

  ignoredusers = []
  if process.env.HUBOT_HTTP_INFO_IGNORE_USERS?
    ignoredusers = process.env.HUBOT_HTTP_INFO_IGNORE_USERS.split(',')

  robot.hear /(http(?:s?):\/\/(\S*))/i, (msg) ->
    url = msg.match[1]

    username = msg.message.user.name
    if _.some(ignoredusers, (user) -> user == username)
      console.log 'ignoring user due to blacklist:', username
      return

    # filter out some common files from trying
    ignore = url.match(/\.(png|jpg|jpeg|gif|txt|zip|tar\.bz|js|css)/)

    ignorePattern = process.env.HUBOT_HTTP_INFO_IGNORE_URLS
    if !ignore && ignorePattern
      ignore = url.match(ignorePattern)

    jquery = 'http://code.jquery.com/jquery-1.9.1.min.js'

    done = (errors, window) ->
      unless errors
        $ = window.$
        title = $('head title').text().replace(/(\r\n|\n|\r)/gm,'').replace(/\s{2,}/g,' ').trim()
        description = $('head meta[name=description]')?.attr('content')?.replace(/(\r\n|\n|\r)/gm,'')?.replace(/\s{2,}/g,' ')?.trim() || ''

        if title and description and not process.env.HUBOT_HTTP_INFO_IGNORE_DESC
          if process.env.HUBOT_HTTP_INFO_NEWLINE_SEPARATOR
            msg.send "#{title}\n#{description}"
          else
            msg.send "#{title} - #{description}"

        else if title
          msg.send "#{title}"

    unless ignore
      jsdom.env
        url: url
        scripts: [ jquery ]
        done: done
