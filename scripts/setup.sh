#!/bin/bash
#===============================================================================
# AuroraOS Setup Script
# Android 17 Custom ROM - Based on NusantaraProject
#===============================================================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Banner
echo -e "${CYAN}"
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║                                                               ║"
echo "║   🌟 AuroraOS - Android 17 Setup Script                      ║"
echo "║   Custom ROM based on NusantaraProject                       ║"
echo "║                                                               ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo -e "${RED}⚠️  WARNING: Tidak disarankan menjalankan sebagai root!${NC}"
fi

# Check OS
echo -e "${YELLOW}📋 Mengecek sistem...${NC}"
source /etc/os-release 2>/dev/null || true
echo -e "${GREEN}✅ OS terdeteksi: $PRETTY_NAME${NC}"

# RAM Check
TOTAL_RAM=$(free -g | awk '/^Mem:/{print $2}')
echo -e "${YELLOW}📊 Total RAM: ${TOTAL_RAM}GB${NC}"
if [ "$TOTAL_RAM" -lt 16 ]; then
    echo -e "${RED}⚠️  RAM minimal 16GB diperlukan${NC}"
fi

# Disk Check
AVAILABLE_SPACE=$(df -BG / | awk 'NR==2 {print $4}' | sed 's/G//')
echo -e "${YELLOW}📊 Space tersedia: ${AVAILABLE_SPACE}GB${NC}"
if [ "$AVAILABLE_SPACE" -lt 500 ]; then
    echo -e "${RED}⚠️  Minimal 500GB space diperlukan${NC}"
fi

echo ""
echo -e "${YELLOW}========================================${NC}"
echo -e "${YELLOW}🚀 Memulai instalasi dependencies...${NC}"
echo -e "${YELLOW}========================================${NC}"

# Update
echo -e "${BLUE}📦 Updating package lists...${NC}"
sudo apt update

# Install dependencies
echo -e "${BLUE}📦 Installing build dependencies...${NC}"
sudo apt install -y \
    bc \
    bison \
    build-essential \
    ccache \
    curl \
    flex \
    g++-multilib \
    gcc-multilib \
    git \
    gnupg \
    gperf \
    imagemagick \
    lib32ncurses5-dev \
    lib32readline-dev \
    lib32z1-dev \
    libelf-dev \
    liblz4-tool \
    libncurses5 \
    libncurses5-dev \
    libsdl1.2-dev \
    libssl-dev \
    libxml2 \
    libxml2-utils \
    lzop \
    pngcrush \
    rsync \
    schedtool \
    squashfs-tools \
    xsltproc \
    zip \
    zlib1g-dev \
    python3 \
    python3-pip \
    openjdk-17-jdk \
    jq

echo -e "${GREEN}✅ Dependencies installed${NC}"

# Setup Repo tool
echo ""
echo -e "${BLUE}🔧 Setting up Repo tool...${NC}"
mkdir -p ~/.bin
curl -s https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
chmod a+x ~/.bin/repo

if ! grep -q '~/.bin' ~/.bashrc; then
    echo 'export PATH=~/.bin:$PATH' >> ~/.bashrc
fi

echo -e "${GREEN}✅ Repo tool installed${NC}"

# Setup ccache
echo ""
echo -e "${BLUE}🔧 Setting up ccache...${NC}"
export USE_CCACHE=1
export CCACHE_DIR=/ccache
ccache -M 100G

if ! grep -q 'USE_CCACHE=1' ~/.bashrc; then
    echo 'export USE_CCACHE=1' >> ~/.bashrc
fi
if ! grep -q 'CCACHE_DIR=/ccache' ~/.bashrc; then
    echo 'export CCACHE_DIR=/ccache' >> ~/.bashrc
fi

echo -e "${GREEN}✅ Ccache configured (100GB max)${NC}"

# Git setup
echo ""
echo -e "${BLUE}🔧 Setting up Git...${NC}"
echo "Masukkan informasi Git Anda:"
read -p "Email: " git_email
read -p "Nama: " git_name

git config --global user.email "$git_email"
git config --global user.name "$git_name"

echo -e "${GREEN}✅ Git configured${NC}"

# Create workspace
echo ""
echo -e "${BLUE}📁 Creating workspace...${NC}"
mkdir -p ~/aurora-os
echo -e "${GREEN}✅ Workspace created at ~/aurora-os${NC}"

# Summary
echo ""
echo -e "${CYAN}╔═══════════════════════════════════════════════════════════════╗"
echo "║ SETUP COMPLETE!                                                   ║"
echo -e "╚═══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}Langkah selanjutnya:${NC}"
echo ""
echo "1. Fork repository NusantaraProject di GitHub"
echo "2. Edit manifest dengan URL fork Anda"
echo "3. Initialize repo:"
echo "   repo init -u https://github.com/YOUR_USERNAME/manifest.git -b main"
echo ""
echo "4. Sync source:"
echo "   repo sync -c -j\$(nproc)"
echo ""
echo "5. Build:"
echo "   source build/envsetup.sh"
echo "   lunch aurora_oriole-userdebug"
echo "   m -j\$(nproc)"
echo ""
echo -e "${YELLOW}Happy building! 🌟${NC}"
