#!/bin/bash

exec docker-compose -p samson-fork-dev -f docker/docker-compose.yml $@
