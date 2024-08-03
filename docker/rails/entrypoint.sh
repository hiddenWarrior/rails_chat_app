#!/bin/bash


#if [ "${*}" == "rails server"]; then
rails db:create
rails db:prepare
#fi




exec "${@}"