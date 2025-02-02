# Soal Shift Sisop 2021 Modul 1

Kelompok D-04
- Thomas Felix Brilliant (05111940000062)
- Muhammad Rizky Widodo (05111940000216)
- Fiodhy Ardito Narawangsa (05111940000218)

## SOAL 1 ##

### 1A ###

- <b>SOAL</b>
  
  Mengumpulkan informasi dari log aplikasi yang terdapat pada file `syslog.log`. Informasi yang diperlukan antara lain: jenis log (`ERROR/INFO`), pesan log, dan username pada setiap baris lognya. Karena Ryujin merasa kesulitan jika harus memeriksa satu per satu baris secara manual, dia menggunakan regex untuk mempermudah pekerjaannya. Bantulah Ryujin membuat regex tersebut.

- <b>JAWABAN</b>

  Menggunakan command ini:
  ```shell
  listLog=$(grep -o "ticky.*" syslog.log | cut -f -2)
  ```
  Untuk mengumpulkan informasi dari log aplikasi yang ada di `syslog.log`, menggunakan command `grep` yang mengambil kata kunci, di sini memakai "ticky.\*" untuk mencarinya. Lalu command `cut` mengambil deskripsi error dengan delimiter dan option yang sesuai.

- <b>OUTPUT</b>
  
  ```
  . . .
  ERROR The ticket was modified while updating (breee)
  ERROR Permission denied while closing ticket (ac)
  INFO Commented on ticket [#4709] (blossom)
  . . .
  ```
  
### 1B ###

- <b>SOAL</b>

  Kemudian, Ryujin harus menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.
  
- <b>JAWABAN</b>

  Menggunakan command ini:
  ```shell
  listError=$(grep -o "ERROR.*" syslog.log | cut -d " " -f 2- | cut -d "(" -f 1 | sort -V | uniq -c | sort -n -r)
  ```
  Untuk menampilkan semua pesan error dari log aplikasi yang ada di `syslog.log` serta jumlah kemunculannya, menggunakan command `grep` yang mengambil kata kunci, di sini memakai "ERROR.\*" untuk mencarinya. Sebelumnya di sini menggunakan operator `|` pipe untuk mengubah input ke command selanjutnya. Option `-o` digunakan untuk print hasil yang hanya sesuai kata kunci, lalu command `cut` mengambil deskripsi error dengan delimiter dan option yang sesuai. Setelah itu dirapikan menggunakan command `sort` dengan option `-V`, dan tiap error-error yang mempunyai duplikat akan dihitung dengan command `uniq` dengan option `-c`. Terakhir di-<i>sort</i> secara <i>descending</i> (paling besar) menggunakan command `sort` dengan option `-n` dan `-r`.
  
- <b>OUTPUT</b>
  
  ```
  15  Timeout while retrieving information
  13  Connection to DB Failed
  12  Tried to add information to closed ticket
  10  Permission denied while closing ticket
   9  The ticket was modified while updating
   7  Ticket doesn't exist
  ```

### 1C ###

- <b>SOAL</b>

  Ryujin juga harus dapat menampilkan jumlah kemunculan log `ERROR` dan `INFO` untuk setiap <i>user</i>-nya. Setelah semua informasi yang diperlukan telah disiapkan, kini saatnya Ryujin menuliskan semua informasi tersebut ke dalam laporan dengan format file `csv`.
  
- <b>JAWABAN</b>

  Menggunakan command ini:
  ```shell
  listUser=$(cut -d"(" -f 2 < syslog.log | cut -d ")" -f 1 | sort | uniq)
  ```
  Untuk menyimpan list nama user dari log "ERROR" aplikasi yang ada di `syslog.log`, menggunakan command `cut` yang memotong string, di sini memakai option `-d"(" -f 2 < syslog.log` untuk memotong <b>field kedua sampai pertama</b> dengan patokan <i>char</i> "(". Sebelumnya di sini menggunakan operator `|` pipe untuk mengubah input ke command selanjutnya. Kemudian, menggunakan command `cut` kembali dengan option `cut -d ")" -f 1` untuk memotong <b>field pertama</b> dengan patokan <i>char</i> ")". Setelah itu dirapikan menggunakan command `sort`, dan tiap error-error yang mempunyai duplikat akan dihapus dan hanya akan muncul 1 kali saja.
  
  Lalu dengan command ini:
  ```shell
  userError=$(grep -o "ERROR.*" syslog.log | cut -f 2- -d"(" | cut -d ")" -f 1 | sort | uniq -c | sort -n)
  userInfo=$(grep -o "INFO.*" syslog.log | cut -f 2- -d"(" | cut -d ")" -f 1 | sort | uniq -c | sort -n)
  ```
  Untuk menghitung jumlah user dari log "ERROR" atau "INFO" aplikasi yang ada di `syslog.log`, menggunakan command `grep` yang mengambil kata kunci, di sini memakai "ERROR.\*" atau "INFO.\*" untuk mencarinya. Sebelumnya di sini menggunakan operator `|` pipe untuk mengubah input ke command selanjutnya. Kemudian, memakai option `-d"(" -f 2 < syslog.log` untuk memotong <b>field kedua sampai pertama</b> dengan patokan <i>char</i> "(", dan menggunakan command `cut` kembali dengan option `cut -d ")" -f 1` untuk memotong <b>field pertama</b> dengan patokan <i>char</i> ")", dan tiap error-error yang mempunyai duplikat akan dihitung dengan command `uniq` dengan option `-c`. Terakhir di-<i>sort</i> secara ascending (paling kecil) menggunakan command `sort` dengan option `-n`.

