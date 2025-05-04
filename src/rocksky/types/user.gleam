import gleam/option.{type Option}

pub type User {
  User(
    avatar: String,
    did: String,
    display_name: Option(String),
    handle: String,
    xata_createdat: String,
    xata_id: String,
    xata_updatedat: String,
    xata_version: Int,
  )
}
