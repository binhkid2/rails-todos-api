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