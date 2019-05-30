# Chat System
Chat System Application

# Pre-Requirements
First install docker, docker compose for your machine and start it. How this is done is very well documented all over the internet. 


* Ruby version
> ruby 2.4.1
>
> rails 5.1.2

# Build the project
> clone the repo
> 
> cd /repo
> 
> sudo docker-compose up -d

# Database creation
> sudo docker-compose run app rake db:create

<!-- * Database initialization
> sudo docker-compose run app rake db:migrate -->

* Services (job queues, cache servers, search engines, etc.)
> Job Queue: Sidekiq
>
> Cache Server: Redis
>
> Search Engine: Elasticsearch
