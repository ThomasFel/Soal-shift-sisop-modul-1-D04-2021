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

- <b>JAWABAN</b>

  Menggunakan command ini:
  ```
  listLog=$(grep -o "ticky.*" syslog.log | cut -f -2)
  ```
  Untuk mengumpulkan informasi dari log aplikasi yang ada di `syslog.log`, menggunakan command `grep` yang mengambil kata kunci, di sini memakai "ticky.*emphasis*" untuk mencarinya. Lalu command `cut` mengambil deskripsi error dengan delimiter dan option yang sesuai.
  
### 1B ###

- <b>SOAL</b>

  Kemudian, Ryujin harus menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.
  
- <b>JAWABAN</b>

  Menggunakan command ini:
  ```
  listError=$(grep -o "ERROR.*" syslog.log | cut -d " " -f 2- | cut -d "(" -f 1 | sort -V | uniq -c | sort -n -r)
  ```
  Untuk menampilkan semua pesan error dari log aplikasi yang ada di `syslog.log` serta jumlah kemunculannya, menggunakan command `grep` yang mengambil kata kunci, di sini memakai "ERROR.*emphasis*" untuk mencarinya. Sebelumnya di sini menggunakan operator `|` pipe untuk mengubah input ke command selanjutnya. Option `-o` digunakan untuk print hasil yang hanya sesuai kata kunci, lalu command `cut` mengambil deskripsi error dengan delimiter dan option yang sesuai. Setelah itu dirapikan menggunakan command `sort` dengan option `-V`, dan tiap error-error yang mempunyai duplikat akan dihitung dengan command `uniq` dengan option `-c`. Terakhir di-<i>sort</i> secara descending (paling besar) menggunakan command `sort` dengan option `-n` dan `-r`.

### 1C ###

- <b>SOAL</b>

  Ryujin juga harus dapat menampilkan jumlah kemunculan log `ERROR` dan `INFO` untuk setiap <i>user</i>-nya. Setelah semua informasi yang diperlukan telah disiapkan, kini saatnya Ryujin menuliskan semua informasi tersebut ke dalam laporan dengan format file `csv`.
  
- <b>JAWABAN</b>

  Menggunakan command ini:
  ```
  listUser=$(cut -d"(" -f 2 < syslog.log | cut -d ")" -f 1 | sort | uniq)
  ```
  Untuk menyimpan list nama user dari log "ERROR" aplikasi yang ada di `syslog.log`, menggunakan command `cut` yang memotong string, di sini memakai option `-d"(" -f 2 < syslog.log` untuk memotong <b>field kedua sampai pertama</b> dengan patokan <i>char</i> "(". Sebelumnya di sini menggunakan operator `|` pipe untuk mengubah input ke command selanjutnya. Kemudian, menggunakan command `cut` kembali dengan option `cut -d ")" -f 1` untuk memotong <b>field pertama</b> dengan patokan <i>char</i> ")". Setelah itu dirapikan menggunakan command `sort`, dan tiap error-error yang mempunyai duplikat akan dihapus dan hanya akan muncul 1 kali saja.
  
  Lalu dengan command ini:
  ```
  userError=$(grep -o "ERROR.*" syslog.log | cut -f 2- -d"(" | cut -d ")" -f 1 | sort | uniq -c | sort -n)
  userInfo=$(grep -o "INFO.*" syslog.log | cut -f 2- -d"(" | cut -d ")" -f 1 | sort | uniq -c | sort -n)
  ```
  Untuk menghitung jumlah user dari log "ERROR" atau "INFO" aplikasi yang ada di `syslog.log`, menggunakan command `grep` yang mengambil kata kunci, di sini memakai "ERROR.*emphasis*" atau "INFO.*emphasis*" untuk mencarinya. Sebelumnya di sini menggunakan operator `|` pipe untuk mengubah input ke command selanjutnya. Kemudian, memakai option `-d"(" -f 2 < syslog.log` untuk memotong <b>field kedua sampai pertama</b> dengan patokan <i>char</i> "(", dan menggunakan command `cut` kembali dengan option `cut -d ")" -f 1` untuk memotong <b>field pertama</b> dengan patokan <i>char</i> ")", dan tiap error-error yang mempunyai duplikat akan dihitung dengan command `uniq` dengan option `-c`. Terakhir di-<i>sort</i> secara ascending (paling kecil) menggunakan command `sort` dengan option `-n`.


### 1D ###

- <b>SOAL</b>

  Semua informasi yang didapatkan pada poin <b>b</b> dituliskan ke dalam file `error_message.csv` dengan header <b>Error,Count</b> yang kemudian diikuti oleh daftar pesan error dan jumlah kemunculannya <b>diurutkan</b> berdasarkan jumlah kemunculan pesan error dari yang terbanyak.

