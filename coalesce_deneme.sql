CREATE TABLE d_insan (
ssn CHAR(9), /*-- Social Security Number--*/
isim VARCHAR(50), 	adres VARCHAR(50) );
INSERT INTO d_insan VALUES('123456789', 'Ali Can', 'Istanbul');
INSERT INTO d_insan VALUES('234567890', 'Veli Cem', 'Ankara');
INSERT INTO d_insan VALUES('345678901', 'Mine Bulut', 'Izmir');
INSERT INTO d_insan (ssn, adres) VALUES('456789012', 'Bursa');
INSERT INTO d_insan (ssn, adres) VALUES('567890123', 'Denizli');
INSERT INTO d_insan (adres) VALUES('Sakarya');
INSERT INTO d_insan (ssn) VALUES('999111222');
select * from d_insan

-- ismi null olanları sorgula
select * from d_insan where isim is null
-- ismi null olmayanları sorgula
select * from d_insan where isim is not null
-- ismi null olanlara no name atayın
update d_insan set isim = null where isim = 'Henuz isim Girilmedi'
update d_insan
set isim =coalesce (isim,'Yeni');
/* 
isim 'i NULL olanlara 'Henuz isim girilmedi'
adres 'i NULL olanlara 'Henuz adres girilmedi'
ssn 'i NULL olanlara ' no ssn' atayalım.
*/
update d_insan
set isim =coalesce (isim,'Henuz isim Girilmedi'),
adres= coalesce (adres,'Henuz adres Girilmedi'),
ssn= coalesce (ssn,'No ssn');



