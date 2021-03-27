# Soal Shift Sisop 2021 Modul 1

Kelompok D-04
- Thomas Felix Brilliant (05111940000062)
- Muhammad Rizky Widodo (05111940000216)
- Fiodhy Ardito Narawangsa (05111940000218)

## SOAL 1 ##

Ryujin baru saja diterima sebagai IT support di perusahaan Bukapedia. Dia diberikan tugas untuk membuat laporan harian untuk aplikasi internal perusahaan, <i>ticky</i>. Terdapat 2 laporan yang harus dia buat, yaitu laporan <b>daftar peringkat pesan error</b> terbanyak yang dibuat oleh <i>ticky</i> dan laporan <b>penggunaan user</b> pada aplikasi <i>ticky</i>. Untuk membuat laporan tersebut, Ryujin harus melakukan beberapa hal berikut:

### 1A ###

### SOAL : ###

Mengumpulkan informasi dari log aplikasi yang terdapat pada file `syslog.log`. Informasi yang diperlukan antara lain: jenis log (`ERROR/INFO`), pesan log, dan username pada setiap baris lognya. Karena Ryujin merasa kesulitan jika harus memeriksa satu per satu baris secara manual, dia menggunakan regex untuk mempermudah pekerjaannya. Bantulah Ryujin membuat regex tersebut.

### 1B ###

### SOAL : ###

Kemudian, Ryujin harus menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.

### 1C ###

### SOAL : ###

Ryujin juga harus dapat menampilkan jumlah kemunculan log `ERROR` dan `INFO` untuk setiap <i>user</i>-nya. Setelah semua informasi yang diperlukan telah disiapkan, kini saatnya Ryujin menuliskan semua informasi tersebut ke dalam laporan dengan format file `csv`.

### 1D ###

### SOAL : ###

Semua informasi yang didapatkan pada poin <b>b</b> dituliskan ke dalam file `error_message.csv` dengan header <b>Error,Count</b> yang kemudian diikuti oleh daftar pesan error dan jumlah kemunculannya <b>diurutkan</b> berdasarkan jumlah kemunculan pesan error dari yang terbanyak.
