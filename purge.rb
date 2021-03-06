require 'sitemap-parser'
require 'http'
require 'dotenv'

Dotenv.load

response =  HTTP.headers(
  "X-Auth-Email" => ENV.fetch("CLOUDFLARE_EMAIL"),
  "X-Auth-Key" => ENV.fetch("CLOUDFLARE_API_KEY"),
  "Content-Type" => "application/json"
).post(
  "https://api.cloudflare.com/client/v4/zones/#{ENV.fetch('CLOUDFLARE_ZONE_ID')}/purge_cache",
  json: {
    files: SitemapParser.new("./docs/sitemap.xml").to_a
  }
)

p response.body.to_s
