# Android makefile for the KGDB Module

# Check for kernel version
ifeq ($(TARGET_KERNEL_VERSION),)
TARGET_KERNEL_VERSION := 3.18
TARGET_KERNEL_SOURCE := kernel
KERNEL_TO_BUILD_ROOT_OFFSET := ../
endif

# Check for supported kernel
ifeq ($(TARGET_KERNEL_VERSION),3.18)

# If kernel path offset is not defined, assume old kernel structure
ifeq ($(KERNEL_TO_BUILD_ROOT_OFFSET),)
KERNEL_TO_BUILD_ROOT_OFFSET := ../
endif

LOCAL_PATH := $(call my-dir)

KGDBOE_BLD_DIR := vendor/qcom/opensource/kgdboe

ifeq ($(call is-platform-sdk-version-at-least,16),true)
       DLKM_DIR := $(TOP)/device/qcom/common/dlkm
else
       DLKM_DIR := build/dlkm
endif

# This is set once per LOCAL_PATH, not per (kernel) module
KBUILD_OPTIONS := KGDBOE_ROOT=$(KERNEL_TO_BUILD_ROOT_OFFSET)$(KGDBOE_BLD_DIR)
# We are actually building wlan.ko here, as per the
# requirement we are specifying <chipset>_wlan.ko as LOCAL_MODULE.
# This means we need to rename the module to <chipset>_wlan.ko
# after wlan.ko is built.
KBUILD_OPTIONS += MODNAME=kgdboe
KBUILD_OPTIONS += BOARD_PLATFORM=$(TARGET_BOARD_PLATFORM)

#module to be built for all user,userdebug and eng tags
include $(CLEAR_VARS)
LOCAL_MODULE              := kgdboe.ko
# LOCAL_MODULE_KBUILD_NAME  := kgdboe.ko
LOCAL_MODULE_TAGS         := optional
LOCAL_MODULE_DEBUG_ENABLE := true
LOCAL_MODULE_PATH         := $(TARGET_OUT)/lib/modules/kgdboe
include $(DLKM_DIR)/AndroidKernelModule.mk
###########################################################

endif # supported target check