- <b>OUTPUT</b>
  
  <b><i>ERROR LOG</i></b>
  
  ```
  . . .
  3 enim.non
  3 mai.hendrix
  3 mcintosh
  . . .
  ```
  
  <b><i>INFO LOG</i></b>
  ```
  . . .
  2 jackowens
  2 kirknixon
  2 mdouglas
  . . .
  ```
  
### 1D ###

- <b>SOAL</b>

  Semua informasi yang didapatkan pada poin <b>b</b> dituliskan ke dalam file `error_message.csv` dengan header <b>Error,Count</b> yang kemudian diikuti oleh daftar pesan error dan jumlah kemunculannya <b>diurutkan</b> berdasarkan jumlah kemunculan pesan error dari yang terbanyak.

- <b>JAWABAN</b>

  Menggunakan command ini:
  ```shell
  echo "Error,Count" > error_message.csv
  echo "$listError" | while read errors

  do
      errorName=$(echo $errors | cut -d " " -f 2-)
      errorTotal=$(echo $errors | cut -d " " -f 1)
      echo "$errorName,$errorTotal" >> error_message.csv
  done
  ```
  Pesan "Error,Count" dikirim ke "<i>error_message.csv</i>". Lalu pada `$listError` menjadi input bagi perulangan <i>while</i> dan dimasukkan ke variabel `errors`. Deskripsi Error dan jumlahnya dimasukkan ke variabel `errorName` dan `errorTotal`. Pada `errorName`, digunakan command `echo` untuk mencetak output dari command `cut` kembali dengan option `cut -d " " -f 2-` untuk memotong <b>field kedua sampai akhir</b> dengan patokan <i>char</i> " " (spasi). Pada `errorTotal`, command `echo` untuk mencetak output dari command `cut` kembali dengan option `cut -d " " -f 1` untuk memotong <b>field pertama</b> dengan patokan <i>char</i> " " (spasi). Terakhir, hasilnya dimasukkan ke "<i>error_message.csv</i>".

- <b>OUTPUT</b>
  
  <b><i>error_message.csv</i></b>
  
  <img src="https://user-images.githubusercontent.com/37539546/113507893-48cd6800-9577-11eb-8905-b72d23a1733b.png" width="640" height="480">
  
### 1E ###

- <b>SOAL</b>

  Semua informasi yang didapatkan pada poin <b>c</b> dituliskan ke dalam file `user_statistic.csv` dengan header <b>Username,INFO,ERROR</b> <b>diurutkan</b> berdasarkan username secara <b><i>descending</i></b>.

- <b>JAWABAN</b>

  Menggunakan command ini:
  ```shell
  echo "Username,INFO,ERROR" > user_statistic.csv
  echo "$listUser" | while read users

  do
      totalUserError=$(grep --count "ERROR.*($users)" syslog.log)
      totalUserInfo=$(grep --count "INFO.*($users)" syslog.log)
      echo "$users,$totalUserInfo,$totalUserError" >> user_statistic.csv
  done
  ```
  Pesan "Error,Count" dikirim ke "<i>error_message.csv</i>". Lalu pada `$listUser` yang berisi list User tadi menjadi input bagi perulangan <i>while</i> dan dimasukkan ke variabel `users`. Nama user dan jumlahnya dimasukkan ke variabel `totalUserError` dan `totalUserInfo`. Lalu, untuk menghitung jumlah user dan error tiap usernya, bisa menggunakan command `grep` dengan option `--count` yang akan menghitung setiap keyword yang muncul per baris dalam hal ini `$users`. Terakhir, hasilnya dimasukkan ke "<i>user_statistic.csv</i>".

- <b>OUTPUT</b>
  
  <b><i>user_statistic.csv</i></b>
  
  <img src="https://user-images.githubusercontent.com/37539546/113508036-f5a7e500-9577-11eb-97bb-164651bbc440.png" width="640" height="480">

### KENDALA ###

- Kendala yang dialami sewaktu mengerjakan soal no. 1 ini adalah saat membuat regex. Di sini bingung karena selama ini jarang memakai, apalagi juga belum terbiasa dengan sintaks Bash. Jadi memang harus cari referensi dan manual yang ada di Bash.
- Masih bingung penggunaan `grep` dan `cut` beserta command-nya seperti <i>delimiter</i> dan <i>field</i>.
- Kebanyakan di soal ini salah membaca dan menangkap soal, jadi output yang dihasilkan tidak sesuai yang diharapkan.
- Kesulitan terutama di soal 1E untuk menghitung jumlah log ERROR dan INFO. 

