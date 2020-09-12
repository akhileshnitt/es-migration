#!/usr/bin/env bash
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 6`
reset=`tput sgr0`
curator action-reindex_movies.yml --config config.yml
 echo "${green} Index successfully reindexed${reset}"
 curator  action-create-alias.yml --config config.yml
