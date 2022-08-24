--Personel tablosu olusturalim
create table personel(
personel_id int,
isim varchar(30),
sehir varchar(30),
maas int,
sirket varchar(20),
adres varchar(50)
);
--Varolan personel tablosundan personel_id,sehir,adres fieldlarina sahip personel_adres adinda yeni bir tablo olusturalim
create table personel_adres
as
select personel_id,sehir,adres from personel;
select * from personel;
--DML --> Data Manipulation Language
--INSERT, UPDATE, DELETE
--Tabloya veri ekleme, tablodan veri guncelleme ve silme islemlerinde kullanilan komutlar
create table student
(
id varchar(4),
st_name varchar(30),
age int
);
insert into student VALUES ('1001','Yusuf Demir',32);
insert into student VALUES ('1002','Ali Yilmaz',25);
insert into student VALUES ('1003','Canan Durmaz',32);
insert into student VALUES ('1004','Ayse Demir',29);
--Tabloya parcali veri ekleme
insert into student (st_name,age) values ('Murat Can',55);
select * from student;
select st_name from student;
--Select Komutu ile Where Kosulu
select * from student where age>25;

--TCL - Transaction Control Lang.
--Begin - Savepoint - rollback - commit
--Transection veritabani sistemlerinde bir islem basladiginda baslar ve islem bitince sona erer
--Bu islemler veritabani olusturma, veri silme, veri guncelleme veriyi geri getirme gibi islemler olabilir.
CREATE TABLE ogrenciler2
(
id serial,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real
);
Begin;
insert into ogrenciler2 values (default,'Ali Can','Kemal',75.5);
insert into ogrenciler2 values (default,'Canan','Adem',90.5);
savepoint x;
insert into ogrenciler2 values (default,'Melisa','Ayse',95.5);
insert into ogrenciler2 values (default,'Mehmet','Aynur',65.5);
rollback to x;
select*from ogrenciler2  
commit; 
--Transaction kullanımında SERIAL data türü kullanımı tavsiye edilmez.
--savepointten sonra eklediğimiz veride sayaç mantığı ile çalıştığı için
--sayacta en son hangi sayıda kaldıysa ordan devam eder
-- NOT : PostgreSQL de transaction kullanımı için 'Begin' komutuyla başlarız sonrasında tekrar yanlış bir veriyi
-- düzeltmek veya bizim için önemli olan verilerden sonra ekleme yapabilmek için 'SAVEPOINT savepointadi'
-- kullanırız ve bu savepointe dönebilmek için 'ROLLBACK TO savepointismi'
-- komutunu kullanırız ve rollback çalıştırıldığında savepoint yazdığımız satırın üstündeki verileri tabloda bize
-- verir ve son olarak Transaction'ı sonlandırmak için mutlaka 'COMMIT' komutu kullanırız. MySQL de
-- transaction olmadanda kullanılır

-- DML - DELETE -
-- DELETE FROM tablo-adi --> Tablonun tüm icerigini siler
-- Veriyi secerek silmek icin "Where" kosulu kullanilir
-- DELETE FROM tablo_adi Where sutun_adi = veri --> Tablodaki istedigimiz veriyi siler

CREATE TABLE ogrenciler
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO ogrenciler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Ali', 99);

select * from ogrenciler;

--Soru : id si 124 olan ogrenciyi silin
delete from ogrenciler where id=124;
--Soru 2 : ismi kemal yasa olan satiri siliniz
delete from ogrenciler where isim='Kemal Yasa';
--Soru : ismi nesibe yilmaz veya mustafa bak olan kayıtları silelim
delete from ogrenciler where isim='Nesibe Yilmaz' or isim='Mustafa Bak';
--Soru : ismi Ali Can ve id'si 123 olan kaydi siliniz
delete from ogrenciler where isim='Ali Can' or id=123;

--Tablodaki tum verileri silelim
Delete from ogrenciler;

--DELETE - TRUNCATE -- 
-- TRUNCATE komutu DELETE komutu gibi bir tablodaki verilerin tamamını siler.
-- Ancak, seçmeli silme yapamaz

select * from ogrenciler;
TRUNCATE TABLE ogrenciler;

--DDL - Data Definition Lang.
-- Create - Alter - Drop
-- Alter Table -- 
-- "Alter Table" tabloda ADD, TYPE, SET, RENAME veya DROP columns islemleri icin kullanilir
-- Soru : Personel tablosuna "cinsiyet Varchar(20)" ve "yas int" seklinde yeni kısımlar ekleyiniz
select * from personel;
alter table personel add cinsiyet Varchar(20), add yas int;

-- Personel tablosundan sirket field'ini siliniz
alter table personel drop column sirket;

-- Personel tablosundaki sehir sutununun adini ulke olarak degistirelim
alter table personel rename column sehir to ulke; 

-- Personel Tablosunun adini isciler olarak degistirelim
alter table personel rename to isciler;

-- Tekrar Personel yapmak icin;
alter table isciler rename to personel;

-- DDL - Drop komutu ile komple siliyoruz
drop table isciler;

-- Constraint -- Kısıtlamalar
-- Primar Key --> Bir sutunun NULL icermemesini ve sutundaki verilerin BENZERSİZ olmasini saglar(NOT NULL - UNIQUE)
-- Foregin Key --> Baska bir tablodaki Primary Key'i referans gostermek icin kullanilir
-- Boylelikle, tablolar arasinda iliski kurmus oluruz.
-- UNIQUE --> Bir sutundaki tum degerlerin BENZERSİZ yani tek olmasını saglar
-- NOT NULL --> Bir sutunun NULL icermemesini yani bos olmamasini saglar
-- NOT NULL kısıtlaması icin Constraint ismi tanımlanmaz.Bu kısıtlama turunden hemen sınra yerlestirilir
-- Check --> Bir sutuna yerlestirilebilecek deger aralıgını sınırlamak ıcın kullanılır.

CREATE TABLE calisanlar
(
id CHAR(5) PRIMARY KEY, -- not null + unique
isim VARCHAR(50) UNIQUE,
maas int Not null,
ise_baslama DATE
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14'); -- Unque Hatası Aynı isim var
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); --  Not Null Hatası
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -- -- Unque Hatası Aynı isim var
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); --  Not Null Hatası
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); -- Primary aynı oldugundan ustekıyle
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); --Primary'in aynısından yukarda oldugundan
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- primary key null kabul etmez

select * from calisanlar;

-- ERROR:  current transaction is aborted, commands ignored until end of transaction block SQL state: 25P02
--Yukarıdakı hata da bos bır yere "commit" yazıyoruz

-- FOREIGN KEY --
create table adresler(
adres_id char(5),
sokak Varchar(20),
caddes varchar(30),
sehir varchar(20),
constraint id_fk foreign key (adres_id) references calisanlar(id) 
);

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
select*from adresler;
