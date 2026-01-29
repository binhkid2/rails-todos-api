### we set RAILS_ENV=development because we never want run migrate database
Generate the secret with:
bundle exec rails secret

### Fill this in .env
```
SECRET_KEY_BASE=PASTE_THE_GENERATED_VALUE
RAILS_ENV=development
DB_HOST=****
DB_PORT=****
DB_USER=****
DB_PASSWORD=****
DB_NAME=****
DB_SSL=****
```

### CORS fix
Add these to config/environments/production.rb and config/environments/development.rb
```
# Allow all localhost variants
config.hosts << /localhost/
config.hosts << /127\.0\.0\.1/

# Allow all subdomains of rubito.jp
config.hosts << /\.rubito\.jp\z/

# Allow all Vercel preview domains
config.hosts << /\.vercel\.app\z/
```
add these to config/initializers/cors.rb
```
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins(
      /localhost:\d+/,
      /\.rubito\.jp\z/,
      /\.vercel\.app\z/
    )

    resource "*",
      headers: :any,
      methods: %i[get post put patch delete options head],
      expose: %w[Authorization],
      credentials: false
  end
end
```