# 🌸 Kalkulator Cherry Blossom

Aplikasi kalkulator Flutter dengan desain bertema **Cherry Blossom** — elegan, modern, dan responsif. Dibangun menggunakan arsitektur MVVM dengan Provider sebagai state management.

---

## ✨ Fitur

- **Operasi dasar** — tambah, kurang, kali, bagi
- **Chained operation** — tekan operator baru tanpa harus menekan `=` terlebih dahulu
- **Display dua baris** — baris atas menampilkan ekspresi, baris bawah menampilkan hasil besar
- **Format angka** — pemisah ribuan otomatis (e.g. `1.234.567`)
- **Toggle tanda** — tombol `±` untuk membalik positif/negatif
- **Persentase** — tombol `%` langsung mengonversi nilai
- **Backspace** — hapus digit terakhir dengan tombol `⌫`
- **Divide-by-zero protection** — menampilkan `Error` alih-alih crash atau `Infinity`
- **Riwayat kalkulasi** — simpan hingga 20 kalkulasi terakhir, persisten setelah restart
- **Tap riwayat** — klik entri riwayat untuk menggunakan hasilnya kembali
- **Haptic feedback** — getaran ringan setiap tombol ditekan
- **Copy hasil** — tekan lama pada layar hasil untuk menyalin ke clipboard
- **Dark / Light mode** — toggle tema, pilihan tersimpan otomatis
- **Animasi halus** — transisi angka display, animasi tekan tombol, dan sheet masuk dari bawah

---

## 🎨 Tema Cherry Blossom

Palet warna utama terinspirasi dari keindahan bunga sakura Jepang.

| Peran           | Light Mode | Dark Mode |
| --------------- | ---------- | --------- |
| Primary         | `#F2A7C3`  | `#C2185B` |
| Primary Dark    | `#C2185B`  | `#880E4F` |
| Surface         | `#FFF5F7`  | `#1C1218` |
| Button Number   | `#FDEEF3`  | `#2A1520` |
| Button Operator | `#F7C5D8`  | `#6D2040` |
| Accent Gold (=) | `#E8C99A`  | `#C8A96A` |

Font: **Nunito** (Google Fonts)

---

## 🗂️ Struktur Proyek

```
lib/
├── main.dart                          # Entry point, MultiProvider
├── app_theme.dart                     # CherryBlossomColors + ThemeData
├── models/
│   ├── button_model.dart              # Model tombol & daftar tombol
│   └── history_model.dart             # HistoryEntry + serialisasi
├── view_models/
│   ├── calculator_view_model.dart     # Logika kalkulator + riwayat
│   └── theme_view_model.dart          # Toggle dark/light + persistensi
└── views/
    ├── main_screen.dart               # Layar utama (gradient + AppBar)
    ├── history_sheet.dart             # Bottom sheet riwayat
    └── widgets/
        ├── display_widget.dart        # Dua baris display + animasi
        ├── calc_button.dart           # Tombol dengan tipe warna & animasi
        └── button_grid.dart           # Grid 4×5 tombol
```

---

## 📦 Dependencies

| Package              | Kegunaan                             |
| -------------------- | ------------------------------------ |
| `provider`           | State management (MVVM)              |
| `google_fonts`       | Font Nunito                          |
| `flutter_animate`    | Animasi AppBar dan history sheet     |
| `shared_preferences` | Persistensi tema & riwayat kalkulasi |
| `cupertino_icons`    | Ikon tambahan                        |

---

## 🚀 Cara Menjalankan

```bash
# Clone repo
git clone <url-repo>
cd flutter-kalkulator

# Install dependencies
flutter pub get

# Jalankan
flutter run
```

**Minimum requirement:** Flutter ≥ 3.10 · Dart ≥ 3.0

---

## 📱 Platform

Android · iOS · Web · Windows · macOS · Linux
