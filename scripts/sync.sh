#!/bin/bash
#===============================================================================
# AuroraOS Source Sync Script
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
echo "║   📥 AuroraOS - Source Sync Script                        ║"
echo "║   Android 17 Custom ROM                                    ║"
echo "║                                                               ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check manifest
if [ ! -f "manifest/default.xml" ]; then
    echo -e "${RED}❌ Error: Tidak berada di direktori ROM!${NC}"
    exit 1
fi

# Sync options
SYNC_JOBS=$(nproc)
SYNC_FLAGS="-c --no-tags --no-clone-bundle --force-sync"

echo ""
echo -e "${YELLOW}╔═══════════════════════════════════════════════════════════╗"
echo "║ SOURCE SYNC OPTIONS                                       ║"
echo -e "╚═══════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "1. 🔄 Sync semua source (full)"
echo "2. 🔄 Sync dengan ccache (recommended)"
echo "3. 🔄 Sync hanya core repos"
echo "4. ❌ Keluar"
echo ""
read -p "Pilih opsi [1-4]: " sync_choice

case $sync_choice in
    1)
        echo -e "${BLUE}📥 Memulai sync source (full)...${NC}"
        repo sync $SYNC_FLAGS -j$SYNC_JOBS
        ;;
    2)
        echo -e "${BLUE}📥 Memulai sync dengan ccache...${NC}"
        echo -e "${YELLOW}💡 Tip: Gunakan ccache untuk mempercepat build${NC}"
        export USE_CCACHE=1
        export CCACHE_DIR=/ccache
        repo sync $SYNC_FLAGS -j$SYNC_JOBS
        ;;
    3)
        echo -e "${BLUE}📥 Memulai sync core repos only...${NC}"
        repo sync platform/build platform/manifest platform/system/core \
            platform/frameworks/base $SYNC_FLAGS -j$SYNC_JOBS
        ;;
    4)
        echo -e "${RED}Keluar...${NC}"
        exit 0
        ;;
    *)
        echo -e "${RED}Opsi tidak valid!${NC}"
        exit 1
        ;;
esac

echo ""
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Sync selesai!${NC}"
    echo ""
    echo -e "${YELLOW}Langkah selanjutnya:${NC}"
    echo "1. source build/envsetup.sh"
    echo "2. lunch aurora_[device]-userdebug"
    echo "3. ./scripts/customize.sh"
    echo "4. ./scripts/build.sh"
else
    echo -e "${RED}❌ Sync gagal!${NC}"
    exit 1
fi
