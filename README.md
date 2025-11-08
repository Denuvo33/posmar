# Aplikasi Posyandu Maharani


Aplikasi mobile untuk mengelola data kesehatan balita di Posyandu menggunakan Flutter, Firebase Realtime Database, dan GetX untuk state management.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)
![Firebase](https://img.shields.io/badge/Firebase-Realtime%20DB-FFCA28?logo=firebase)
![GetX](https://img.shields.io/badge/State-GetX-purple)

---

<!-- <img width="500" height="500" alt="1000097354-removebg-preview" src="https://github.com/user-attachments/assets/a7371952-f971-40f7-8e70-63b1b2b4e289" /> -->
<img width="264" height="244" alt="logo uncut" src="https://github.com/user-attachments/assets/215bda85-ede9-46c5-bfde-5eb1a9ba7465" />

##  Fitur Utama

###  Authentication
- Login dengan email & password (Firebase Auth)
- Session management dengan GetX
- Auto-check authentication state
- Secure logout
<img width="300" height="700" alt="Screenshot_1762580190" src="https://github.com/user-attachments/assets/e8f749a9-83ba-491a-9439-50e254d6ceca" />

### Manajemen Orang Tua
- Tambah data orang tua (nama, alamat, no HP)
- Edit data orang tua
- Hapus data orang tua
- Real-time synchronization
- **Search** berdasarkan nama, alamat, atau nomor HP

### Manajemen Data Balita
- Tambah anak baru dengan aktivitas pertama
- Tambah aktivitas untuk anak yang sudah ada
- Data tersimpan nested di dalam orang tua
- Real-time updates di semua screen
- **Sorting** berdasarkan:
  - Nama anak (A-Z)
  - Tanggal aktivitas terakhir (Terbaru/Terlama)

<img width="300" height="700" alt="Screenshot_1762580689" src="https://github.com/user-attachments/assets/8fc9c12f-fc67-4987-ac62-bd3466faac6b" />


### Data Pengukuran Balita
Setiap aktivitas mencatat:
- Tanggal pengukuran
- Lingkar kepala (cm)
- Lingkar lengan (cm)
- Tinggi badan (cm)
- Berat badan (kg)
- Keterangan/catatan

### UI/UX Features
- Material Design 3
- Responsive design
- Loading indicators
- Empty states yang informatif
- Error handling dengan GetX Snackbar
- Smooth navigation dengan GetX

---

## Struktur Database

Database menggunakan **Firebase Realtime Database** dengan struktur nested:

```json
{
  "parents": {
    "-NxYz123abc": {
      "name": "Ibu Sarah",
      "address": "Jl. Mawar No. 10, Jakarta Selatan",
      "phoneNumber": "081234567890",
      "key": "-NxYz123abc",
      "children": {
        "-NxYz456def": {
          "name": "Ahmad",
          "activities": {
            "-NxYz789ghi": {
              "created_At": "2025-01-15T00:00:00.000Z",
              "dateBorn": "2024-01-01"
              "lingkarKepala": 45.5,
              "lingkarLengan": 14.2,
              "name": "Ahmad",
              "tinggiBadan": 85.5,
              "key": "-NxYz789ghi",
              "beratBadan": 12.3,
              "keterangan": "Anak dalam kondisi sehat"
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
- Flutter SDK 3.29.3 atau lebih baru
- Dart SDK 3.7.2+
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

## Cara Menggunakan

### 1. Login
- Email: `-`
- Password: `-`

### 2. Tambah Orang Tua
1. Klik tombol **"+ Tambah Orang Tua"**
2. Isi: Nama, Alamat, No HP
3. Klik **SIMPAN**

### 3. Tambah Aktivitas Balita
1. Klik nama orang tua
2. Klik **"+ Tambah Aktivitas"**
3. Isi data anak
4. Klik **SIMPAN**

### 4. Lihat Riwayat
1. Klik nama orang tua
2. Klik nama balita
3. Lihat semua riwayat aktivitas

### 5. Search & Sort
- **Search**: Ketik di search bar nama
- **Sort**: Klik ikon sort untuk mengubah urutan

---

**Made with ❤️ for Posyandu Maharani**
