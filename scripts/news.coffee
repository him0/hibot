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
        message = "テストリンクを投下します！\n"

        # for item in items
        #   message += "<" + item["link"] + "|" + item["title"] + ">\n"
        message += "[<http://example.com|test>]\n"

        msg.send message
    )
