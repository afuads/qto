# file: src/bash/qto/funcs/full-clean-docker.sh

# v0.6.5
# ---------------------------------------------------------
# clean totally the docker runtime
# ---------------------------------------------------------
doFullCleanDocker(){
   do_flush_screen
   do_log "INFO START full clean of docker !!! " 
   do_log "INFO Are you SURE ??!! You have 3 seconds to abort by Ctrl + C !!"
   sleep 3
   
   docker system prune -f -a --volumes
   docker image prune -f
   docker container prune -f
   docker volume prune -f
   docker network prune -f

   do_log "INFO STOP  full clean of the docker"
}


# eof file: src/bash/qto/funcs/full-clean-docker.sh
