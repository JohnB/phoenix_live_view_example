# Demo
I created this app to see how easy it would be to expand the demo apps to real-time collaboration.
Spoiler: it was easy, in 1 day. Now just select a color and paint the canvas!

See it [live on Heroku](https://stormy-earth-96381.herokuapp.com/collaborative_canvas)!

# Roadmap
* [x] Deploy to [Heroku](https://stormy-earth-96381.herokuapp.com/)
* [x] Create a genserver to hold the board state
* [x] Use the genserver holding the state
* [*] Verify that collaboration works (it _mostly_ does, with a refresh)
* [*] Force a refresh so everyone sees it up to date
* [*] Remove unused routes (keep the source as reading material)
* [x] Look at lowest-tier Heroku pricing ($7/mo - now paying)
* [ ] Use presence to show how many users are concurrently on the site.
* [ ] Remove _some_ borders so adjacent colors blend better.
* [ ] Expand board to 10x10
* [ ] Tear it down when jerks get ahold of it

## Heroku Limits
Unclear if these still apply now that I'm paying Heroku.

* [50 simultaneous connections](https://devcenter.heroku.com/articles/http-routing#request-concurrency)
 (elixir can handle many more than this).
* [connections are dropped](https://devcenter.heroku.com/articles/limits#http-timeouts)
 when no data is seen in 55 seconds.

## Running Locally
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Learn more

  * Get Started: http://www.phoenixframework.org/docs
  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
###
