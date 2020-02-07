function restart_et {
  docker-compose down -v --remove-orphans
  docker-compose -f docker-compose.tools.yml run --rm composer install 
  docker-compose -f docker-compose.tools.yml run --rm node npm i
  docker-compose -f docker-compose.tools.yml run --rm node npm run build:parallel 
  docker-compose up -d
  docker-compose stop cycler
  docker-compose logs -f event-ticketing forwarder
}

function et_build_docker {
  VERSION=${@}
  if [ VERSION = "" ]; then
    echo "NO VERSION GIVEN TO BUILD"
    return 2
  fi
  if [ ! -d ${VERSION} ]; then
    echo "MAKE SURE TO BE IN THE docker-event-ticketing FOLDER AND THE VERSION IS EXISTING"
    return 2
  fi
  docker build --tag docker.wdf.sap.corp:50002/event-ticketing/event-ticketing-${VERSION}-snapshot ${VERSION}
}

alias etr='restart_et'