## SOAL 2 ##

### 2A ###

- <b>SOAL</b>
  
  Steven ingin mengapresiasi kinerja karyawannya selama ini dengan mengetahui <b>Row ID</b> dan <b>profit percentage</b> terbesar (jika hasil <i>profit percentage</i> terbesar lebih dari 1, maka ambil Row ID yang paling besar). Karena kamu bingung, Clemong memberikan definisi dari <i>profit percentage</i>, yaitu:
  ```
  ProfitPercetage = (Profit ÷ Cost Price) × 100
  ```
  <i>Cost Price</i> didapatkan dari pengurangan <i>Sales</i> dengan <i>Profit</i>. (<b>Quantity diabaikan</b>).

- <b>JAWABAN</b>

  Pada soal ini digunakan AWK dalam penyelesaiannya.
  ```shell
  BEGIN {
    maxID = 0;
    max = 0;
  }
  ```
  Pertama kita menginisialisasi variabel untuk menjalankan program. `maxID` untuk menyimpan nilai maksimum <i>RowID</i> dan `max` untuk menyimpan nilai <i>profit percentage</i> terbesar.
  
  Lalu, pada bagian <i>main</i>-nya, terdapat command berikut:
  ```shell
  {
    rowID = $1;
    sales = $18;
    profit = $21;
    if (NR != 1) {
        costPrice = sales - profit;
        profitPercentage = (profit / costPrice) * 100;
            if (max <= profitPercentage) {
                max = profitPercentage;
                maxID = rowID;
            }
    }
  }
  ```
  Kemudian membuat inisial variabel agar lebih mudah dalam pembacaan kode, dengan `rowID = $1`, `sales = $18`, dan `profit = $21`. Pada pengondisian `NR atau <i>Number of Row</i> != 1` maksudnya adalah agar bagian paling atas data (<i>header</i>) sendiri tidak di-<i>passing</i>. Di dalam pengondisian itu, dilakukan pendefinisian `costPrice = sales - profit`, juga `profitPercentage` sesuai permintaan soal. Lalu, jika `max <= profitPercentage`, nilai `max` akan sama dengan `profitPercentage` dan `maxID` sama dengan `rowID`, hal ini dilakukan untuk mendapat nilai terbesar. Pengondisian akan terus terjadi selama masih bernilai <b>TRUE</b>, sehingga nilai akan terus ter-<i>update</i>.
  
  Pada akhir script nomor 2A bagian END:
  ```shell
  END {
    printf "Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %.2f%%.\n\n", maxID, max;
  } ' Laporan-TokoShiSop.tsv >> hasil.txt
  ```
  Bagian ini digunakan sebagai output yang formatnya sesuai dengan permintaan soal. "<i>Laporan-TokoShisop.tsv</i>" sendiri adalah source file data yang dipakai dalam pemrosesan program yang kemudian hasilnya dimasukkan ke dalam "<i>hasil.txt</i>".
  
### 2B ###

- <b>SOAL</b>

  Clemong memiliki rencana promosi di Albuquerque menggunakan metode MLM. Oleh karena itu, Clemong membutuhkan daftar <b>nama <i>customer</i> pada transaksi tahun 2017 di Albuquerque</b>.

- <b>JAWABAN</b>

  Pada bagian awal soal 2B:
  ```shell
  BEGIN {
    printf "Daftar nama customer di Albuquerque pada tahun 2017 antara lain: \n";
  }
  ```
  Pertama kita mengeluarkan output yang sesuai dengan permintaan soal.
  
  Lalu, pada bagian <i>main</i>-nya, terdapat command berikut:
  ```shell
  {
    orderDate = $3;
    city = $10;
    years = substr(orderDate, 7, 2);
    if (NR != 1) {
        if (years == 17 && city == "Albuquerque") {
            namesArr[$7];
        }
    }
  }
  ```
   Kemudian membuat inisial variabel agar lebih mudah dalam pembacaan kode, dengan `orderDate = $3` dan `city = $10`. Dalam row `orderDate` yang ada di "<i>Laporan-TokoShisop.tsv</i>", karena formatnya <b>DD-MM-YY</b>, digunakan fungsi <b>substr</b> untuk mendapatkan nilai tahun yang kemudian dimasukkan ke variabel `years`. Pada pengondisian `NR atau <i>Number of Row</i> != 1` maksudnya adalah agar bagian paling atas data (<i>header</i>) sendiri tidak di-<i>passing</i>. Lalu, karena diminta tahun sama dengan 2017 dan kotanya Albuquerque ditambahkan jika `years == 17 && city == "Albuquerque"`, nilai yang berisi nama-nama orang di kolom 7 ($7) akan dimasukkan ke dalam array `namesArr`.
   
   Pada akhir script nomor 2B bagian END:
  ```shell
  END {
    for (nameArr in namesArr) {
        print nameArr;
    }
    printf "\n";
  } ' Laporan-TokoShiSop.tsv >> hasil.txt
  ```
  Bagian ini digunakan sebagai output nama orang tadi dan formatnya disesuaikan dengan permintaan soal. Di sini memakai perulangan <i>for in</i> untuk mencetaknya. "<i>Laporan-TokoShisop.tsv</i>" sendiri adalah source file data yang dipakai dalam pemrosesan program yang kemudian hasilnya dimasukkan ke dalam "<i>hasil.txt</i>".

