#!/bin/bash
#===============================================================================
# AuroraOS Build Script
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
echo "║   🔨 AuroraOS - Build Script                               ║"
echo "║   Android 17 Custom ROM                                    ║"
echo "║                                                               ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check environment
if [ ! -f "build/envsetup.sh" ]; then
    echo -e "${RED}❌ Error: Tidak berada di direktori ROM!${NC}"
    echo "Jalankan script ini dari root directory ROM"
    exit 1
fi

# Setup environment
echo -e "${BLUE}🔧 Setting up build environment...${NC}"
source build/envsetup.sh

# Check ccache
if [ "$USE_CCACHE" != "1" ]; then
    echo -e "${YELLOW}⚠️  Ccache tidak aktif. Mengaktifkan...${NC}"
    export USE_CCACHE=1
    export CCACHE_DIR=/ccache
fi

echo -e "${BLUE}💾 Ccache stats:${NC}"
ccache -s | head -5

# Build options
echo ""
echo -e "${YELLOW}╔═══════════════════════════════════════════════════════════╗"
echo "║ BUILD OPTIONS                                              ║"
echo -e "╚═══════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "1. 📱 Full ROM Build (userdebug)"
echo "2. 📱 Full ROM Build (user)"
echo "3. 🔧 System Image Only"
echo "4. 🔧 Clean Build"
echo "5. ❌ Keluar"
echo ""
read -p "Pilih opsi [1-5]: " build_choice

# Build function
do_build() {
    local target=$1
    local desc=$2
    
    echo ""
    echo -e "${YELLOW}╔═══════════════════════════════════════════════════════════╗"
    echo -e "║ $desc${NC}"
    echo -e "${YELLOW}╚═══════════════════════════════════════════════════════════╝${NC}"
    
    START_TIME=$(date +%s)
    
    echo -e "${BLUE}🚀 Memulai build...${NC}"
    echo -e "${YELLOW}💡 Tekan Ctrl+C untuk membatalkan${NC}"
    
    if m -j$(nproc) $target 2>&1 | tee build.log; then
        END_TIME=$(date +%s)
        BUILD_TIME=$((END_TIME - START_TIME))
        HOURS=$((BUILD_TIME / 3600))
        MINUTES=$(((BUILD_TIME % 3600) / 60))
        SECONDS=$((BUILD_TIME % 60))
        
        echo ""
        echo -e "${GREEN}╔═══════════════════════════════════════════════════════════╗"
        echo "║ ✅ BUILD BERHASIL!                                           ║"
        echo -e "${GREEN}╚═══════════════════════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "${BLUE}⏱️  Waktu build: ${HOURS}j ${MINUTES}m ${SECONDS}d${NC}"
        
        echo ""
        echo -e "${YELLOW}📁 Output files:${NC}"
        find out/target/product -name "*.zip" -o -name "*.img" 2>/dev/null | head -10
        
        echo ""
        echo -e "${GREEN}💾 Ccache stats after build:${NC}"
        ccache -s | head -5
        
    else
        END_TIME=$(date +%s)
        BUILD_TIME=$((END_TIME - START_TIME))
        HOURS=$((BUILD_TIME / 3600))
        MINUTES=$(((BUILD_TIME % 3600) / 60))
        SECONDS=$((BUILD_TIME % 60))
        
        echo ""
        echo -e "${RED}╔═══════════════════════════════════════════════════════════╗"
        echo "║ ❌ BUILD GAGAL!                                               ║"
        echo -e "${RED}╚═══════════════════════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "${BLUE}⏱️  Waktu build: ${HOURS}j ${MINUTES}m ${SECONDS}d${NC}"
        echo ""
        echo -e "${YELLOW}📋 Error log:${NC}"
        tail -50 build.log
        echo ""
        echo -e "${BLUE}💡 Tips troubleshooting:${NC}"
        echo "1. Cek error di atas"
        echo "2. Pastikan source sudah sync sepenuhnya"
        echo "3. Pastikan dependencies sudah terinstall"
        echo "4. Cek log lengkap: cat build.log"
        
        return 1
    fi
}

# Build choice
case $build_choice in
    1) do_build "" "FULL ROM BUILD (USERDEBUG)" ;;
    2) do_build "user" "FULL ROM BUILD (USER)" ;;
    3) do_build "systemimage" "SYSTEM IMAGE ONLY" ;;
    4) 
        echo -e "${YELLOW}🧹 Membersihkan build...${NC}"
        m clobber
        echo -e "${GREEN}✅ Clean complete${NC}"
        ;;
    5) exit 0 ;;
    *) echo -e "${RED}Opsi tidak valid!${NC}" ;;
esac

echo ""
echo -e "${GREEN}🎉 Happy building! 🌟${NC}"
