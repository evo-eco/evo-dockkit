#!/usr/bin/env bash

    function docker_cache_nuke() {
        docker system prune --volumes -a -f
    }

    function concat_docker_image_alias() {
        local name=$1;
        local tag=$2;

        if [[ -z ${tag} ]]; then
            echo "$name";
        else
            echo "$name:$tag";
        fi
    }

    function get_docker_image_ids() {
        local IMAGE_ALIAS=$1
        local EXISTING_IMAGE_IDS=$(docker image ls -q -a -f reference="${IMAGE_ALIAS}")

        echo "$EXISTING_IMAGE_IDS"
    }

    function required() {
        [[ ! -z $1 ]] && echo "$1" || throw "wtf"
    }

    function safely_clear_docker_image_cache() {
        local IMAGE_ALIAS=$(required $1);
        local HAS_ARGS=$( test_string_nonempty ${IMAGE_ALIAS} );
        local IS_EXISTING=$( is_docker_image_existing ${IMAGE_ALIAS} );

        local block="docker image rm --force ${IMAGE_ALIAS}"

        if [[ "$IS_EXISTING" == "true" ]]; then
            echo_code_block "${block}"
            docker image rm --force $( get_docker_image_ids ${IMAGE_ALIAS} );
#        else
#            echo_skipping "${block}"
        fi
    }

    function safely_stop_docker_container() {
        local CONTAINER_NAME=$1;
        local HAS_ARGS=$( test_string_nonempty ${CONTAINER_NAME} );
        local IS_RUNNING=$( is_docker_container_running ${CONTAINER_NAME} );

        local block="docker container stop ${CONTAINER_NAME}"

        if [[ "$IS_RUNNING" == "true" ]]; then
            echo_good "stopping" "${block}"
            docker container stop ${CONTAINER_NAME};
        else
            echo_skipping "${block}"
        fi
    }

    function safely_remove_docker_container() {
        local CONTAINER_NAME=$1;
        local HAS_ARGS=$( test_string_nonempty ${CONTAINER_NAME} );
        local IS_EXISTING=$( is_docker_container_existing ${CONTAINER_NAME} );

        safely_stop_docker_container ${CONTAINER_NAME}

        if [[ "$IS_EXISTING" == "true" ]]; then
            docker container rm --force ${CONTAINER_NAME};
#            docker container rm --force $( get_docker_image_ids ${IMAGE_ALIAS} );
        fi
    }

    function optionally_clear_docker_image_cache() {
        if [[ ! "${WIPE_DOCKER_CACHE_ON_EVERY_RUN}" == "true" ]]; then
            return;
        fi

        local IMAGE_ALIAS=$1

        safely_clear_docker_image_cache ${IMAGE_ALIAS}
    }

    function get_existing_docker_container_ids() {
        local CONTAINER_NAME=$1

        echo "$( docker ps -q -a -f name=${CONTAINER_NAME} )"
    }

    function get_running_docker_container_ids() {
        local CONTAINER_NAME=$1

        echo "$( docker ps -q -f name=${CONTAINER_NAME} )"
    }

    function is_docker_image_existing() {
        local IMAGE_ALIAS=$1;
        local IMAGE_IDS=$(get_docker_image_ids ${IMAGE_ALIAS})

        test_string_nonempty ${IMAGE_IDS}
    }

    function is_docker_container_existing() {
        local CONTAINER_NAME=$1;
        local CONTAINER_IDS=$(get_existing_docker_container_ids ${CONTAINER_NAME})

        test_string_nonempty ${CONTAINER_IDS}
    }

    function is_docker_container_running() {
        local CONTAINER_NAME=$1;
        local CONTAINER_IDS=$(get_running_docker_container_ids ${CONTAINER_NAME})

        test_string_nonempty ${CONTAINER_IDS}
    }