### 2C ###

- <b>SOAL</b>

  TokoShiSop berfokus tiga <i>segment customer</i>, antara lain: <i>Home Office</i>, <i>Consumer</i>, dan <i>Corporate</i>. Clemong ingin meningkatkan penjualan pada segmen <i>customer</i> yang paling sedikit. Oleh karena itu, Clemong membutuhkan <b>segment <i>customer</i></b> dan <b>jumlah transaksinya yang paling sedikit</b>.

- <b>JAWABAN</b>

  Pada bagian awal soal 2C:
  ```shell
  BEGIN {
    homeOffice = 0;
    consumer = 0;
    corporate = 0;
  }
  ```
  Pertama kita menginisialisasi variabel untuk menjalankan program. `homeOffice` untuk menyimpan nilai kemunculan <i>Home Office</i>, `consumer` untuk menyimpan nilai kemunculan <i>Consumer</i>, dan `corporate` untuk menyimpan nilai kemunculan <i>Corporate</i>.
  
  Lalu, pada bagian <i>main</i>-nya, terdapat command berikut:
  ```shell
  {
    segment = $8;
    if (NR != 1) {
        if (segment == "Home Office") {
            homeOffice++;
        }
        else if (segment == "Consumer") {
            consumer++;
        }
        else if (segment == "Corporate") {
            corporate++;
        }
    }
  }
  ```
   Kemudian membuat inisial variabel agar lebih mudah dalam pembacaan kode, dengan `segment = $8`. Pada pengondisian `NR atau <i>Number of Row</i> != 1` maksudnya adalah agar bagian paling atas data (<i>header</i>) sendiri tidak di-<i>passing</i>. Lalu, ditambahkan kondisi untuk menghitung nilai kemunculan tiap-tiap segmennya, jika `segment == "Home Office"`, variabel `homeOffice` akan di-<i>counter</i>, jika `segment == "Consumer"`, variabel `consumer` akan di-<i>counter</i>, dan jika `segment == "Corporate"`, variabel `corporate` akan di-<i>counter</i>.
   
   Pada akhir script nomor 2C bagian END:
  ```shell
  END {
    if (homeOffice < consumer && homeOffice < corporate) {
        leastSegment = "Home Office";
        leastTransaction = homeOffice;
    }
    
    else if (consumer < homeOffice && consumer < corporate) {
        leastSegment = "Consumer";
        leastTransaction = consumer;
    }
    else if (corporate < homeOffice && corporate < consumer) {
        leastSegment = "Corporate";
        leastTransaction = corporate;
    }
    printf "Tipe segmen customer yang penjualannya paling sedikit adalah %s dengan %d transaksi.\n\n", leastSegment, leastTransaction;
  } ' Laporan-TokoShiSop.tsv >> hasil.txt
  ```
  Bagian ini digunakan sebagai output nama dan formatnya disesuaikan dengan permintaan soal. Di sini menggunakan pengondisian untuk mencari nilai terkecil (penjualan paling sedikit). Jika `homeOffice < consumer && homeOffice < corporate`, maka variabel `leastSegment` menjadi <i>Home Office</i> dan `leastTransaction` akan sama dengan variabel `homeOffice`, berlaku sama dengan segmen lainnya. "<i>Laporan-TokoShisop.tsv</i>" sendiri adalah source file data yang dipakai dalam pemrosesan program yang kemudian hasilnya dimasukkan ke dalam "<i>hasil.txt</i>".

### 2D ###

- <b>SOAL</b>
  
  TokoShiSop membagi wilayah bagian (<i>region</i>) penjualan menjadi empat bagian, antara lain: <i>Central</i>, <i>East</i>, <i>South</i>, dan <i>West</i>. Manis ingin mencari <b>wilayah bagian (region) yang memiliki total keuntungan (profit) paling sedikit</b> dan <b>total keuntungan wilayah tersebut</b>.
  
