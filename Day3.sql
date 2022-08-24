CREATE TABLE calisanlar
(
id CHAR(5) PRIMARY KEY, -- not null + unique
isim VARCHAR(50) UNIQUE,
maas int Not null,
ise_baslama DATE
);
INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14'); -- Unque Hatası Aynı isim var
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); --  Not Null Hatası
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -- -- Unque Hatası Aynı isim var
--INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); --  Not Null Hatası
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
--INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); -- Primary aynı oldugundan ustekıyle
--INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); --Primary'in aynısından yukarda oldugundan
--INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- primary key null kabul etmez


-- FOREIGN KEY--
CREATE TABLE adresler
(
adres_id char(5) ,
sokak varchar(20),
cadde varchar(30),
sehir varchar(20),
CONSTRAINT fk FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
select * from adresler;
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');
--Parent tabloda olmayan id ile child tabloya ekleme yapamayız
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
--Calısanlar id ile adresler tablosundaki adres_id ile eşlesenlere bakmak için
select * from calisanlar,adresler WHERE calisanlar.id = adresler.adres_id;
DROP table calisanlar
--Parant tabloyu yani primary key olan tabloyu silmek istediğimizde tabloyu silmez
--Önce child tabloyu silmemiz gerekir
delete from calisanlar where id='10002'; -- parent 
delete from adresler where adres_id='10002'; --child
select * from calisanlar;
select * from adresler;
delete from adresler where adres_id='10003';

-- ON DELETE CASCADE --
--Her defasında önce child tablodaki verileri silmek yerine
--ON DELETE CASCADE silme özelliğini aktif hale getirebiliriz
--Bunun için FK olan satırın en sonuna ON DELETE CASCADE komutunu yazmamız yeterli

CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

CREATE TABLE notlar(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
on delete cascade
);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

select * from talebeler;
select * from notlar

delete from notlar where talebe_id='123';
delete from talebeler where id='126'; -- ON DELETE CASCADE kullandıgımız icin PARENT table dan direk silebildik
-- Parent table dan sildigimiz icin Child table dan da silinmis olur.
delete from talebeler;

DROP table talebeler cascade ; -- Parent tabloyu kaldırmak istersek DROP table tablo_adindan sonra "cascade" komutu kullanilir.
--Talebeler tablosundaki isim sutununa NOT NULL kısıtlaması ekleyiniz ve veri tipini VARCHAR(30) olarak degitiriniz.
alter table talebeler
alter column isim type varchar(30),
alter column isim set not null;

-- Talebeler tablosundaki yazili kısmına 60 dan buyuk rakam girilebilsin.
alter table talebeler 
add constraint SINIR check(yazili_notu>60);

INSERT INTO talebeler VALUES(129, 'Mustafa', 'Cansiz',45); -- Not 60 dan kucuk oldugu icin eklemedi
select * from talebeler;

create table ogrenciler(
id int,
isim varchar(45),
adres varchar(100),
sinav_notu int
);

Create table ogrenci_adres
AS
SELECT id, adres from ogrenciler;

select * from ogrenciler
select * from ogrenci_adres

-- Tablodaki bir sutuna primary key ekleme
alter table ogrenciler
add primary key (id);

-- primary key olusturmada 2.yol
alter table ogrenciler
add constraint pk_id2 primary key (id); 

-- primary key den sonra foriegn key atayacagız
alter table ogrenci_adres
add foreign key (id) references ogrenciler;

--fk yı constraint silme
alter table ogrenci_adres drop constraint ogrenci_adres_id_fkey;
-- Sinav notu 85 ten buyuk olan talebe bilgilerini getirin
select * from talebeler where yazili_notu>85;

-- ismi MUStafa bak olan ogrenci bilgileri
select * from talebeler where isim='Mustafa Bak'

select * from talebeler;

-- SELECT komutunda BETWEEN kosulu
-- BETWEEN belirttiginiz iki veri arasindaki bilgileri listeler
-- BETWEEN de belirttigimiz degerlerde listelemeye dahildir

create table personel
(
id char(4),
isim varchar(50),
maas int
);

insert into personel values('1001', 'Ali Can', 70000);
insert into personel values('1002', 'Veli Mert', 85000);
insert into personel values('1003', 'Ayşe Tan', 65000);
insert into personel values('1004', 'Derya Soylu', 95000);
insert into personel values('1005', 'Yavuz Bal', 80000);
insert into personel values('1006', 'Sena Beyaz', 100000);

select * from personel

/*
    AND (ve): Belirtilen şartların her ikiside gerçekleşiyorsa o kayıt listelenir
	Bir tanesi gerçekleşmezse listelemez
    Select * from matematik sinav1 > 50 AND sınav2 > 50
	Hem sınav1 hemde sınav2 alanı, 50'den büyük olan kayıtları listeler
    OR (VEYA): Belirtilen şartlardan biri gerçekleşirse, kayıt listelenir
    select * From matematik sınav>50 OR sınav2>50 
	Hem sınav1 veya sınav2 alanı, 50 den büyük olan kayıtları listeler    
*/

-- id'si 1003 ile 1005 arasinda olan personel bilgisini listeleyiniz
select * from personel where id between '1003' and '1005' ;

--2.Yol
select * from personel where id >='1003' and id<='1005';

-- Derya soylu ile yavuz bal arasındaki personel bilgisini listeleyiniz
select * from personel where isim between 'Derya Soylu' and 'Yavuz Bal' ;

-- maasi 70000 ve ismi sena olan personelleri listele
select * from personel where isim='Sena Beyaz' or maas= 70000;

-- IN : Birden fazla mantıksal ifade ile tanımlayacagımız durumları tek komutta yazabilme imkanı verir.
-- Farklı sutunlar icin IN kullanılamaz

-- id si 1001, 1002 ve 1004 olan personelin bilgilerini listele
select * from personel where id = '1001' or id= '1002' or id= '1004';

-- 2.Yol
SELECT * FROM personel where id in ('1001', '1002', '1004');

-- Maaşı sadece 70000, 100000 olan personeli listele
select * from personel where maas in(70000,100000);

/*
SELECT - LIKE koşulu
LIKE : Sorgulama yaparken belirli kalıp ifadeleri kullanabilmemizi sağlar
ILIKE : Sorgulama yaparken büyük/küçük harfe duyarsız olarak eşleştirir
LIKE : ~~
ILIKE : ~~*
NOT LIKE : !~~
NOT ILIKE :!~~*
% --> 0 veya daha fazla karakteri belirtir.
_ --> Tek bir karakteri belirtir
*/

-- Ismi A harfi ile baslayan personeli listele
SELECT * FROM personel WHERE isim like 'A%';

-- Ismi t harfi ile biten personeli listele
SELECT * FROM personel WHERE isim like '%t';

-- Isminin 2. harfi e olan personeli listeleyiniz
select * from personel where isim like '_e%'




