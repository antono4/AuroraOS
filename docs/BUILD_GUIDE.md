# 📱 Panduan Build AuroraOS

## Ringkasan

Panduan lengkap untuk membangun AuroraOS - Android 17 Custom ROM berbasis NusantaraProject.

---

## 📋 Prasyarat

### Hardware

| Komponen | Minimal | Disarankan |
|----------|---------|------------|
| RAM | 16GB | 32GB+ |
| Storage | 500GB | 1TB SSD |
| Prosesor | Multi-core | 8+ cores |

### Software

| Komponen | Versi |
|----------|-------|
| OS | Ubuntu 20.04/22.04 LTS |
| Python | 3.8+ |
| JDK | OpenJDK 17 |
| Repo | Latest |

---

## 🔧 Langkah 1: Persiapan Environment

### 1.1 Install Dependencies

```bash
sudo apt update && sudo apt upgrade -y

sudo apt install -y \
    bc bison build-essential ccache curl flex \
    g++-multilib gcc-multilib git gnupg gperf \
    imagemagick lib32ncurses5-dev lib32readline-dev \
    lib32z1-dev libelf-dev liblz4-tool libncurses5-dev \
    libsdl1.2-dev libssl-dev libxml2 libxml2-utils \
    lzop pngcrush rsync schedtool squashfs-tools \
    xsltproc zip zlib1g-dev python3 python3-pip \
    openjdk-17-jdk jq
```

### 1.2 Setup Repo Tool

```bash
mkdir -p ~/.bin
curl -s https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
chmod a+x ~/.bin/repo
echo 'export PATH=~/.bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

### 1.3 Setup Ccache

```bash
export USE_CCACHE=1
export CCACHE_DIR=/ccache
ccache -M 100G
```

---

## 🔧 Langkah 2: Fork Repository

Fork repository berikut:

1. android_manifest
2. android_vendor_nusantara
3. android_packages_apps_NusantaraWings
4. android_packages_apps_Settings
5. android_frameworks_base

---

## 🔧 Langkah 3: Sync Source

```bash
# Initialize repo
repo init -u https://github.com/YOUR_USERNAME/manifest -b main --depth=1

# Sync
repo sync -c -j$(nproc) --force-sync
```

---

## 🔧 Langkah 4: Kustomisasi

```bash
./scripts/customize.sh
```

---

## 🔧 Langkah 5: Build

```bash
# Setup environment
source build/envsetup.sh

# Pilih device
lunch aurora_oriole-userdebug

# Build
m -j$(nproc)
```

---

## 📁 Output

```
out/target/product/[device]/
├── AuroraOS-v1.0.0-[date].zip
├── system.img
├── boot.img
└── vendor.img
```

---

## 💡 Tips

1. **Gunakan ccache** - Mempercepat build hingga 70%
2. **Sync reguler** - Update source secara rutin
3. **Backup** - Selalu backup sebelum modifikasi

---

*Dibuat untuk AuroraOS - Android 17 Custom ROM*
