#!/bin/bash

// SOAL 2A
awk -F "\t" '
BEGIN {
    maxID = 0;
    max = 0;
}

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

END {
    printf "Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %.2f%%.\n\n", maxID, max;
} ' Laporan-TokoShiSop.tsv >> hasil.txt

// SOAL 2B
awk -F "\t" '
BEGIN {
    printf "Daftar nama customer di Albuquerque pada tahun 2017 antara lain: \n";
}

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

END {
    for (nameArr in namesArr) {
        print nameArr;
    }
    printf "\n";

} ' Laporan-TokoShiSop.tsv >> hasil.txt

// SOAL 2C
awk -F "\t" '
BEGIN {
    homeOffice = 0;
    consumer = 0;
    corporate = 0;
}

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

// SOAL 2D
awk -F "\t" '
BEGIN {
    central = 0;
    east = 0;
    south = 0;
    west = 0;
}

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