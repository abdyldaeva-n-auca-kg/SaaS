#Elixir image as the base image
FROM elixir:1.14
#Install dependencies 
RUN apt-get update && apt-get install -y build-essential
#Setting up the working directory inside container
WORKDIR /app
#Install hex and rebar for elixir dependencies
RUN mix local.hex -f && mix local.rebar -f
#copypaste mix.exs and mix.lock to the container
COPY mix.exs mix.lock ./
#Install Elixir dependencies
RUN mix deps.get
#Copy app directory to the container
COPY . .
#Compile app
RUN mix compile
#expose port
EXPOSE 4000
#start the server
CMD ["mix", "phx.server"] 

