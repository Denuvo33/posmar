# 🏥 Aplikasi Posyandu Maharani

Aplikasi mobile untuk mengelola data kesehatan balita di Posyandu menggunakan Flutter, Firebase Realtime Database, dan GetX untuk state management.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)
![Firebase](https://img.shields.io/badge/Firebase-Realtime%20DB-FFCA28?logo=firebase)
![GetX](https://img.shields.io/badge/State-GetX-purple)

---

## ✨ Fitur Utama

### 🔐 Authentication
- Login dengan email & password (Firebase Auth)
- Session management dengan GetX
- Auto-check authentication state
- Secure logout

### 👨‍👩‍👧 Manajemen Orang Tua
- ✅ Tambah data orang tua (nama, alamat, no HP)
- ✅ Edit data orang tua
- ✅ Hapus data orang tua
- ✅ Real-time synchronization
- 🔍 **Search** berdasarkan nama, alamat, atau nomor HP

### 👶 Manajemen Data Balita
- ✅ Tambah anak baru dengan aktivitas pertama
- ✅ Tambah aktivitas untuk anak yang sudah ada
- ✅ Data tersimpan nested di dalam orang tua
- ✅ Real-time updates di semua screen
- 📊 **Sorting** berdasarkan:
  - Nama anak (A-Z)
  - Tanggal aktivitas terakhir (Terbaru/Terlama)

### 📊 Data Pengukuran Balita
Setiap aktivitas mencatat:
- 📅 Tanggal pengukuran
- 🧠 Lingkar kepala (cm)
- 💪 Lingkar lengan (cm)
- 📏 Tinggi badan (cm)
- ⚖️ Berat badan (kg)
- 📝 Keterangan/catatan

### 🎨 UI/UX Features
- Material Design 3
- Responsive design
- Loading indicators
- Empty states yang informatif
- Error handling dengan GetX Snackbar
- Smooth navigation dengan GetX

---

## 🗄️ Struktur Database

Database menggunakan **Firebase Realtime Database** dengan struktur nested:

```json
{
  "parents": {
    "-NxYz123abc": {
      "name": "Ibu Sarah",
      "address": "Jl. Mawar No. 10, Jakarta Selatan",
      "phoneNumber": "081234567890",
      "children": {
        "-NxYz456def": {
          "name": "Ahmad",
          "activities": {
            "-NxYz789ghi": {
              "date": "2025-01-15T00:00:00.000Z",
              "headCircumference": 45.5,
              "armCircumference": 14.2,
              "height": 85.5,
              "weight": 12.3,
              "notes": "Anak dalam kondisi sehat"
            }
          }
        }
      }
    }
  }
}
```

---

## 🚀 Instalasi

### Prerequisites
- Flutter SDK 3.0 atau lebih baru
- Dart SDK 3.0+
- Android Studio / VS Code
- Firebase Account

### Langkah Instalasi

1. **Clone Repository**
```bash
git clone https://github.com/Denuvo33/posmar.git
cd posyandu-app
```

2. **Install Dependencies**
```bash
flutter pub get
```

3. **Run Application**
```bash
flutter run
```

## 📖 Cara Menggunakan

### 1. Login
- Email: `admin@posyandu.com`
- Password: `admin123`

### 2. Tambah Orang Tua
1. Klik tombol **"+ Tambah Orang Tua"**
2. Isi: Nama, Alamat, No HP
3. Klik **SIMPAN**

### 3. Tambah Aktivitas Balita
1. Klik nama orang tua
2. Klik **"+ Tambah Aktivitas"**
3. Pilih **"Anak Baru"** atau **"Anak Existing"**
4. Isi data pengukuran
5. Klik **SIMPAN**

### 4. Lihat Riwayat
1. Klik nama orang tua
2. Klik nama balita
3. Lihat semua riwayat aktivitas

### 5. Search & Sort
- **Search**: Ketik di search bar (nama, alamat, HP)
- **Sort**: Klik ikon sort untuk mengubah urutan

---

**Made with ❤️ for Posyandu Maharani**
