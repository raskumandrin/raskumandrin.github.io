FROM ruby:2.7.6

WORKDIR /app
RUN gem update --system
RUN gem install sass-embedded -v 1.63.6
RUN gem install jekyll bundler

COPY . .

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--livereload", "--host", "0.0.0.0"]

# docker build -t jekyll .
# docker image ls
# docker run -dp 4000:4000 -v "$(pwd):/app" jekyll