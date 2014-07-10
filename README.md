# HaxxorNews

This is a ~~more stylish~~ clone of [Hacker News](https://news.ycombinator.com/) created as part of the [Rails
developer internship](http://viget.com/about/careers/summer-2014-developer-intern)
at [Viget](http://viget.com/).

If you want to check it out it's hosted [on Heroku](http://viget-hn.herokuapp.com/).
If you want to run it locally you'll need to have rails, postgres running, and
possibly configure your database.yml for postgres. Then:

```
bundle install
rails db:create
rails db:schema:load
rails s
```