- <b>JAWABAN</b>

  Pada bagian awal soal 2D:
  ```shell
  BEGIN {
    central = 0;
    east = 0;
    south = 0;
    west = 0;
  }
  ```
  Pertama kita menginisialisasi variabel untuk menjalankan program. `central` untuk menyimpan nilai kemunculan <i>Central</i>, `east` untuk menyimpan nilai kemunculan <i>East</i>, `south` untuk menyimpan nilai kemunculan <i>South</i>, dan `west` untuk menyimpan nilai kemunculan <i>West</i>.
  
  Lalu, pada bagian <i>main</i>-nya, terdapat command berikut:
  ```shell
  {
    region = $13;
    profit = $21;
    if (NR != 1) {
        if (region == "Central") {
            central += profit;
        }
        else if (region == "East") {
            east += profit;
        }
        else if (region == "South") {
            south += profit;
        }
        else if (region == "West") {
            west += profit;
        }
    }
  }
  ```
   Kemudian membuat inisial variabel agar lebih mudah dalam pembacaan kode, dengan `region = $13` dan `profit = $21`. Pada pengondisian `NR atau Number of Row != 1` maksudnya adalah agar bagian paling atas data (<i>header</i>) sendiri tidak di-<i>passing</i>. Lalu, ditambahkan kondisi untuk menghitung nilai kemunculan tiap-tiap regionnya, jika `region == "Central"`, variabel `central` akan ditambah nilai variabel `profit`, jika `region == "East"`, variabel `east` akan ditambah nilai variabel `profit`, jika `region == "South"`, variabel `south` akan ditambah nilai variabel `profit`, dan jika `region == "West"`, variabel `west` akan ditambah nilai variabel `profit`.
   
   Pada akhir script nomor 2C bagian END:
  ```shell
  END {
    if (central < east && central < south && central < west) {
        leastRegion = "Central";
        leastProfit = central;
    }
    
    else if (east < central && east < south && east < west) {
        leastRegion = "East";
        leastProfit = east;
    }
    else if (south < central && south < east && south < west) {
        leastRegion = "South";
        leastProfit = south;
    }
    else if (west < central && west < east && west < south) {
        leastRegion = "West";
        leastProfit = west;
    }
    printf "Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah %s dengan total keuntungan %.3f.\n", leastRegion, leastProfit;
  } ' Laporan-TokoShiSop.tsv >> hasil.txt
  ```
  Bagian ini digunakan sebagai output nama dan formatnya disesuaikan dengan permintaan soal. Di sini menggunakan pengondisian untuk mencari nilai terkecil (penjualan paling sedikit). Jika `central < east && central < south && central < west`, maka variabel `leastRegion` menjadi <i>Central</i> dan `leastProfit` akan sama dengan variabel `central`, berlaku sama dengan region lainnya. "<i>Laporan-TokoShisop.tsv</i>" sendiri adalah source file data yang dipakai dalam pemrosesan program yang kemudian hasilnya dimasukkan ke dalam "<i>hasil.txt</i>".

### 2E ###

- <b>SOAL</B>
  
  Agar mudah dibaca oleh Manis, Clemong, dan Steven, kamu diharapkan bisa membuat sebuah script yang akan menghasilkan file “<i>hasil.txt</i>”

- <b>JAWABAN</b>

  Pada tiap akhir bagian AWK soal 2, selalu ditambahkan:
  ```shell
  Laporan-TokoShiSop.tsv >> hasil.txt
  ```
  Agar hasilnya dimasukkan ke dalam "<i>hasil.txt</i>".

- <b>OUTPUT</b>
  
  <b><i>hasil.txt</i></b>
  
  <img src="https://user-images.githubusercontent.com/37539546/113508139-85e62a00-9578-11eb-9294-c976ea1c5708.png" width="640" height="480">

### KENDALA ###

- Kendala yang dialami sewaktu mengerjakan soal no. 2 adalah jelas mencari algoritma untuk pemecahannya.
- Awalnya kebingungan untuk memisahkan <i>row</i> paling atas karena hanya ingin mengambil <i>value</i> selain itu.
- Membiasakan diri dengan sintaks AWK karena baru memakai pertama kali. 

## SOAL 3 ##
  
 ### 3A ###
  
- <b>SOAL</B>
  
  Membuat script untuk <b>mengunduh</b> 23 gambar dari "https://loremflickr.com/320/240/kitten" serta <b>menyimpan</b> log-nya ke file "<i>Foto.log</i>". Karena gambar yang diunduh acak, ada kemungkinan gambar yang sama terunduh lebih dari sekali, oleh karena itu kalian harus <b>menghapus</b> gambar yang sama (tidak perlu mengunduh gambar lagi untuk menggantinya). Kemudian menyimpan gambar-gambar tersebut dengan nama "Koleksi_XX" dengan nomor yang berurutan <b>tanpa ada nomor yang hilang</b> (contoh : Koleksi_01, Koleksi_02, ...)
  
