# We can build either as part of a standalone Kernel build or as
# an external module.  Determine which mechanism is being used
OBJS := irqsync.o kgdboe_main.o kgdboe_io.o nethook.o netpoll_wrapper.o poll_copy.o spinhook.o timerhook.o
obj-m += $(MODNAME).o
$(MODNAME)-y := $(OBJS)
ccflags-y := -ggdb -O0 -std=gnu99
