#!/usr/bin/env bash

    ##
    # example: 'get_abs_path /folder/../path' -> /path
    # from: https://stackoverflow.com/a/6393490/726368
    ##
    function get_abs_path() {
         local PARENT_DIR=$(dirname "$1")
         cd "$PARENT_DIR"
         local ABS_PATH="$(pwd)"/"$(basename "$1")"
         cd - >/dev/null
         echo "$ABS_PATH"
    }

    function touch_ssh() {
        local file=$1
        local dest=$2

        ssh -o BatchMode=yes -o ConnectTimeout=5 -o IdentitiesOnly=yes -F /dev/null -i $1 -T $2 || SSH_GIT_EXIT_CODE=$?

        if [[ ${SSH_GIT_EXIT_CODE} -eq 1 ]]; then
            echo "true"
        else
            echo ${SSH_GIT_EXIT_CODE}
        fi
    }

    function touch_github() {
        local file=$1

        ssh -o BatchMode=yes -o ConnectTimeout=5 -o IdentitiesOnly=yes -F /dev/null -i $1 -T git@github.com || SSH_GIT_EXIT_CODE=$?

        if [[ ${SSH_GIT_EXIT_CODE} -eq 1 ]]; then
            echo "true"
        else
            echo ${SSH_GIT_EXIT_CODE}
        fi
    }

    # Check for dependencies
    function check_req {
      which $1 &> /dev/null
      if [[ "$?" -ne 0 ]]
      then
        echo "$1 is either not installed or is not in your path"
        exit 2
      else
        echo "$1 found"
      fi
    }

    # call via: getFolderName git@github.com:account/repo.git
    function parse_folder_name() {
        # https://linuxize.com/post/bash-functions/
        # https://stackoverflow.com/questions/918886/how-do-i-split-a-string-on-a-delimiter-in-bash

        local IN=$1
        arrIN=(${IN//\:/ })

        IN="${arrIN[1]}"
        arrIN=(${IN//\./ })

        IN="${arrIN[0]}"
        arrIN=(${IN//\// })

        echo ${arrIN[1]}
        exit 0;
    }

    function test_string_nonempty() {
        local STRING_VALUE=$1;

        if [[ -n ${STRING_VALUE} ]]; then
            echo "true";
        else
            echo "false";
        fi
    }

    function test_is_true() {
        local VALUE=$1

        if [[ $(test_string_nonempty $VALUE) = "true" ]]; then
            echo "true"
        else
            if [[ $VALUE -eq 0 ]]; then
                echo "true";
            elif [[ $VALUE -eq "0" ]]; then
                echo "true";
            else
                echo "false";
            fi
        fi
    }

    function to_path_string() {
        local PATH_STRING=$1

        echo "\"$PATH_STRING\"";
    }

    function file_contains_string() {
        local FILE_PATH=$1;
        local STRING=$2;


        if [[ -f ${FILE_PATH} ]]; then
            cat "$FILE_PATH" | grep -q "$STRING" && echo "true" || echo "false"
        else
            echo "false"
        fi

    }