- <b>JAWABAN</B>
  
  ```shell
  max=23
  file=1
    for ((count=1;count<=max;count=count+1))
    do
      issame=0
      wget "https://loremflickr.com/320/240/kitten" -a Foto.log -O kitten
  ```
  Pertama me-looping untuk men-download file dari url yang diinginkan dengan mendeklarasikan variabel `max` sebagai batas jumlah file yang akan di-download. Kemudian variabel `file` digunakan sebagai index untuk setiap file yang di-download. Dan juga di awal looping dideklarasikan variabel `issame` sebagai penanda untuk file yang akan dicek sama tidaknya. Untuk men-download file digunakan `wget` dan juga ditambahkan command `-a` untuk menyimpan log ke `Foto.log` dan juga `-O` untuk rename file menjadi kitten agar mudah untuk melakukan pengecekan dan merename.
  
  ```shell
  if [ $count -eq 1 ]
   then
     mv kitten `printf "Koleksi_%02d" "$file"`
     file=$(($file+1)) 
   fi
  ```
  Kemudian di dalam loop sebelum melakukan looping untuk melakukan pengecekan kesamaan file, untuk file yang pertama kali di-download langsung di rename dengan menggunakan `printf "Koleksi_%02d" "$file"` agar mendapatkan format penamaan file (01, 02, ..., dst) dan juga karena untuk file yang pertama tidak ada file lain untuk di-compare. Setelah dilakukan rename maka variabel `file` akan di-increment.
  
  ```shell
  for ((count2=1;count2<file;count2=count2+1))
   do
      if [ $count -eq 1 ]
      then break
      fi

      nama=`printf "Koleksi_%02d" "$count2"`
      sama=`cmp $nama kitten -b`

      if [ -z "$sama" ]
      then
        issame=1
        break
      else
        issame=0
      fi
   done
   ```
   Kemudian dilakukan looping baru didalam looping yang sebelumnya untuk mengecek kesamaan setiap file, namun sebelum itu dicek apabila index untuk looping pertama masih di 1 maka akan langsung keluar dari looping kedua. Dalam looping kedua yang dilakukan pertama yaitu mendeklarasikan variabel `nama` untuk nama filenya dengan index looping kedua. Kemudian dideklarasikan pula variabel `sama` untuk menyimpan informasi yang dihasilkan dari hasil `cmp`. `cmp` merupakan syntax untuk membandingkan 2 buah file berdasarkan bytenya sehingga apabila ada 2 file yang sama maka akan menghasilkan output NULL. Kemudian setelah itu dilakukan pengecekkan dengan menggunakan perintah `-z` untuk membandingkan apabila variabel `sama` menghasilkan NULL atau tidak. Apabila menghasilkan NULL maka variabel `issame` akan sama dengan 1 untuk menandakan bahwa file yang sedang dicek merupakan file yang sama, oleh karena itu loop akan di-break dan program akan melaksanakan perintah selanjutnya di luar loop kedua. Namun apabila file tidak sama, maka akan terus dilakukan pengecakan antar file sampai batas looping.
   
   ```shell
   if [ $count -gt 1 ]
   then
     if [ $issame -eq 1 ]
     then
       rm kitten
     else
       mv kitten `printf "Koleksi_%02d" "$file"`
       file=$(($file+1))
     fi
   fi
  done
  ```
  Lalu di luar looping kedua yang digunakan sintaks `if [ $count -gt 1 ]` untuk menghindari file pertama karena tidak ada perbandingan. Kemudian apabila bukan file yang pertama akan dicek variabel `issame` apabila berisi 1 yang menandakan file-nya sama, maka akan digunakan perintah `rm` untuk me-remove file kemudian melanjutkan looping pertama, dan apabila variabel `issame` berisi 0, maka file yang sekarang bernama kitten akan di-rename dengan menggunakan perintah `mv` menjadi nama file sesuai format dan kemudian variabel `file` akan di-increment dan looping untuk men-download file dan mengecek kesamaannya akan dilanjutkan hingga batas max yaitu 23.

- <b>OUTPUT</b>
  
  <img src="https://user-images.githubusercontent.com/37539546/113508497-897ab080-957a-11eb-8a45-9e3762f2d21d.png" width="640" height="480">
  
  Ini merupakan output dari soal no. 3A. Di sini bisa dilihat jumlah foto yang di-download tidak sesuai dengan jumlah yang ditentukan di soal. Ini dikarenakan di dalam script ada algoritma untuk mem-filter file yang memiliki duplikat dan tidak perlu mendownload lagi file tersebut sehingga jumlah file yang ada sekarang merupakan jumlah file yang sudah selesai di-remove file yang memiliki duplikat.
      
 ### 3B ###
  
- <b>SOAL</B>
  
  Karena Kuuhaku malas untuk menjalankan script tersebut secara manual, ia juga meminta kalian untuk menjalankan script tersebut <b>sehari sekali pada jam 8 malam</b> untuk tanggal-tanggal tertentu setiap bulan, yaitu dari <b>tanggal 1 tujuh hari sekali</b> (1,8,...), serta dari <b>tanggal 2 empat hari sekali</b> (2,6,...). Supaya lebih rapi, gambar yang telah diunduh beserta <b>log-nya, dipindahkan ke folder</b> dengan nama <b>tanggal unduhnya</b> dengan <b>format</b> "DD-MM-YYYY" (contoh : "13-03-2023").

