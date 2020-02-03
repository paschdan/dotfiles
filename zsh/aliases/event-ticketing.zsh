function restart_et {
  docker-compose down -v
  docker-compose up -d
  docker-compose stop cycler
  docker-compose logs -f event-ticketing forwarder
}

alias etr='restart_et'
