# 🔨 AuroraOS - Panduan Build Lengkap

## ⚠️ Prasyarat Penting

Build AuroraOS **TIDAK BISA** dilakukan di environment biasa. Anda membutuhkan:

### Hardware Requirements

| Komponen | Minimal | Disarankan |
|----------|---------|------------|
| **RAM** | 16 GB | 32 GB+ |
| **Storage** | 500 GB | 1 TB SSD |
| **CPU** | Multi-core | 8+ cores |
| **Internet** | Broadband 50+ Mbps | Fiber 100+ Mbps |

### Software Requirements

- **OS**: Ubuntu 20.04/22.04 LTS (64-bit)
- **Python**: 3.8+
- **JDK**: OpenJDK 17
- **Repo Tool**: Latest
- **Git**: 2.0+

---

## 🚀 Langkah-Langkah Build

### Langkah 1: Setup Environment

```bash
# Update sistem
sudo apt update && sudo apt upgrade -y

# Install dependencies
sudo apt install -y \
    bc bison build-essential ccache curl flex \
    g++-multilib gcc-multilib git gnupg gperf \
    imagemagick lib32ncurses5-dev lib32readline-dev \
    lib32z1-dev libelf-dev liblz4-tool libncurses5-dev \
    libsdl1.2-dev libssl-dev libxml2 libxml2-utils \
    lzop pngcrush rsync schedtool squashfs-tools \
    xsltproc zip zlib1g-dev python3 python3-pip \
    openjdk-17-jdk jq

# Install Repo tool
mkdir -p ~/.bin
curl -s https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
chmod a+x ~/.bin/repo
echo 'export PATH=~/.bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# Setup ccache (100GB recommended)
export USE_CCACHE=1
export CCACHE_DIR=/ccache
ccache -M 100G
```

### Langkah 2: Clone Repository AuroraOS

```bash
git clone https://github.com/antono4/AuroraOS.git
cd AuroraOS
```

### Langkah 3: Fork Repository NusantaraProject

Fork repository berikut ke akun GitHub Anda:

1. https://github.com/NusantaraProject-ROM/android_manifest
2. https://github.com/NusantaraProject-ROM/android_vendor_nusantara
3. https://github.com/NusantaraProject-ROM/android_packages_apps_NusantaraWings
4. https://github.com/NusantaraProject-ROM/android_packages_apps_Settings
5. https://github.com/NusantaraProject-ROM/android_frameworks_base

### Langkah 4: Edit Local Manifest

Edit `configs/local_manifests/aurora.xml` dan isi dengan URL fork Anda:

```bash
nano configs/local_manifests/aurora.xml
```

Uncomment bagian `<project>` dan ganti `YOUR_USERNAME` dengan username GitHub Anda.

### Langkah 5: Initialize & Sync Source

```bash
# Initialize repo
repo init -u https://github.com/YOUR_USERNAME/android_manifest.git -b main --depth=1

# Copy local manifest
mkdir -p .repo/local_manifests
cp configs/local_manifests/aurora.xml .repo/local_manifests/

# Sync source (akan memakan waktu 2-6 jam tergantung koneksi)
repo sync -c -j$(nproc) --force-sync
```

### Langkah 6: Setup Build Environment

```bash
# Setup environment
source build/envsetup.sh

# Lihat daftar device
breakfast

# Pilih device (contoh: Pixel 7)
lunch aosp_oriole-userdebug

# Atau gunakan target generic
lunch aosp_arm64-eng
```

### Langkah 7: Build AuroraOS

```bash
# Build (akan memakan waktu 2-4 jam)
m -j$(nproc)

# Atau dengan限制 thread jika RAM kurang
m -j8
```

### Langkah 8: Output

Setelah build berhasil:

```
out/target/product/[device]/
├── AuroraOS-v1.0.0-[date].zip      # Flashable ZIP
├── system.img
├── boot.img
├── vendor.img
├── product.img
└── super.img
```

---

## 📱 Dukungan Device

### Google Pixel (Disarankan)

| Perangkat | Codename | Status |
|-----------|----------|--------|
| Pixel 4a | sunfish | ✅ |
| Pixel 5 | redfin | ✅ |
| Pixel 6 | oriole | ✅ |
| Pixel 6 Pro | raven | ✅ |
| Pixel 6a | bluejay | ✅ |
| Pixel 7 | panther | ✅ |
| Pixel 7 Pro | cheetah | ✅ |

### Device Lain

Anda membutuhkan:
- **Device Tree**: `device/[vendor]/[codename]`
- **Kernel**: `kernel/[vendor]/[codename]`
- **Vendor Blobs**: File proprietary dari device

---

## 🔧 Troubleshooting

### Error: repo not found
```bash
export PATH=~/.bin:$PATH
```

### Error: out of memory
```bash
# Kurangi jumlah thread
m -j4

# Atau tambah swap
sudo fallocate -l 16G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

### Error: insufficient disk space
```bash
# Bersihkan space
rm -rf out/
ccache -C

# Cek space
df -h
```

### Sync gagal atau timeout
```bash
# Gunakan mirror yang lebih cepat
repo sync -c -j$(nproc) --force-sync --no-clone-bundle
```

---

## 💡 Tips Optimasi

### 1. Gunakan ccache
```bash
export USE_CCACHE=1
export CCACHE_DIR=/ccache
ccache -M 200G
```

### 2. Build incremental
```bash
# Setelah build pertama, subsequent build lebih cepat
m -j$(nproc)
```

### 3. Sync hanya repos yang berubah
```bash
repo sync platform/build platform/frameworks/base -c -j$(nproc)
```

---

## 📞 Bantuan

Jika mengalami masalah:

1. Buka **Issue** di GitHub: https://github.com/antono4/AuroraOS/issues
2. Join **Telegram Group** NusantaraProject
3. Cek **XDA Developers** untuk device-specific guides

---

## ⏱️ Estimasi Waktu

| Task | Waktu |
|------|-------|
| Initial sync | 2-6 jam |
| First build | 3-5 jam |
| Subsequent builds | 30-60 menit |

---

**Happy Building! 🌟 AuroraOS**

*"Bringing the Aurora to your device"*
