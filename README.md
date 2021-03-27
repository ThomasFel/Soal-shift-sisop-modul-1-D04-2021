# Soal Shift Sisop 2021 Modul 1

Kelompok D-04
- Thomas Felix Brilliant (05111940000062)
- Muhammad Rizky Widodo (05111940000216)
- Fiodhy Ardito Narawangsa (05111940000218)

## SOAL 1 ##

Ryujin baru saja diterima sebagai IT support di perusahaan Bukapedia. Dia diberikan tugas untuk membuat laporan harian untuk aplikasi internal perusahaan, <i>ticky</i>. Terdapat 2 laporan yang harus dia buat, yaitu laporan <b>daftar peringkat pesan error</b> terbanyak yang dibuat oleh <i>ticky</i> dan laporan <b>penggunaan user</b> pada aplikasi <i>ticky</i>. Untuk membuat laporan tersebut, Ryujin harus melakukan beberapa hal berikut:

### 1A ###

- <b>SOAL</b>
  
  Mengumpulkan informasi dari log aplikasi yang terdapat pada file `syslog.log`. Informasi yang diperlukan antara lain: jenis log (`ERROR/INFO`), pesan log, dan username pada setiap baris lognya. Karena Ryujin merasa kesulitan jika harus memeriksa satu per satu baris secara manual, dia menggunakan regex untuk mempermudah pekerjaannya. Bantulah Ryujin membuat regex tersebut.

### 1B ###

- <b>SOAL</b>

  Kemudian, Ryujin harus menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.

### 1C ###

- <b>SOAL</b>

  Ryujin juga harus dapat menampilkan jumlah kemunculan log `ERROR` dan `INFO` untuk setiap <i>user</i>-nya. Setelah semua informasi yang diperlukan telah disiapkan, kini saatnya Ryujin menuliskan semua informasi tersebut ke dalam laporan dengan format file `csv`.

### 1D ###

- <b>SOAL</b>

  Semua informasi yang didapatkan pada poin <b>b</b> dituliskan ke dalam file `error_message.csv` dengan header <b>Error,Count</b> yang kemudian diikuti oleh daftar pesan error dan jumlah kemunculannya <b>diurutkan</b> berdasarkan jumlah kemunculan pesan error dari yang terbanyak.
 
## SOAL 2 ##

Steven dan Manis mendirikan sebuah <i>startup</i> bernama “TokoShiSop”. Sedangkan kamu dan Clemong adalah karyawan pertama dari TokoShiSop. Setelah tiga tahun bekerja, Clemong diangkat menjadi manajer penjualan TokoShiSop, sedangkan kamu menjadi kepala gudang yang mengatur keluar masuknya barang.