- <b>JAWABAN (SOAL3B.SH)</B>
  
  ```shell
  folder=/home/thomasfelix/PRAKTIKUM1/SOAL3/soal3a.sh
  file=$(date +"%d-%m-%Y")

  bash $folder

  mkdir $file

  mv Koleksi_* $file
  mv Foto.log $file
  ```
  Pertama mendefinisikan path directory dari `soal3a.sh` ke dalam variabel `folder`, kemudian dijalankan dengan bash. Setelah itu buat folder baru dengan command `mkdir` dengan nama folder dari variabel `file` yang telah didefinisikan agar keluar output tanggal saat ini dengan format DD-MM-YYYY. Terakhir, pindahkan folder yang mengandung nama <i>Koleksi_</i> dan <i>Foto.log</i> ke folder baru yang telah dibuat tadi.

- <b>JAWABAN (CRON3B.TAB)</B>
  
  ```shell
  0 20 1-31/7,2-31/4 * * cd /home/thomasfelix/PRAKTIKUM1/SOAL3 && bash soal3b.sh
  ```
  Menjalankan script `soal3b.sh` pada pukul 20.00 (8 malam), dalam interval tanggal 1-31 tiap 7 hari sekali, dan interval tanggal 2-31 tiap 4 hari sekali tiap bulannya.

- <b>OUTPUT</b>

  <img src="https://user-images.githubusercontent.com/37539546/113508552-d3639680-957a-11eb-872a-44c6809585e0.png" width="640" height="480">
  <img src="https://user-images.githubusercontent.com/37539546/113508272-4704a400-9579-11eb-8af6-76f98a97d2f0.png" width="640" height="480">
  
### 3C ###
  
- <b>SOAL</B>
  
  Agar Kuuhaku tidak bosan dengan gambar anak kucing, ia juga memintamu untuk <b>mengunduh</b> gambar kelinci dari "https://loremflickr.com/320/240/bunny". Kuuhaku memintamu mengunduh gambar kucing dan kelinci secara bergantian (yang pertama bebas. contoh : tanggal 30 kucing > tanggal 31 kelinci > tanggal 1 kucing > ... ). Untuk membedakan folder yang berisi gambar kucing dan gambar kelinci, <b>nama folder diberi awalan</b> "Kucing_" atau "Kelinci_" (contoh : "Kucing_13-03-2023").

- <b>JAWABAN</B>
  
  ```shell
    usagi() {
      max=23
      file=1

      for ((count=1;count<=max;count=count+1))
      do
          issame=0
          wget "https://loremflickr.com/320/240/bunny" -a Foto.log -O bunny

          if [ $count -eq 1 ]
          then
              mv bunny `printf "Koleksi_%02d" "$file"`
              file=$(($file+1))
          fi

          for ((count2=1;count2<file;count2=count2+1))
          do
              if [ $count -eq 1 ]
              then break
              fi

              nama=`printf "Koleksi_%02d" "$count2"`
              sama=`cmp $nama bunny -b`

              if [ -z "$sama" ]
              then
                  issame=1
                  break
              else
                  issame=0
              fi
          done

          if [ $count -gt 1 ]
          then
              if [ $issame -eq 1 ]
              then
                  rm bunny
              else
                  mv bunny `printf "Koleksi_%02d" "$file"`
                  file=$(($file+1))
              fi
          fi
      done

      folder=$(date +"%d-%m-%Y")

      mkdir "Kelinci_$folder"

      mv Koleksi_* "Kelinci_$folder"
      mv Foto.log "Kelinci_$folder"
  }
  ```
  Memodifikasi dengan menggabungkan penyelesaian `soal3a.sh` dan `soal3b.sh`, lalu memasukkannya ke dalam fungsi. Untuk gambar kucing dimasukkan ke dalam fungsi `neko()` dan kelinci ke fungsi `usagi()`. Pada fungsi `usagi()` mengalami perubahan dari <i>kitten</i> menjadi <i>bunny</i> dan folder dari `Kucing_` menjadi `Kelinci_`.
  
  ```bash
  nekoTotal=$(ls | grep "Kucing_" | wc -l)
  usagiTotal=$(ls | grep "Kelinci_" | wc -l)

  if [[ $nekoTotal -eq $usagiTotal ]]
  then
      usagi

  else [[ $nekoTotal -ne $usagiTotal ]]
      neko
  fi
  ```
  Soal meminta untuk mengunduh gambar bergantian, maka dari itu diperlukan suatu kondisi agar hal itu bisa terjadi. Di sini, dapatlah ide untuk menghitung jumlah folder gambar kucing ataupun kelinci yang dimasukkan ke variabel `nekoTotal` atau `usagiTotal`. Karena kondisi awal bebas, bisa kucing atau kelinci yang dijalankan terlebih dahulu. Di sini menggunakan fungsi `usagi` sebagai pengunduhan awal. Pengunduhan awal terjadi jika `$nekoTotal` sama dengan `$usagiTotal`. Kondisi awalnya adalah sama-sama 0. Kemudian pada pengunduhan kedua akan menjalankan fungsi `neko` karena jumlah `nekoTotal` masih 0 dan `usagiTotal` menjadi 1, sehingga tidak sama. Begitu seterusnya.

