# 🚀 Quick Start Guide - AuroraOS

## Ringkasan

Panduan cepat untuk membangun AuroraOS dalam 5 menit!

---

## Prasyarat

- Ubuntu 20.04/22.04 LTS
- RAM minimal 16GB
- Storage minimal 500GB

---

## Langkah 1: Setup

```bash
git clone https://github.com/YOUR_USERNAME/AuroraOS.git
cd AuroraOS
chmod +x scripts/*.sh
./scripts/setup.sh
```

## Langkah 2: Fork Repository

Fork repository NusantaraProject di GitHub.

## Langkah 3: Sync

```bash
repo init -u https://github.com/YOUR_USERNAME/manifest.git -b main
repo sync -c -j$(nproc)
```

## Langkah 4: Build

```bash
source build/envsetup.sh
lunch aurora_oriole-userdebug
m -j$(nproc)
```

---

## Troubleshooting

### repo not found
```bash
export PATH=~/.bin:$PATH
```

### Out of memory
```bash
m -j8
```

---

Happy Building! 🌟
