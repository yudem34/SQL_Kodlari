-- Yeni Tablo Olusturma
-- Enson eklenecek olana virgul koymuyoruz.
create table "name"(
isim char(10),
yas int);

-- Tabloyu cagırmak
select * from tablo_adi;

-- Baska bir tablodan ozellik ekleyerek yeni tablo olusturma
create table "yeni_name"
AS
select isim,yas from "alınacak tablonun ismi";

-- Tablodaki istediğimiz veriyi "SİLMEK" icin;
delete from tablo_adı where sutun_adi = veri;

-- Tablodaki istediğimiz veriyi "EKLEMEK" icin;
insert into tablo_adi values (Tablodakiler);

-- Tabloya istediğimiz secenegi "EKLEMEK" icin;
alter table tablo_adi add "or; sehir char(15)";

-- Tablodaki tüm verileri silmek icin
Delete from tablo_adi;

-- Personel tablosuna cinsiyet Varchar(20) ve yas int seklinde yeni sutunlar ekleyiniz
alter table personel add cinsiyet varchar(20), add yas int;

--Personel tablosundan sirket field'ini siliniz
alter table personel drop column sirket;

-- Personel tablosundaki sehir sutununun adını ulke olarak değiştirelim
alter table personel RENAME column sehir to ulke;

-- Personel tablosunun adını isciler olarak değiştiriniz
alter table personel rename to isciler;


