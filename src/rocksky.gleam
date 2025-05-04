import gleam/option.{None}
import rocksky/client/base
import rocksky/resources/tracks.{get_track}

pub fn main() {
  let client = base.new(None, None)

  get_track(
    tracks.new(client),
    "did:plc:7vdlgi2bflelz7mmuxoqjfcr/app.rocksky.song/3lhtyr34rnk2h",
  )
  |> echo
}
