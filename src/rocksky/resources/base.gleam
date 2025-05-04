import gleam/dynamic/decode
import gleam/json
import gleam/option.{None}
import gleam/uri
import rocksky/client/base.{type Client}
import rocksky/client/base as base_client
import rocksky/errors
import rocksky/types/search.{type SearchResult, Record}

pub type Resource {
  Resource(client: Client, base_path: String)
}

pub fn new(client: Client, base_path: String) -> Resource {
  Resource(client, base_path)
}

pub fn search(
  resource: Resource,
  query: String,
) -> Result(SearchResult, errors.ApiError) {
  let client = resource.client
  let path = resource.base_path <> "?q=" <> uri.percent_encode(query)

  case base_client.get(client, path, None) {
    Ok(res) -> {
      let highlight_decoder = {
        use name <- decode.optional_field(
          "name",
          None,
          decode.optional(decode.list(decode.string)),
        )
        use title <- decode.optional_field(
          "title",
          None,
          decode.optional(decode.list(decode.string)),
        )
        use copyright_message <- decode.optional_field(
          "copyright_message",
          None,
          decode.optional(decode.list(decode.string)),
        )
        decode.success(search.Highlight(name:, title:, copyright_message:))
      }
      let record_decoder = {
        use name <- decode.optional_field(
          "name",
          None,
          decode.optional(decode.string),
        )
        use picture <- decode.optional_field(
          "picture",
          None,
          decode.optional(decode.string),
        )
        use sha256 <- decode.field("sha256", decode.string)
        use uri <- decode.field("uri", decode.string)
        use xata_createdat <- decode.field("xata_createdat", decode.string)
        use xata_highlight <- decode.field("xata_highlight", highlight_decoder)
        use xata_id <- decode.field("xata_id", decode.string)
        use xata_score <- decode.field("xata_score", decode.float)
        use xata_table <- decode.field("xata_table", decode.string)
        use xata_updatedat <- decode.field("xata_updatedat", decode.string)
        use xata_version <- decode.field("xata_version", decode.int)
        use apple_music_link <- decode.optional_field(
          "apple_music_link",
          None,
          decode.optional(decode.string),
        )
        use biography <- decode.optional_field(
          "biography",
          None,
          decode.optional(decode.string),
        )
        use born <- decode.optional_field(
          "born",
          None,
          decode.optional(decode.string),
        )
        use born_in <- decode.optional_field(
          "born_in",
          None,
          decode.optional(decode.string),
        )
        use died <- decode.optional_field(
          "died",
          None,
          decode.optional(decode.string),
        )
        use spotify_link <- decode.optional_field(
          "spotify_link",
          None,
          decode.optional(decode.string),
        )
        use tidal_link <- decode.optional_field(
          "tidal_link",
          None,
          decode.optional(decode.string),
        )
        use youtube_link <- decode.optional_field(
          "youtube_link",
          None,
          decode.optional(decode.string),
        )
        use album <- decode.optional_field(
          "album",
          None,
          decode.optional(decode.string),
        )
        use album_art <- decode.optional_field(
          "album_art",
          None,
          decode.optional(decode.string),
        )
        use album_artist <- decode.optional_field(
          "album_artist",
          None,
          decode.optional(decode.string),
        )
        use artist <- decode.optional_field(
          "artist",
          None,
          decode.optional(decode.string),
        )
        use disc_number <- decode.optional_field(
          "disc_number",
          None,
          decode.optional(decode.int),
        )
        use duration <- decode.optional_field(
          "duration",
          None,
          decode.optional(decode.int),
        )
        use label <- decode.optional_field(
          "label",
          None,
          decode.optional(decode.string),
        )
        use title <- decode.optional_field(
          "title",
          None,
          decode.optional(decode.string),
        )
        use track_number <- decode.optional_field(
          "track_number",
          None,
          decode.optional(decode.int),
        )
        use album_uri <- decode.optional_field(
          "album_uri",
          None,
          decode.optional(decode.string),
        )
        use artist_uri <- decode.optional_field(
          "artist_uri",
          None,
          decode.optional(decode.string),
        )
        use composer <- decode.optional_field(
          "composer",
          None,
          decode.optional(decode.string),
        )
        use copyright_message <- decode.optional_field(
          "copyright_message",
          None,
          decode.optional(decode.string),
        )
        use genre <- decode.optional_field(
          "genre",
          None,
          decode.optional(decode.string),
        )
        use lyrics <- decode.optional_field(
          "lyrics",
          None,
          decode.optional(decode.string),
        )
        use mb_id <- decode.optional_field(
          "mb_id",
          None,
          decode.optional(decode.string),
        )
        decode.success(Record(
          name:,
          picture:,
          sha256:,
          uri:,
          xata_createdat:,
          xata_highlight:,
          xata_id:,
          xata_score:,
          xata_table:,
          xata_updatedat:,
          xata_version:,
          apple_music_link:,
          biography:,
          born:,
          born_in:,
          died:,
          spotify_link:,
          tidal_link:,
          youtube_link:,
          album:,
          album_art:,
          album_artist:,
          artist:,
          disc_number:,
          duration:,
          label:,
          title:,
          track_number:,
          album_uri:,
          artist_uri:,
          composer:,
          copyright_message:,
          genre:,
          lyrics:,
          mb_id:,
        ))
      }

      let records_decoder = {
        use table <- decode.field("table", decode.string)
        use record <- decode.field("record", record_decoder)
        decode.success(search.Records(table:, record:))
      }

      let search_decoder = {
        use total_count <- decode.field("totalCount", decode.int)
        use records <- decode.field("records", decode.list(records_decoder))
        decode.success(search.SearchResult(total_count:, records:))
      }

      case json.parse(from: res.body, using: search_decoder) {
        Ok(search_result) -> {
          Ok(search_result)
        }
        Error(error) -> {
          echo error
          Error(errors.JsonParseError("Failed to parse search result"))
        }
      }
    }
    Error(error) -> {
      Error(error)
    }
  }
}
