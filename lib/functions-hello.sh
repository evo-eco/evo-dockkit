#!/usr/bin/env bash

function announce_evo() {
    #####
    #      ___ __   __ ___       ___   ___  ___
    #     / _ \\ \ / // _ \     / _ \ / __|/ _ \
    #    |  __/ \ V /| (_) | - |  __/| (__| (_) |
    #     \___|  \_/  \___/     \___| \___|\___/
    #
    # @author   will, greg, talyn, msmyers.
    # @since    10.10.19
    # @desc     We help people see the good in what they do.
    #
    #####

    subject=evo Log "$(UI.Color.DarkGray)#####"
    subject=evo Log "$(UI.Color.DarkGray)#      ___ __   __ ___       ___   ___  ___"
    subject=evo Log "$(UI.Color.DarkGray)#     / _ \\ \  / // _ \     / _ \ / __|/ _ \ "
    subject=evo Log "$(UI.Color.DarkGray)#    |  __/ \ V /| (_) | - |  __/| (__| (_) |"
    subject=evo Log "$(UI.Color.DarkGray)#     \___|  \_/  \___/     \___| \___|\___/"
    subject=evo Log "$(UI.Color.DarkGray)#"
    subject=evo Log "$(UI.Color.DarkGray)# @author  william, greg, talyn, msmyers"
    subject=evo Log "$(UI.Color.DarkGray)# @since   10.10.19"
    subject=evo Log "$(UI.Color.DarkGray)# @desc    $(UI.Color.Green)We help people$(UI.Color.DarkGray) see the good in what they $(UI.Color.Green)$(UI.Color.Bold)choose.$(UI.Color.Default)"
    subject=evo Log "$(UI.Color.DarkGray)# @url     evoeco.com"
    subject=evo Log "$(UI.Color.DarkGray)#"
    subject=evo Log "$(UI.Color.DarkGray)#####$(UI.Color.Default)"
}