- <b>JAWABAN</b>

  Menggunakan command ini:
  ```
  echo "Error,Count" > error_message.csv
  echo "$listError" | while read errors

  do
      errorName=$(echo $errors | cut -d " " -f 2-)
      errorTotal=$(echo $errors | cut -d " " -f 1)
      echo "$errorName,$errorTotal" >> error_message.csv
  done
  ```
  Pesan "Error,Count" dikirim ke "<i>error_message.csv</i>". Lalu pada `$listError` menjadi input bagi perulangan <i>while</i> dan dimasukkan ke variabel `errors`. Deskripsi Error dan jumlahnya dimasukkan ke variabel `errorName` dan `errorTotal`. Pada `errorName`, digunakan command `echo` untuk mencetak output dari command `cut` kembali dengan option `cut -d " " -f 2-` untuk memotong <b>field kedua sampai akhir</b> dengan patokan <i>char</i> " " (spasi). Pada `errorTotal`, command `echo` untuk mencetak output dari command `cut` kembali dengan option `cut -d " " -f 1` untuk memotong <b>field pertama</b> dengan patokan <i>char</i> " " (spasi). Terakhir, hasilnya dimasukkan ke "<i>error_message.csv</i>".

### 1E ###

- <b>SOAL</b>

  Semua informasi yang didapatkan pada poin <b>c</b> dituliskan ke dalam file `user_statistic.csv` dengan header <b>Username,INFO,ERROR</b> <b>diurutkan</b> berdasarkan username secara <b><i>ascending</i></b>.

- <b>JAWABAN</b>

  Menggunakan command ini:
  ```
  echo "Username,INFO,ERROR" > user_statistic.csv
  echo "$listUser" | while read users

  do
      totalUserError=$(grep --count "ERROR.*($users)" syslog.log)
      totalUserInfo=$(grep --count "INFO.*($users)" syslog.log)
      echo "$users,$totalUserInfo,$totalUserError" >> user_statistic.csv
  done
  ```
  Pesan "Error,Count" dikirim ke "<i>error_message.csv</i>". Lalu pada `$listUser` yang berisi list User tadi menjadi input bagi perulangan <i>while</i> dan dimasukkan ke variabel `users`. Nama user dan jumlahnya dimasukkan ke variabel `totalUserError` dan `totalUserInfo`. Lalu, untuk menghitung jumlah user dan error tiap usernya, bisa menggunakan command `grep` dengan option `--count` yang akan menghitung setiap keyword yang muncul per baris dalam hal ini `$users`. Terakhir, hasilnya dimasukkan ke "<i>user_statistic.csv</i>".
 
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

- <b>JAWABAN</b>

  Pada soal ini digunakan AWK dalam penyelesaiannya.
  ```
  BEGIN {
    maxID = 0;
    max = 0;
  }
  ```
  Pertama kita menginisialisasi variabel untuk menjalankan program. `maxID` untuk menyimpan nilai maksimum <i>RowID</i> dan `max` untuk menyimpan nilai <i>profit percentage</i> terbesar.
  
  Lalu, pada bagian <i>main</i>-nya, terdapat command berikut:
  ```
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
  ```
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
  ```
  BEGIN {
    printf "Daftar nama customer di Albuquerque pada tahun 2017 antara lain: \n";
  }
  ```
  Pertama kita mengeluarkan output yang sesuai dengan permintaan soal.
  
  Lalu, pada bagian <i>main</i>-nya, terdapat command berikut:
  ```
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
  ```
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
  ```
  BEGIN {
    homeOffice = 0;
    consumer = 0;
    corporate = 0;
  }
  ```
  Pertama kita menginisialisasi variabel untuk menjalankan program. `homeOffice` untuk menyimpan nilai kemunculan <i>Home Office</i>, `consumer` untuk menyimpan nilai kemunculan <i>Consumer</i>, dan `corporate` untuk menyimpan nilai kemunculan <i>Corporate</i>.
  
  Lalu, pada bagian <i>main</i>-nya, terdapat command berikut:
  ```
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
  ```
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
  ```
  BEGIN {
    central = 0;
    east = 0;
    south = 0;
    west = 0;
  }
  ```
  Pertama kita menginisialisasi variabel untuk menjalankan program. `central` untuk menyimpan nilai kemunculan <i>Central</i>, `east` untuk menyimpan nilai kemunculan <i>East</i>, `south` untuk menyimpan nilai kemunculan <i>South</i>, dan `west` untuk menyimpan nilai kemunculan <i>West</i>.
  
  Lalu, pada bagian <i>main</i>-nya, terdapat command berikut:
  ```
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
   Kemudian membuat inisial variabel agar lebih mudah dalam pembacaan kode, dengan `region = $13` dan `profit = $21`. Pada pengondisian `NR atau <i>Number of Row</i> != 1` maksudnya adalah agar bagian paling atas data (<i>header</i>) sendiri tidak di-<i>passing</i>. Lalu, ditambahkan kondisi untuk menghitung nilai kemunculan tiap-tiap regionnya, jika `region == "Central"`, variabel `central` akan ditambah nilai variabel `profit`, jika `region == "East"`, variabel `east` akan ditambah nilai variabel `profit`, jika `region == "South"`, variabel `south` akan ditambah nilai variabel `profit`, dan jika `region == "West"`, variabel `west` akan ditambah nilai variabel `profit`.
   
   Pada akhir script nomor 2C bagian END:
  ```
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
  ```
  Laporan-TokoShiSop.tsv >> hasil.txt
  ```
  Agar hasilnya dimasukkan ke dalam "<i>hasil.txt</i>".
  
