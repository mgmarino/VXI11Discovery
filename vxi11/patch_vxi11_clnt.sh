#!/bin/sh
INPUTFILE=$1
sed -e 's/\(#include "vxi11.h"\)/\1                                       \
#include <string.h>                                                       \
#undef clnt_call                                                          \
#define clnt_call(rh, proc, xargs, argsp, xres, resp, secs)              \\\
     ((*(rh)->cl_ops->cl_call)(rh, proc, (xdrproc_t)xargs, argsp, (xdrproc_t)xres, resp, secs)) /g' $INPUTFILE
