#!/usr/bin/env bash


###########################################################################
###########################################################################

function echo_code_block() {
    local MSG=$1

    echo "$(UI.Color.Red)${MSG}$(UI.Color.Default)"
}

function echo_keyvalue() {
    local key=$1
    local value=$2

    echo "$(UI.Color.Bold)$(UI.Color.White)${key}=$(UI.Color.Blue)${value}$(UI.Color.Default)"
}

function echo_block() {
    local color=$1
    local key=$2
    local block=$3

    echo "[ ${color}${key}$(UI.Color.Default) ] ${block}"
}

function echo_neutral() {
    local key=$1
    local block=$2
    local color=$(UI.Color.DarkGray)

    echo_block ${color} ${key} "${block}"
}

function echo_bad() {
    local key=$1
    local block=$2
    local color=$(UI.Color.Red)

    echo_block ${color} "${key}" "${block}"
}

function echo_good() {
    local key=$1
    local block=$2
    local color=$(UI.Color.Green)

    echo_block ${color} "${key}" "${block}"
}
