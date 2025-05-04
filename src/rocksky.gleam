import gleam/option.{None, Some}
import rocksky/client/base
import rocksky/resources/scrobbles

pub fn main() {
  let client = base.new(None, None)

  scrobbles.new(client)
  |> scrobbles.get_scrobbles(Some("tsiry-sandratraina.com"))
  |> echo
}
