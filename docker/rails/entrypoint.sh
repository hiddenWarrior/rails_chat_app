#!/bin/bash


rails db:create
rails db:prepare
rails db:migrate



exec "${@}"