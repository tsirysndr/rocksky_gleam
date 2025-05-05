import gleam/dynamic
import gleam/http
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/httpc
import gleam/option.{type Option, None}
import gleam/string
import rocksky/errors.{type ApiError}

pub const base_url = "https://api.rocksky.app"

pub type Client {
  Client(
    base_url: String,
    access_token: Option(String),
    api_key: Option(String),
    timeout_ms: Option(Int),
    http_client: fn(Request(String)) ->
      Result(Response(String), httpc.HttpError),
  )
}

pub fn new() -> Client {
  let http_client = fn(req) { httpc.send(req) }
  Client(base_url, None, None, None, http_client)
}

pub fn from_url(base_url: String) -> Client {
  let http_client = fn(req) { httpc.send(req) }
  Client(base_url, None, None, None, http_client)
}

pub fn from_opts(
  base_url: String,
  access_token: Option(String),
  api_key: Option(String),
  timeout_ms: Option(Int),
) -> Client {
  let http_client = fn(req) { httpc.send(req) }
  Client(base_url:, access_token:, api_key:, timeout_ms:, http_client:)
}

pub fn get(
  client: Client,
  path: String,
  query: Option(dynamic.Dynamic),
) -> Result(Response(String), ApiError) {
  make_request(client, http.Get, path, query, option.None)
}

fn make_request(
  client: Client,
  method: http.Method,
  path: String,
  _query: Option(dynamic.Dynamic),
  _body: Option(dynamic.Dynamic),
) {
  let scheme = case string.starts_with(client.base_url, "https://") {
    True -> http.Https
    False -> http.Http
  }

  let host =
    client.base_url
    |> string.replace("https://", "")
    |> string.replace("http://", "")
    |> string.replace("/", "")
  let req =
    request.new()
    |> request.set_method(method)
    |> request.set_path(path)
    |> request.set_scheme(scheme)
    |> request.set_host(host)
    |> request.set_header(
      "Authorization",
      "Bearer " <> client.access_token |> option.lazy_unwrap(fn() { "" }),
    )

  let response = case client.http_client(req) {
    Ok(res) -> {
      Ok(res)
    }
    Error(error) -> {
      echo error
      Error(errors.NetworkError("Network error"))
    }
  }

  response
}
