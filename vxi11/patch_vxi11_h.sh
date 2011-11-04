#!/bin/sh
INPUTFILE=$1
sed -e \
's/typedef long Device_Link;/                                            \
#ifdef __LP64__                                                          \
typedef int Device_Link;                                                 \
#else                                                                    \
typedef long Device_Link;                                                \
#endif                                                                   \
/g' \
-e 's/typedef long Device_ErrorCode;/                                    \
#ifdef __LP64__                                                          \
typedef int Device_ErrorCode;                                            \
#else                                                                    \
typedef long Device_ErrorCode;                                           \
#endif                                                                   \
/g' \
-e 's/typedef long Device_Flags;/                                        \
#ifdef __LP64__                                                          \
typedef int Device_Flags;                                                \
#else                                                                    \
typedef long Device_Flags;                                               \
#endif                                                                   \
/g' \
-e 's/\(.*\)u_long \(.*\);/                                              \
#ifdef __LP64__                                                          \
\1unsigned int \2;                                                       \
#else                                                                    \
\1u_long \2;                                                             \
#endif                                                                   \
/g' \
-e 's/\(	\)long \(.*\);/                                          \
#ifdef __LP64__                                                          \
\1int \2;                                                                \
#else                                                                    \
\1long \2;                                                               \
#endif                                                                   \
/g' \
$INPUTFILE 
