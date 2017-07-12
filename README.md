# Identicon

elixir lib to generate 5x5 pixel grid image from MD5 of the passed string

## Use

```bash
git clone git@github.com:sa77/identicon.git
cd identicon
# get all dependencies
mix deps.get
# run elixir app in iex interactive mode
iex -S mix
Identicon.main('identicon')
# generates tmp/identicon.png
# exit from iex and open generated image
open tmp/identicon.png
```

## Test

```bash
cd identicon
mix test
```

## Documentation

```bash
# generate documentation
mix docs
open doc/index.html
```

