# ===========================================================
# AuroraOS - Android 17 Custom ROM
# Vendor Android.mk
# Based on NusantaraProject
# ===========================================================

# Licensed under the MIT License

LOCAL_PATH := $(call my-dir)

# Clean target
$(call add-clean-step, rm -rf $(TARGET_OUT)/vendor/aurora)

# Include subdirectories
include $(call all-subdir-makefiles)

# Vendor setup
include $(CLEAR_VARS)
include $(LOCAL_PATH)/config.mk

# Product configuration
PRODUCT_PACKAGES += \
    AuroraOSThemes \
    AuroraOSWallpapers

# Finalize configuration
$(call inherit-product, $(LOCAL_PATH)/config.mk)

# Additional cleanup steps
$(call add-clean-step, rm -f $(TARGET_OUT)/etc/system_properties.conf)
$(call add-clean-step, rm -f $(TARGET_OUT)/etc/performance.conf)
$(call add-clean-step, rm -f $(TARGET_OUT)/etc/security.conf)
