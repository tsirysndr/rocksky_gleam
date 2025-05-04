# rocksky_gleam

[![test](https://github.com/tsirysndr/rocksky_gleam/actions/workflows/test.yml/badge.svg)](https://github.com/tsirysndr/rocksky_gleam/actions/workflows/test.yml)
[![Package Version](https://img.shields.io/hexpm/v/rocksky)](https://hex.pm/packages/rocksky)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/rocksky/)

The official [Rocksky](https://rocksky.app) Gleam client library.

```sh
gleam add rocksky@1
```
```gleam
import gleam/option.{None, Some}
import rocksky/client/base
import rocksky/resources/scrobbles

pub fn main() {
  let client = base.new(None, None)

  scrobbles.new(client)
  |> scrobbles.get_scrobbles(Some("tsiry-sandratraina.com"))
  |> echo
}

```

Further documentation can be found at <https://hexdocs.pm/rocksky>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