## SOAL 3 ##
  
Kuuhaku adalah orang yang sangat suka mengoleksi foto-foto digital, namun Kuuhaku juga merupakan seorang yang pemalas sehingga ia tidak ingin repot-repot mencari foto, selain itu ia juga seorang pemalu, sehingga ia tidak ingin ada orang yang melihat koleksinya tersebut, sayangnya ia memiliki teman bernama Steven yang memiliki rasa kepo yang luar biasa. Kuuhaku pun memiliki ide agar Steven tidak bisa melihat koleksinya, serta untuk mempermudah hidupnya, yaitu dengan meminta bantuan kalian. Idenya adalah :
  
 ### 3A ###
  
- <b>SOAL</B>
  
  Membuat script untuk <b>mengunduh</b> 23 gambar dari "https://loremflickr.com/320/240/kitten" serta <b>menyimpan</b> log-nya ke file "<i>Foto.log</i>". Karena gambar yang diunduh acak, ada kemungkinan gambar yang sama terunduh lebih dari sekali, oleh karena itu kalian harus <b>menghapus</b> gambar yang sama (tidak perlu mengunduh gambar lagi untuk menggantinya). Kemudian menyimpan gambar-gambar tersebut dengan nama "Koleksi_XX" dengan nomor yang berurutan <b>tanpa ada nomor yang hilang</b> (contoh : Koleksi_01, Koleksi_02, ...)
  
