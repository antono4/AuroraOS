# ===========================================================
# AuroraOS - Android 17 Custom ROM
# Vendor Configuration
# Based on NusantaraProject
# ===========================================================

# Licensed under the MIT License

# ===========================================================
# Device Identity
# ===========================================================
PRODUCT_NAME := AuroraOS
PRODUCT_DEVICE := generic
PRODUCT_BRAND := AuroraOS
PRODUCT_MODEL := AuroraOS Android 17
PRODUCT_MANUFACTURER := AuroraOS Team
PRODUCT_SHORT_DESCRIPTION := "AuroraOS - Android 17 Custom ROM based on NusantaraProject"

# ===========================================================
# Version Information
# ===========================================================
PRODUCT_VERSION_NAME := 1.0.0
PRODUCT_VERSION_CODE := 1
AURORA_VERSION := Android 17 (API 37)

# ===========================================================
# Build Information
# ===========================================================
AURORA_BUILD_DATE := $(shell date +%Y%m%d)
AURORA_BUILD_TYPE := Unofficial
AURORA_BUILDER := AuroraOS Team
AURORA_ORGANIZATION := AuroraOS Project

# ===========================================================
# Device Architecture
# ===========================================================
PRODUCT_AAPT_CONFIG := normal large xlarge hdpi xhdpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# ===========================================================
# Default Languages (Indonesian + English)
# ===========================================================
PRODUCT_LOCALES := en_US id_ID

# Device Path
DEVICE_PATH := device/generic

# ===========================================================
# Override Properties
# ===========================================================
PRODUCT_SYSTEM_PROPERTIES += \
    ro.system.build.type=$(AURORA_BUILD_TYPE) \
    ro.aurora.build.type=$(AURORA_BUILD_TYPE) \
    ro.aurora.build.date=$(AURORA_BUILD_DATE) \
    ro.aurora.version=$(AURORA_VERSION) \
    ro.aurora.name=AuroraOS \
    ro.aurora.brand=AuroraOS \
    ro.aurora.codename=aurora \
    ro.aurora.based.on=NusantaraProject

# ===========================================================
# Vendor Properties
# ===========================================================
PRODUCT_COPY_FILES += \
    vendor/aurora/config/system.properties:$(TARGET_COPY_OUT_SYSTEM)/etc/system_properties.conf

PRODUCT_COPY_FILES += \
    vendor/aurora/config/performance.properties:$(TARGET_COPY_OUT_SYSTEM)/etc/performance.conf

PRODUCT_COPY_FILES += \
    vendor/aurora/config/security.properties:$(TARGET_COPY_OUT_SYSTEM)/etc/security.conf

# ===========================================================
# Boot Animation
# ===========================================================
PRODUCT_COPY_FILES += \
    vendor/aurora/prebuilt/bootanimation/bootanimation.zip:$(TARGET_COPY_OUT_SYSTEM)/media/bootanimation.zip

# ===========================================================
# Wallpapers
# ===========================================================
PRODUCT_COPY_FILES += \
    vendor/aurora/prebuilt/wallpapers/*.jpg:$(TARGET_COPY_OUT_SYSTEM)/wallpapers/

# ===========================================================
# UI Overlays
# ===========================================================
DEVICE_PACKAGE_OVERLAYS += vendor/aurora/overlay

# ===========================================================
# Permissions
# ===========================================================
PRODUCT_COPY_FILES += \
    vendor/aurora/config/permissions/*.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/

# ===========================================================
# System Config
# ===========================================================
PRODUCT_COPY_FILES += \
    vendor/aurora/config/*.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/

# ===========================================================
# AuroraOS Custom Features
# ===========================================================

# Theme
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.theme=aurora \
    persist.sys.darkmode=true \
    ro.theme.suffix=aurora \
    ro.aurora.feature.enabled=true

# Performance
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.performance=true \
    ro.sys.vm.swappiness=10 \
    ro.sys.vm.vfs_cache_pressure=50

# Display Performance
PRODUCT_PROPERTY_OVERRIDES += \
    ro.max.fling_velocity=15000 \
    ro.min.fling_velocity=8000

# Security
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.security.enhanced=true \
    ro.security.enhanced=true

# Nusantara Heritage
PRODUCT_PROPERTY_OVERRIDES += \
    ro.nusantara.enabled=true \
    ro.nusantara.aurora.edition=true \
    ro.nusantara.language=id

# Setup Wizard
PRODUCT_PROPERTY_OVERRIDES += \
    ro.setupwizard.mode=OPTIONAL \
    ro.config.low_ram=false

# Media
PRODUCT_PROPERTY_OVERRIDES += \
    media.stagefright.enable-player=true \
    media.stagefright.enable-http=true \
    media.stagefright.enable-aac=true \
    media.stagefright.enable-qcp=true

# Network Buffers
PRODUCT_PROPERTY_OVERRIDES += \
    net.tcp.buffersize.default=4096,87380,524288,4096,16384,262144 \
    net.tcp.buffersize.lte=4096,87380,524288,4096,16384,262144 \
    net.tcp.buffersize.umedium=4096,16384,524288,4096,16384,262144

# ===========================================================
# Build Fingerprint
# ===========================================================
PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.fingerprint=aurora/android17/android17:17/$(AURORA_BUILD_DATE)/$(AURORA_VERSION):userdebug/test-keys

# ===========================================================
# Inherit from common config
# ===========================================================
$(call inherit-product, $(LOCAL_PATH)/aurora.mk)
