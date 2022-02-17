#!/bin/bash

[ -z $1 ] && echo "Missing model filename!" && exit
[ ! -f $1 ] && echo "File not found!" && exit

dir=$(pwd)
display=
model=$1
shift

ampl_dir=$dir/ampl.linux-intel64
[ ! -f $ampl_dir/ampl ] && \
echo "Downloading ampl ..." && \
curl -O https://ampl.com/demo/amplide.linux64.tgz && \
tar zxvf amplide.linux64.tgz && \
rm amplide.linux64.tgz

for i in "$@"; do display="$display,$i"; done
[ ! -z $display ] && display="display ${display:1};"

PATH="$PATH:$ampl_dir/" \
$ampl_dir/ampl <<EOF
model $model
option solver cplex;
solve;

$display
EOF
