Chess Openings
==========================
Ruby gem that where you can manipulate, search for and get information from chess openings.

## TODOS:
- Write documentation

## Features:
- Get opening from PGN file
- Get opening from PGN string
- Get opening from array with moves
- Get opening from FEN
- Search opening by name
- Get all openings
- Get all openings that start with some determined moves
- Get PGN string from an opening
- Get FEN from an opening

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

First things first, you need to create a new ChessOpenings object:

```ruby
chess_openings = ChessOpenings.new
```

From here you can use several functions:

####.from_pgn
Get opening from PGN file

```ruby
chess_openings = ChessOpenings.new
opening = chess_openings.from_pgn('path_to/pgn_game.pgn')
#=> #<Opening:0x007fda6237b510 @name="English, Sicilian reversed", @eco_code="A25", @moves=[:c4, :e5, :Nc3, :Nc6]>
```


####.from_string
Get opening from a string, formated like a PGN file

```ruby
chess_openings = ChessOpenings.new
opening = chess_openings.from_string("1.e4 e5 2.Nf3 Nc6 3.Bb5 a6 4.Bxc6")
#=> #<Opening:0x007f820961bf60 @name="Ruy Lopez, exchange variation", @eco_code="C68", @moves=[:e4, :e5, :Nf3, :Nc6, :Bb5, :a6, :Bxc6]>
```


####.from_moves
Get opening from an array with moves (as symbols or strings)

```ruby
chess_openings = ChessOpenings.new
opening = chess_openings.from_moves [:e4, :c6, :d4, :d5]
#=> #<Opening:0x007f8209d9c910 @name="Caro-Kann defence", @eco_code="B12", @moves=[:e4, :c6, :d4, :d5]>
```

####.with_name
Search openings by name

```ruby
chess_openings = ChessOpenings.new
openings = chess_openings.with_name "alekhine defence"
=begin
[
  [ 0] #<Opening:0x007f8209de8a18 @name="Alekhine's defence", @eco_code="B02", @moves=[:e4, :Nf6]>,
  [ 1] #<Opening:0x007f8209de8950 @name="Alekhine's defence, Scandinavian variation", @eco_code="B02", @moves=[:e4, :Nf6, :Nc3, :d5]>,
  [ 2] #<Opening:0x007f8209de87e8 @name="Alekhine's defence, Spielmann variation", @eco_code="B02", @moves=[:e4, :Nf6, :Nc3, :d5, :e5, :Nfd7, :e6]>,
  ...
]
=end
```

####.get_all
Get all existing openings as an array

```ruby
chess_openings = ChessOpenings.new
all_openings = chess_openings.get_all
=begin
[
  [0] #<Opening:0x007f8209dd4b30 @name="Polish (Sokolsky) opening", @eco_code="A00", @moves=[:b4]>,
  [1] #<Opening:0x007f8209dd4a90 @name="Polish, Tuebingen variation", @eco_code="A00", @moves=[:b4, :Nh6]>,
  [2] #<Opening:0x007f8209dd49c8 @name="Polish, Outflank variation", @eco_code="A00", @moves=[:b4, :c6]>,
  ...
]
=end
```

####.that_start_with
Get all possible openings that start with determined moves

```ruby
chess_openings = ChessOpenings.new
e4_e5_openings = chess_openings.that_start_with [:e4, :e5]

=begin
[
  [0] #<Opening:0x007ff69c858258 @name="King's pawn game", @eco_code="C20", @moves=[:e4, :e5]>,
  [1] #<Opening:0x007ff69c858190 @name="KP, Indian opening", @eco_code="C20", @moves=[:e4, :e5, :d3]>,
  [2] #<Opening:0x007ff69c8580a0 @name="KP, Mengarini's opening", @eco_code="C20", @moves=[:e4, :e5, :a3]>,
  [3] #<Opening:0x007ff69a1a3dd8 @name="KP, King's head opening", @eco_code="C20", @moves=[:e4, :e5, :f3]>,
  [4] #<Opening:0x007ff69a1a3248 @name="KP, Patzer opening", @eco_code="C20", @moves=[:e4, :e5, :Qh5]>
  ...
]
=end
```

####.from_fen
Get opening from FEN string

```ruby
opening_from_fen = chess_openings.from_fen 'rnbqkbnr/pppp1ppp/8/4p3/4P3/8/PPPP1PPP/RNBQKBNR w KQkq e6 0 2'
#=> #<Opening:0x007ff69c858258 @name="King's pawn game", @eco_code="C20", @moves=[:e4, :e5]>
```





When you have a opening you can invoke these methods on it:

####.to_pgn
Get PGN string from an opening

```ruby
opening = chess_openings.from_moves [:e4, :e5, :Nf3, :Nc6, :Bb5, :a6, :Bxc6]
#=> #<Opening:0x007f820961bf60 @name="Ruy Lopez, exchange variation", @eco_code="C68", @moves=[:e4, :e5, :Nf3, :Nc6, :Bb5, :a6, :Bxc6]>
opening.to_pgn
#=> "1.e4 e5 2.Nf3 Nc6 3.Bb5 a6 4.Bxc6"
```

####.to_fen
Get FEN string of the opening

```ruby
opening = chess_openings.from_moves [:e4, :e5]
#=> #<Opening:0x007ff69c858258 @name="King's pawn game", @eco_code="C20", @moves=[:e4, :e5]>
opening.to_fen
#=> 'rnbqkbnr/pppp1ppp/8/4p3/4P3/8/PPPP1PPP/RNBQKBNR w KQkq e6 0 2'
```

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/simaoneves/chess_openings/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
