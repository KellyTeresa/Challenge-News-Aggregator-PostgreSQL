require 'pry'
require 'sinatra'
# require 'csv'
require 'pg'

def db_connection
  begin
    connection = PG.connect(dbname: "news_aggregator_development")
    yield(connection)
  rescue PG::UniqueViolation
    erb :submit, locals: {title: " ", url: "URL was already submitted! Be original!", description: " "}
  ensure
    connection.close
  end
end


get '/articles' do
  articles_data = db_connection { |conn| conn.exec("SELECT * FROM articles") }
  erb :index, locals: {articles: articles_data.to_a}
end

get '/articles/new' do
  erb :submit, locals: {title: nil, url: nil, description: nil}
end

post '/articles/new' do
#  existing_urls = db_connection { |conn| conn.exec("SELECT url FROM articles") }
# check existing urls in psql db

  entry = [params["title"], params["url"], params["description"]]

  # if !PG::UniqueViolation
  #     #add info to psql
      db_connection do |conn|
       conn.exec_params("INSERT INTO articles (title, url, description) VALUES ($1, $2, $3)", entry)
       redirect '/articles'
      end


  # else
  # erb :submit, locals: {title: " ", url: "URL was already submitted! Be original!", description: " "}
  # end
end