Tiap tahunnya, TokoShiSop mengadakan Rapat Kerja yang membahas bagaimana hasil penjualan dan strategi kedepannya yang akan diterapkan. Kamu sudah sangat menyiapkan sangat matang untuk raker tahun ini. Tetapi tiba-tiba, Steven, Manis, dan Clemong meminta kamu untuk mencari beberapa kesimpulan dari data penjualan “<i>[Laporan-TokoShiSop.tsv](https://drive.google.com/file/d/16GuWWg3tZpzO7lTKmyVF6I9JPFYJQFJ8/view?usp=sharing)</i>”.

### 2A ###

- <b>SOAL</b>
  
  Steven ingin mengapresiasi kinerja karyawannya selama ini dengan mengetahui <b>Row ID</b> dan <b>profit percentage</b> terbesar (jika hasil <i>profit percentage</i> terbesar lebih dari 1, maka ambil Row ID yang paling besar). Karena kamu bingung, Clemong memberikan definisi dari <i>profit percentage</i>, yaitu:
  ```
  ProfitPercetage = (Profit ÷ Cost Price) × 100
  ```
  <i>Cost Price</i> didapatkan dari pengurangan <i>Sales</i> dengan <i>Profit</i>. (<b>Quantity diabaikan</b>).

### 2B ###

- <b>SOAL</b>

  Clemong memiliki rencana promosi di Albuquerque menggunakan metode MLM. Oleh karena itu, Clemong membutuhkan daftar <b>nama <i>customer</i> pada transaksi tahun 2017 di Albuquerque</b>.

### 2C ###

- <b>SOAL</b>

  TokoShiSop berfokus tiga <i>segment customer</i>, antara lain: <i>Home Office</i>, <i>Consumer</i>, dan <i>Corporate</i>. Clemong ingin meningkatkan penjualan pada segmen <i>customer</i> yang paling sedikit. Oleh karena itu, Clemong membutuhkan <b>segment <i>customer</i></b> dan <b>jumlah transaksinya yang paling sedikit</b>.

### 2D ###

- <b>SOAL</b>
  
  TokoShiSop membagi wilayah bagian (<i>region</i>) penjualan menjadi empat bagian, antara lain: <i>Central</i>, <i>East</i>, <i>South</i>, dan <i>West</i>. Manis ingin mencari <b>wilayah bagian (region) yang memiliki total keuntungan (profit) paling sedikit</b> dan <b>total keuntungan wilayah tersebut</b>.

### 2E ###

- <b>SOAL</B>
  
  Agar mudah dibaca oleh Manis, Clemong, dan Steven, kamu diharapkan bisa membuat sebuah script yang akan menghasilkan file “<i>hasil.txt</i>”
  
  ## SOAL 3 ##
  
  Kuuhaku adalah orang yang sangat suka mengoleksi foto digital, karena ia malas, kuhaku tidak ingin repot repot mencari foto, selain itu dia juga ingin agar tidak ada orang yang melihat koleksi tsb, sayangnya ia memiliki teman yang bernama Steven yang memiliki rasa kepo yang luar biasa. Kuuhaku pun memiliki ide agar Steven tidak bisa melihat koleksinya, serta untuk mempermudah hidupnya, yaitu dengan meminta bantuan kalian
  
  ### 3A ###
  
  <b>SOAL</B>
  
  Membuat script untuk mengunduh 23 gambar dari "https://loremflickr.com/320/240/kitten serta menyimpan lognya ke file "Foto.log", serta tidak boleh ada gambar yang sama.  Lalu gambar gambar tsb disimpan demgam ma,a "Koleksi_XX" dengan nomor berurutan tanpa ada nomor yg hilang.

 ### 3B ###
  
  <b>SOAL</B>
  
  Kuhaaku ingin supaya script berjalan pada setiap sehari sekali pada jam 8 malam untuk taanggal tanggal tertentu setiap bulan yaitu dari tanggal 1 tujuh hari sekali (1,8,...), serta dari tanggal 2 empat hari sekali(2,6,...). Agar lebih rapih, gambar yang diunduh beserta log-nya dipindahkan ke folder dengan nama tanggal unduhnya dengan format "DD-MM-YY".
  
   ### 3C ###
  
  <b>SOAL</B>
  
  Karena kuuhaku bosan dengan gambar kucing saja juga harus mengunduh gambar kelinci dari https://loremflickr.com/320/240/bunny". Kuuhaku meminta kita mengunduh gambar kucing dan kelinci secara bergantian (1 kucing, 2 kelinci, 3 kucing) untuk membedakan folder yang berisi gambar kucing dan kelinci , nama folder diberi awalan "Kucing_" atau "Kelinci_" serta tanggal mengunduhnya dengan format "DD-MM-YYY".
  
### 3D ###
  
  <b>SOAL</B>
  
 Agar foto foto tersebut aman dari steven kuuhaku meminta kita untuk membuat script untuk memndahkan seluruh folder ke zip yang diberi nama "Koleksi.zip" dan mengunci zip dengan password berupa tanggal saat ini dengan format "MMDDYYY" 
 
 ### 3E ###
  
  <b>SOAL</B>
  
 Karena Kuuhaku hanya bertemu Steven pada saat jam kuloiah saja, yaitu setiap hari kecuali sabtu dan minggu dari jam 7 pagi sampai 6 sore, Kuuhaku ingin kita agar membuat koleksinya ter-zip saat jam kuliah saja, selain dari waktu tersebut ia ingin koleksinya ter un-zip dan tidak ada file zip sama sekali
