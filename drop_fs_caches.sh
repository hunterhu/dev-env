#!/bin/bash
free -h
sudo sh -c 'sync && echo 3 > /proc/sys/vm/drop_caches'
free -h
