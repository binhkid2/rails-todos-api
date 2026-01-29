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
