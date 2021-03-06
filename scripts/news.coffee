# Description:
#   Show the recent news
#
# Commands:
#   hubot news - show some news

random_pickup = (array, num) ->
  pickup_items = []

  while pickup_items.length < num
    r = Math.floor(Math.random() * array.length)
    pickup_item = array[r]

    if pickup_items.indexOf(pickup_item) == -1
      pickup_items.push(pickup_item)

  return pickup_items

module.exports = (robot) ->
  robot.respond /ニュース|news/i, (msg) ->
    feed = require("feed-read")
    feed(
      "http://headlines.yahoo.co.jp/rss/all-c_sci.xml",
      (err,articles) ->
        throw err if (err)

        items = random_pickup(articles, 3)
        message = "ランダムで話題を投下します！\n"

        news = []
        for item in items
          title = item["title"]
          link = item["link"]
          news.push({
            title: title
            title_link: link
          })
          console.log(title)

        robot.emit 'slack.attachment',
          message: msg.message
          text: message
          content: news
    )