- <b>JAWABAN</B>
  
  ```
  max=23
  file=1
    for ((count=1;count<=max;count=count+1))
    do
      issame=0
      wget "https://loremflickr.com/320/240/kitten" -a Foto.log -O kitten
  ```
  Pertama melooping untuk mendownload file dari url yang diinginkan dengan mendeklarasikan variabel `max` sebagai batas jumlah file yang akan didownload. kemudian variabel `file` digunakan sebagai index untuk setiap file yang didownload. dan juga di awal looping dideklarasikan variabel `issame` sebagai penanda untuk file yang akan dicek sama tidaknya. untuk mendownload file digunakan `wget` dan juga ditambahkan command `-a` untuk menyimpan log ke `Foto.log` dan juga `-O` untuk rename file menjadi kitten agar mudah untuk melakukan pengecekan dan merename.
  
  ```
  if [ $count -eq 1 ]
   then
     mv kitten `printf "Koleksi_%02d" "$file"`
     file=$(($file+1)) 
   fi
  ```
  Kemudian didalam loop sebelum melakukan looping untuk melakukan pengecekan kesamaan file, untuk file yang pertama kali di download langsung di rename dengan menggunakan `printf "Koleksi_%02d" "$file"` agar mendapatkan format penamaan file (01,02,...dst) dan juga karena untuk file yang pertama tidak ada file lain untuk di compare. Setelah dilakukan rename maka variabel `file` akan diincrement.
  
  ```
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
   Kemudian dilakukan looping baru didalam looping yang sebelumnya untuk mengecek kesamaan setiap file, namun sebelum itu di cek apabila index untuk looping pertama masih di 1 maka akan langsung keluar dari looping kedua. Dalam looping kedua yang dilakukan pertama yaitu mendeklarasikan variabel `nama` untuk nama filenya dengan index looping kedua. kemudian di deklarasikan pula variabel `sama` untuk menyimpan informasi yang dihasilkan dari hasil `cmp`. `cmp` merupakan syntax untuk membandingkan 2 buah file berdasarkan bytenya sehingga apabila ada 2 file yang sama maka akan menghasilkan output NULL. Kemudian setelah itu dilakukan pengecekkan dengan menggunakan perintah `-z` untuk membandingkan apabila variabel `sama` menghasilkan null atau tidak. Apabila menghasilkan null maka variabel `issame` akan sama dengan 1 untuk menandakan bahwa file yang sedang dicek merupakan file yang sama oleh karena itu maka loop akan di break dan program akan melaksanakan perintah selanjutnya diluar loop kedua. namun apabila file tidak sama maka akan terus dilakukan pengecakan antar file sampai batas looping.
   
   ```
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
  Lalu diluar looping kedua yang digunakan syntax `if [ $count -gt 1 ]` untuk menghindari file pertama karena tidak ada perbandingan. kemudian apabila bukan file yang pertama akan dicek variabel `issame` apabila berisi satu yang menandakan file nya sama maka akan digunakan perintah `rm` untuk meremove file kemudian melanjutkan looping pertama, dan apabila variabel `issame` berisi 0 maka file yang sekarang bernama kitten akan di rename dengan menggunakan perintah `mv` menjadi nama file sesuai format dan kemudian variabel `file` akan diincrement dan looping untuk mendownload file dan mengecek kesamaannya akan dilanjutkan hingga batas max yaitu 23.
  
    [![ss-output-no-3a.png](https://i.postimg.cc/jSWx4D40/ss-output-no-3a.png)](https://postimg.cc/qNTHkMFj)
  
    Ini merupakan output dari soal no 3A. disini bisa dilihat jumlah foto yang di download tidak sesuai dengan jumlah yang ditentukan disoal. Ini dikarenakan di dalam script ada algoritma untuk memfilter file yang memiliki duplikat dan tidak perlu mendownload lagi file tersebut sehingga jumlah file yang ada sekarang merupakan jumlah file yang sudah selesai di remove file yang memiliki duplikat.
  
  Untuk soal no 3A hambatan yang dialami yaitu error ketika merename nama file karena saat merename file yang pertama di download tidak ikut terename namun bisa diselesaikan dengan mengecualikan file pertama di dalam looping. kemudian hambatan yang lainnya yaitu disaat harus remove dan rename nama filenya karena di awal ada banyak penamaannya yang berantakan sehingga sulit untuk mengetahui indexing filenya, namun hal tersebut bisa diatasi dengan menambahkan variabel file untuk indexingnya. Lalu hambatan yang trakhir yaitu untuk memfilter file duplikat karena isi looping kedua yang berantakan sehingga indexing untuk comparenya kurang pas, hal ini dapat diatasi dengan merapihkan kondisi looping kedua dan menambah variabel `file`
      
 ### 3B ###
  
- <b>SOAL</B>
  
  Karena Kuuhaku malas untuk menjalankan script tersebut secara manual, ia juga meminta kalian untuk menjalankan script tersebut <b>sehari sekali pada jam 8 malam</b> untuk tanggal-tanggal tertentu setiap bulan, yaitu dari <b>tanggal 1 tujuh hari sekali</b> (1,8,...), serta dari <b>tanggal 2 empat hari sekali</b> (2,6,...). Supaya lebih rapi, gambar yang telah diunduh beserta <b>log-nya, dipindahkan ke folder</b> dengan nama <b>tanggal unduhnya</b> dengan <b>format</b> "DD-MM-YYYY" (contoh : "13-03-2023").
  
### 3C ###
  
- <b>SOAL</B>
  
  Agar Kuuhaku tidak bosan dengan gambar anak kucing, ia juga memintamu untuk <b>mengunduh</b> gambar kelinci dari "https://loremflickr.com/320/240/bunny". Kuuhaku memintamu mengunduh gambar kucing dan kelinci secara bergantian (yang pertama bebas. contoh : tanggal 30 kucing > tanggal 31 kelinci > tanggal 1 kucing > ... ). Untuk membedakan folder yang berisi gambar kucing dan gambar kelinci, <b>nama folder diberi awalan</b> "Kucing_" atau "Kelinci_" (contoh : "Kucing_13-03-2023").
  
### 3D ###
  
- <b>SOAL</B>
  
  Untuk mengamankan koleksi Foto dari Steven, Kuuhaku memintamu untuk membuat script yang akan <b>memindahkan seluruh folder ke zip</b> yang diberi nama “Koleksi.zip” dan <b>mengunci</b> zip tersebut dengan <b>password</b> berupa tanggal saat ini dengan format "MMDDYYYY" (contoh : “03032003”).
 
 ### 3E ###
  
- <b>SOAL</B>
  
  Karena Kuuhaku hanya bertemu Steven pada saat kuliah saja, yaitu setiap hari kecuali Sabtu dan Minggu, dari jam 7 pagi sampai 6 sore, ia memintamu untuk membuat koleksinya <b>ter-zip</b> saat kuliah saja, selain dari waktu yang disebutkan, ia ingin koleksinya <b>ter-unzip</b> dan <b>tidak ada file zip</b> sama sekali.
