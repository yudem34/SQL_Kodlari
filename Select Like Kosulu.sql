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
select * from personel;
-- 'a' ile başlayıp 'n' ile biten personel isimlerini listeleyiniz
select * from personel where isim ~~* 'a%n'

-- 'a' ile başlayıp 'n' ile biten personel isimlerini listeleyiniz
select * from personel where isim ilike '_a_u%'

select * from personel where isim ilike '%e%' and isim ilike '%r%'

-- 2. harfi e olup diğer harflerinde y olan personeli listeleyiniz
select * from personel WHERE isim like '_e%y%'

-- a harfi olmayan personeli listeleyiniz
select * from personel WHERE isim not ilike '%a%'

-- 1. harfi A ve 7. harfi a olan personeli listeleyin
select * from personel WHERE isim ilike 'A_____a%'

--Sondan ikinci karakteri 'r' olan "isim" değerlerini listeleyiniz.
select * from personel WHERE isim like '%r_'

