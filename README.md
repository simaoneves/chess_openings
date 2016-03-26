Chess Openings
==========================
Ruby gem that where you can manipulate, search for and get information from chess openings.

## TODOS:
- Write documentation
- Make CLI to parse openings from website
- Complete README
- Reduce size of description to fit RubyGem site description
- Bug -> incorrect move in "starts_with" throws NoMethodError
- Catch error if file not found -> in "from_pgn"

## Features:
- Get opening from PGN file
- Get opening from PGN string
- Get opening from array with moves
- Get opening from FEN (maybe?)
- Search opening by name
- Get all openings
- Get all openings that start with some determined moves
- Get PGN string from an opening
- Get opening from FEN
- Get FEN from opening

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'chess_openings'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chess_openings

## Usage

First things first, you need to create a new ChessOpenings object that you can:

```ruby
chess_openings = ChessOpenings.new
```

From here you can use several functions:

####.from_pgn
Get opening from PGN file

```ruby
chess_openings = ChessOpenings.new
opening = chess_openings.from_pgn('path_to/pgn_game.pgn')
opening  #=> #<Opening:0x007fda6237b510 @name="English, Sicilian reversed", @eco_code="A25", @moves=[:c4, :e5, :Nc3, :Nc6]>
```


####.from_string
Get opening from PGN string


####.from_moves
Get opening from array with moves


####.with_name
Search opening by name


####.get_all
Get all openings


####.that_start_with
Get all openings that start with some determined moves


####.from_fen
Get openings from FEN string






When you have a opening you can invoke these methods on it:

####.to_pgn
Get PGN string from an opening

####.to_fen
Get FEN from opening


## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/simaoneves/chess_openings/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
