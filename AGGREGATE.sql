-- AGGREGATE METHOD KULLANIMI --
/*
-Aggregate Methodları (SUM(Topla),COUNT(Say),MIN(EN küçük değer),MAX(En büyük değer),AVG(Ortalama))
-Subquery içinde de kullanılır
-ANcak, sorgu tek bir değer döndürüyor olmalıdır
SYNTAX: sum() şeklinde olmalı sum () arasında boşluk olmamalı
*/

CREATE TABLE calisanlar2
(
id int,
isim VARCHAR(50),
sehir VARCHAR(50),
maas int,
isyeri VARCHAR(20)
);
INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

select * from calisanlar2

-- Çalışanlar2 tablosunda en çokk maaş alanın maaşını getir.
select max(maas) from calisanlar2

-- Çalışanlar2 tablosundaki maaslarin toplamini getir.
select sum(maas) from calisanlar2

-- Çalışanlar2 tablosundaki maaslarin ortalamasını getir.
select avg(maas) from calisanlar2
SELECT round(avg(maas)) from calisanlar2
SELECT round(avg(maas),2) from calisanlar2

-- Çalışanlar2 tablosunda en dusuk maaş alanın maaşını getir.
select min(maas) from calisanlar2

-- Çalışanlar2 tablosundan kac kisinin maas aldıgını getir
select count(maas) from calisanlar2

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
select * from markalar
select marka_isim,calisan_sayisi,(select sum(maas) from calisanlar2 where marka_isim=isyeri) AS toplam_maas from markalar

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.
select marka_isim,calisan_sayisi,(select max(maas) from calisanlar2 where marka_isim=isyeri)as max_maas,(select min(maas) from calisanlar2 where marka_isim=isyeri)as min_maas from markalar
select marka_isim,calisan_sayisi,(select (max(maas),min(maas)) from calisanlar2 where marka_isim=isyeri) as max___min from markalar

--Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.
select marka_id, marka_isim, (select count(sehir) from calisanlar2 where marka_isim=isyeri) as sehirler from markalar

--Interview Question: En yüksek ikinci maas değerini çağırın.
select max(maas) as en_yuksek_ikinci_maas from calisanlar2
where maas <(select max(maas) from calisanlar2)

--Interview Question: En dusuk ikinci maas değerini çağırın.
select min(maas) as endusuk_ikinci_maas from calisanlar2
where maas > (select min(maas) from calisanlar2);

--En yüksek üçüncü maas değerini bulun
select max(maas) as enyuksek3maas from calisanlar2 where maas
< (select max(maas) as enyuksekikincimaas from calisanlar2 where maas < (select max(maas)from calisanlar2)
)


