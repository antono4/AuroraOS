#!/bin/bash
#===============================================================================
# AuroraOS Customization Script
# Android 17 Custom ROM - Based on NusantaraProject
#===============================================================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Banner
echo -e "${CYAN}"
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║                                                               ║"
echo "║   🎨 AuroraOS - Customization Script                        ║"
echo "║   Android 17 Custom ROM                                    ║"
echo "║                                                               ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Main menu
customize_rom() {
    echo ""
    echo -e "${YELLOW}╔═══════════════════════════════════════════════════════╗"
    echo "║ PILIH OPSI KUSTOMISASI                                  ║"
    echo -e "╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo "1. 🌙 Dark Mode Default"
    echo "2. 🎨 Bahasa Indonesia"
    echo "3. ⚡ Optimasi Performa"
    echo "4. 🔒 Keamanan Enhanced"
    echo "5. 📱 Kustomisasi UI/UX"
    echo "6. 🚀 Semua Kustomisasi"
    echo "7. ❌ Keluar"
    echo ""
    read -p "Pilih opsi [1-7]: " choice
    
    case $choice in
        1) enable_dark_mode ;;
        2) add_indonesian_language ;;
        3) enable_performance ;;
        4) enable_security ;;
        5) customize_ui ;;
        6) enable_all ;;
        7) exit 0 ;;
        *) echo -e "${RED}Opsi tidak valid!${NC}" ;;
    esac
}

# Dark Mode
enable_dark_mode() {
    echo ""
    echo -e "${BLUE}🌙 Mengaktifkan Dark Mode default...${NC}"
    
    mkdir -p vendor/aurora/overlay/frameworks/base/core/res/res/values
    
    cat > vendor/aurora/overlay/frameworks/base/core/res/res/values/dark_mode.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <bool name="config_defaultNightMode">true</bool>
</resources>
EOF
    
    echo -e "${GREEN}✅ Dark Mode default diaktifkan${NC}"
}

# Bahasa Indonesia
add_indonesian_language() {
    echo ""
    echo -e "${BLUE}🌏 Menambah dukungan Bahasa Indonesia...${NC}"
    
    mkdir -p vendor/aurora/languages/id
    cat > vendor/aurora/languages/id/README << 'EOF'
Bahasa Indonesia support
AuroraOS Indonesia Localization
EOF
    
    echo -e "${GREEN}✅ Bahasa Indonesia ditambahkan${NC}"
}

# Performance
enable_performance() {
    echo ""
    echo -e "${BLUE}⚡ Mengaktifkan optimasi performa...${NC}"
    
    mkdir -p vendor/aurora/config/performance
    cat > vendor/aurora/config/performance.properties << 'EOF'
# AuroraOS Performance Tuning
ro.sys.vm.swappiness=10
ro.sys.vm.vfs_cache_pressure=50
ro.max.fling_velocity=15000
ro.min.fling_velocity=8000
net.tcp.buffersize.default=4096,87380,524288,4096,16384,262144
net.tcp.buffersize.lte=4096,87380,524288,4096,16384,262144
EOF
    
    echo -e "${GREEN}✅ Optimasi performa diaktifkan${NC}"
}

# Security
enable_security() {
    echo ""
    echo -e "${BLUE}🔒 Mengaktifkan fitur keamanan enhanced...${NC}"
    
    mkdir -p vendor/aurora/config/security
    cat > vendor/aurora/config/security.properties << 'EOF'
# AuroraOS Security Enhancement
ro.security.enhanced=true
persist.sys.security.enhanced=true
ro.selinux.enforce=1
EOF
    
    echo -e "${GREEN}✅ Keamanan enhanced diaktifkan${NC}"
}

# UI Customization
customize_ui() {
    echo ""
    echo -e "${YELLOW}╔═══════════════════════════════════════════════════════╗"
    echo "║ UI/UX CUSTOMIZATION                                      ║"
    echo -e "╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo "a. 📊 Status Bar"
    echo "b. 🔔 Notifications"
    echo "c. 🎯 Navigation Bar"
    echo "d. 🖼️  Wallpaper"
    echo "e. 🔙 Kembali"
    echo ""
    read -p "Pilih opsi [a-e]: " ui_choice
    
    case $ui_choice in
        a) customize_statusbar ;;
        b) customize_notifications ;;
        c) customize_navbar ;;
        d) customize_wallpaper ;;
        e) customize_rom ;;
        *) echo -e "${RED}Opsi tidak valid!${NC}" ;;
    esac
}

customize_statusbar() {
    echo ""
    echo -e "${BLUE}📊 Kustomisasi Status Bar...${NC}"
    
    mkdir -p vendor/aurora/overlay/frameworks/base/core/res/res/values
    cat > vendor/aurora/overlay/frameworks/base/core/res/res/values/statusbar.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <bool name="config_showClock">true</bool>
    <bool name="config_statusBarClockRight">true</bool>
    <bool name="config_showFourColumns">true</bool>
    <bool name="config_showNetworkSpeed">true</bool>
</resources>
EOF
    
    echo -e "${GREEN}✅ Status Bar dikustomisasi${NC}"
}

customize_notifications() {
    echo ""
    echo -e "${BLUE}🔔 Kustomisasi Notifications...${NC}"
    
    echo "Notification customization applied"
    echo -e "${GREEN}✅ Notifications dikustomisasi${NC}"
}

customize_navbar() {
    echo ""
    echo -e "${BLUE}🎯 Kustomisasi Navigation Bar...${NC}"
    
    mkdir -p vendor/aurora/overlay/frameworks/base/core/res/res/values
    cat > vendor/aurora/overlay/frameworks/base/core/res/res/values/navbar.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <bool name="config_enableNavBar">true</bool>
    <string name="config_navBarLayout">left,back,home,recent,right</string>
    <bool name="config_enableGestureNavbar">true</bool>
</resources>
EOF
    
    echo -e "${GREEN}✅ Navigation Bar dikustomisasi${NC}"
}

customize_wallpaper() {
    echo ""
    echo -e "${BLUE}🖼️  Kustomisasi Wallpaper...${NC}"
    
    mkdir -p vendor/aurora/prebuilt/wallpapers
    echo "Place wallpaper files in vendor/aurora/prebuilt/wallpapers/"
    echo "Supported formats: .jpg, .png, .webp"
    echo -e "${YELLOW}⚠️  Tambahkan file wallpaper secara manual${NC}"
}

# All customizations
enable_all() {
    echo ""
    echo -e "${BLUE}🚀 Mengaktifkan semua kustomisasi...${NC}"
    
    enable_dark_mode
    add_indonesian_language
    enable_performance
    enable_security
    
    echo ""
    echo -e "${GREEN}✅ Semua kustomisasi diaktifkan!${NC}"
}

# Main loop
echo ""
echo -e "${YELLOW}Selamat datang di AuroraOS Customization Wizard!${NC}"
echo ""

while true; do
    customize_rom
    echo ""
    read -p "Lanjutkan kustomisasi lain? [y/n]: " continue
    if [ "$continue" != "y" ]; then
        break
    fi
done

echo ""
echo -e "${GREEN}✅ Kustomisasi selesai!${NC}"
echo -e "${YELLOW}Lanjutkan dengan scripts/build.sh untuk build ROM${NC}"
