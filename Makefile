TARGETS = example 
SOURCES = $(wildcard *.cc) #uncomment these to add all cc files in directory to your compile list 
CSOURCES += $(wildcard *.c)#uncomment these to add all cc files in directory to your compile list 

TARGETOBJ = $(patsubst %, %.o, $(TARGETS))
OBJS := $(filter-out $(TARGETOBJ), $(SOURCES:.cc=.o) $(CSOURCES:.c=.o))
CXX := g++
CC = gcc
CXXFLAGS = -Wall -g -Ivxi11 
LIBS =  
LIB := librpc_find_svc.a

CXXFLAGS += 
LIBS += 

.PHONY : all vxi11

all: $(TARGETS) vxi11/vxi11.h

vxi11/vxi11.h: 
	@echo "Building vxi11"
	@$(MAKE) -C vxi11

.depend depend: vxi11/vxi11.h 
	@echo Checking dependencies...
	@$(CXX) -M $(CXXFLAGS) $(INCLUDEFLAGS) $(SOURCES) $(CSOURCES) > .depend

$(TARGETS): $(TARGETOBJ) $(LIB)
	$(CXX) $(CXXFLAGS) -o $@ $^ vxi11/libvxi11.a $(LIBS)

.cc.o:
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< 

.c.o:
	$(CC) $(CFLAGS) $(CXXFLAGS) -c $< 

$(LIB): $(OBJS)
	ar rv $@ $^

clean:
	@rm -f $(TARGETS)
	@rm -f *.o .depend $(LIB)
	@$(MAKE) clean -C vxi11 

ifneq ($(MAKECMDGOALS),clean)
-include .depend
endif
