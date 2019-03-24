# Demo

See it [live on Heroku](https://stormy-earth-96381.herokuapp.com/collaborative_canvas)!

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

# Roadmap
* [x] Deploy to [Heroku](https://stormy-earth-96381.herokuapp.com/)
* [x] Create a genserver to hold the board state
* [x] Use the genserver holding the state
* [*] Verify that collaboration works (it _mostly_ does, with a refresh)
* [*] Force a refresh so everyone sees it up to date
* [ ] Expand board to 10x10
* [ ] Move collaborative_canvas to the root?

## Heroku Limits
* [50 simultaneous connections](https://devcenter.heroku.com/articles/http-routing#request-concurrency)
 (elixir can handle many more than this).
* [connections are dropped](https://devcenter.heroku.com/articles/limits#http-timeouts)
 when no data is seen in 55 seconds.
* the app will be restarted
 [every 24 hours](https://devcenter.heroku.com/articles/limits#detached-one-off-dyno-timeout).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
