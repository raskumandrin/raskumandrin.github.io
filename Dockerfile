FROM ruby:2.7.6

WORKDIR /app

RUN gem install jekyll bundler

COPY . .

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--livereload", "--host", "0.0.0.0"]