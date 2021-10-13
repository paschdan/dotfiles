function restart_et {
  docker-compose -f docker-compose.tools.yml -f docker-compose.yml -f docker-compose.override.yml pull
  docker-compose -f docker-compose.tools.yml -f docker-compose.override.yml -f docker-compose.yml down -v --remove-orphans
  docker-compose -f docker-compose.tools.yml run --rm composer install 
  docker-compose up -d
  docker-compose stop cycler
  docker-compose -f docker-compose.tools.yml run --rm node npm i
  docker-compose -f docker-compose.tools.yml run --rm node npm run build:parallel 
  docker-compose logs -f event-ticketing forwarder
}

function restart_et_soft {
  docker-compose -f docker-compose.tools.yml -f docker-compose.override.yml -f docker-compose.yml down -v --remove-orphans
  docker-compose up -d
  docker-compose stop cycler
  docker-compose logs -f event-ticketing forwarder
}

function stop_et {
  docker-compose -f docker-compose.tools.yml -f docker-compose.override.yml -f docker-compose.yml down
}

function start_et {
  docker-compose up -d
  docker-compose stop cycler
  docker-compose logs -f event-ticketing forwarder
}

alias etr='restart_et_soft'
alias etrd='restart_et'
alias ets='stop_et'
alias etu='start_et'

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
  docker build --no-cache --tag docker.wdf.sap.corp:50002/event-ticketing/event-ticketing-${VERSION}-snapshot ${VERSION}
}


## testing

function tt {
  FILE=${@}
  TESTKIND=${FILE%%/*}
  COMMAND="./docker/codecept.sh run ${TESTKIND} tests/${FILE}"
  echo ${COMMAND}
  eval ${COMMAND}
}

function cjt {
  FILE=${@}
  # web/js/csp/merchant/editor/fixDialogLength.js:1
  FILE="${FILE%%/*}/test/${FILE#*/}"
  FILE="${FILE%%.js*}_test.js"
  echo "creating $FILE"
  mkdir -p $(dirname $FILE) && touch $FILE
}

function cle {
  ORIGIN=${@}
  npx commitlint --from ${ORIGIN} --TOO HEAD --verbose -g commitlint.easy.config.js
}

function cl {
  ORIGIN=${@}
  npx commitlint --from ${ORIGIN} --to HEAD --verbose
}