- <b>OUTPUT</b>

  <img src="https://user-images.githubusercontent.com/37539546/113508307-76b3ac00-9579-11eb-9b96-2364d7b5d0d5.png" width="640" height="480">
  <img src="https://user-images.githubusercontent.com/37539546/113508308-79160600-9579-11eb-9944-ac154890102d.png" width="640" height="480">
  
### 3D ###
  
- <b>SOAL</B>
  
  Untuk mengamankan koleksi Foto dari Steven, Kuuhaku memintamu untuk membuat script yang akan <b>memindahkan seluruh folder ke zip</b> yang diberi nama “Koleksi.zip” dan <b>mengunci</b> zip tersebut dengan <b>password</b> berupa tanggal saat ini dengan format "MMDDYYYY" (contoh : “03032003”).

- <b>JAWABAN</B>

  ```shell
  pass=$(date +"%m%d%Y")
  file=$(ls | grep -E "Kelinci_|Kucing_|-|Foto.log|Koleksi_")

  zip -r -P $pass Koleksi.zip $file
  rm -r $file
  ```
  Mendefinisikan password berupa date berformat MM-DD-YYYY ke dalam variabel `pass` dan regex untuk mencari folder yang akan di-zip dari file yang telah di-list dengan `ls`. Di sini semua folder hasil dari bash soal 3A, 3B, 3C harus dimasukkan ke dalam zip. Lalu, folder-folder tadi di-zip command `zip -r` untuk zip secara rekursif sehingga file ikut masuk ke dalamnya, ditambah password yang telah ditentukan di awal dan zip-nya dinamai dengan <i>Koleksi.zip</i>. Terakhir, semua folder tadi dihapus dengan `rm -r`.

- <b>OUTPUT</b>
  
  <img src="https://user-images.githubusercontent.com/37539546/113508343-b2e70c80-9579-11eb-804e-09c87812e9e4.png" width="640" height="480">
  
 ### 3E ###
  
- <b>SOAL</B>
  
  Karena Kuuhaku hanya bertemu Steven pada saat kuliah saja, yaitu setiap hari kecuali Sabtu dan Minggu, dari jam 7 pagi sampai 6 sore, ia memintamu untuk membuat koleksinya <b>ter-zip</b> saat kuliah saja, selain dari waktu yang disebutkan, ia ingin koleksinya <b>ter-unzip</b> dan <b>tidak ada file zip</b> sama sekali.
  
- <b>JAWABAN</B>

  ```shell
  0 7 * * 1-5 cd /home/thomasfelix/PRAKTIKUM1/SOAL3 && bash soal3d.sh
  ```
  Menjalankan script `soal3d.sh` pada pukul 07.00 (7 pagi), dalam interval Senin-Jumat (hari efektif kuliah) tiap minggunya.
  
  ```shell
  0 18 * * 1-5 cd /home/thomasfelix/PRAKTIKUM1/SOAL3 && unzip -P $(date + "\%m\%d\%Y") Koleksi.zip && rm Koleksi.zip
  ```
  Menjalankan unzip dengan password sesuai script `soal3d.sh` dan menghapus <i>Koleksi.zip</i> ketika semua file dan folder telah ter-unzip pada pukul 18.00 (6 malam), dalam interval Senin-Jumat (hari efektif kuliah) tiap minggunya.

### KENDALA ###

- Untuk soal no. 3A kendala yang dialami yaitu error ketika me-rename nama file karena saat me-rename file yang pertama di-download tidak ikut ter-rename, namun bisa diselesaikan dengan mengecualikan file pertama di dalam looping. Kemudian hambatan yang lainnya yaitu di saat harus remove dan rename nama filenya karena di awal ada banyak penamaannya yang berantakan sehingga sulit untuk mengetahui indexing filenya, namun hal tersebut bisa diatasi dengan menambahkan variabel file untuk indexing-nya. Lalu hambatan yang terakhir yaitu untuk mem-filter file duplikat karena isi looping kedua yang berantakan sehingga indexing untuk comparenya kurang pas, hal ini dapat diatasi dengan merapihkan kondisi looping kedua dan menambah variabel `file`.
- Crontab di perangkat terkadang tidak bisa jalan. Lalu, tanggal di VirtualBox tidak bisa diubah, <i>default</i> sesuai tanggal OS utama, jadi harus <i>try & error</i> script crontab untuk ujicoba apakah berjalan atau tidak.
- Hampir sama dengan no. 1, karena ada yang menggunakan regex, jadi masih bingung untuk mengambil kata kunci tertentu.
- Kesulitan waktu mencari algoritma yang mengunduh gambar kucing dan kelinci secara bergantian.
