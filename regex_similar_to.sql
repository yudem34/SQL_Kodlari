-- SELECT - SIMILAR TO - REGEX(Regular Expressions) --
/*
SIMILAR TO : Daha karmaşık pattern(kalıp) ile sorgulama işlemi için SIMILAR TO kullanılabilir.
Sadece PostgreSQL de kullanılır. Büyük Küçük harf önemlidir
REGEX : Herhangi bir kod, metin içerisinde istenen yazı veya kod parçasının aranıp bulunmasını sağlayan
kendine ait bir söz dizimi olan bir yapıdır.MySQL de(REGEXP_LİKE) olarak kullanılır
PostgreSQL'de "~" karakteri ile kullanılır.
*/
CREATE TABLE kelimeler
(
id int,
kelime VARCHAR(50),
harf_sayisi int
);

   INSERT INTO kelimeler VALUES (1001, 'hot', 3);
   INSERT INTO kelimeler VALUES (1002, 'hat', 3);
   INSERT INTO kelimeler VALUES (1003, 'hit', 3);
   INSERT INTO kelimeler VALUES (1004, 'hbt', 3);
   INSERT INTO kelimeler VALUES (1005, 'hct', 3);
   INSERT INTO kelimeler VALUES (1006, 'adem', 4);
   INSERT INTO kelimeler VALUES (1007, 'selim', 5);
   INSERT INTO kelimeler VALUES (1008, 'yusuf', 5);
   INSERT INTO kelimeler VALUES (1009, 'hip', 3);
   INSERT INTO kelimeler VALUES (1010, 'HOT', 3);
   INSERT INTO kelimeler VALUES (1011, 'hOt', 3);
   INSERT INTO kelimeler VALUES (1012, 'h9t', 3);
   INSERT INTO kelimeler VALUES (1013, 'hoot', 4);
   INSERT INTO kelimeler VALUES (1014, 'haaat', 5);
   INSERT INTO kelimeler VALUES (1015, 'hooooot', 5);
   INSERT INTO kelimeler VALUES (1016, 'booooot', 5);
   INSERT INTO kelimeler VALUES (1017, 'bolooot', 5);
   
select * from kelimeler;

--  İçerisinde 'ot' veya 'at' bulunan kelimeleri listeleyiniz
--similar to
select * from kelimeler where kelime similar to '%(at|ot)%'
--ilike
select * from kelimeler where kelime ilike '%at%' or kelime ilike '%ot%'
select * from kelimeler where kelime ~~* '%at%' or kelime ~~* '%ot%'
--regex
select * from kelimeler where kelime ~* 'ot' or kelime ~* 'at'
--regex2
select * from kelimeler where kelime ~* '[ao]t'

-- soru : 'ho' veya 'hi' ile başlayan kelimeleri listeleyeniz
--similar to
select * from kelimeler where kelime similar to '(ho|hi%)'
--ilike
select * from kelimeler where kelime ilike 'ho%' or kelime ilike 'hi%'
select * from kelimeler where kelime ~~* 'ho%' or kelime ~~* 'hi%'
--regex
select * from kelimeler where kelime ~* 'h[oi](.*)' -- ".(nokta) bir karakteri temsil eder"

--sonu t veya m ile bitenler
--similar to
select * from kelimeler where kelime similar to '(%t|%m)'
--ilike
select * from kelimeler where kelime ilike '%t' or kelime ilike '%m'
select * from kelimeler where kelime ~~* '%t' or kelime ~~* '%m'
--regex
select * from kelimeler where kelime ~* '(.*)[tm]$' -- $ karakteri bitişi gösterir

-h ile baslayan t ile biten 3 harfliler
--similar to
select * from kelimeler where kelime similar to '([hH][a-z,A-Z,0-9][tT])'
--ilike
select * from kelimeler where kelime ilike 'h_t' or kelime ilike 'h_t'
select * from kelimeler where kelime ~~* 'h_t' or kelime ~~* 'h_t'
--regex
select * from kelimeler where kelime ~* 'h[a-z,A-Z,0-9]t'

--İlk karakteri 'h', son karakteri 't' ve ikinci karakteri 'a'dan 'e'ye herhangi bir karakter olan
--“kelime" değerlerini çağırın.
select * from kelimeler where kelime similar to '([hH][a-e,A-E]%[tT])'
--ilike
--select * from kelimeler where kelime ilike 'h%[a-e]%t' or kelime ilike 'h%e%t'
--select * from kelimeler where kelime ~~* 'h_t' or kelime ~~* 'h_t'
--regex
select * from kelimeler where kelime ~* '[hH][a-e,A-E](.*)[tT]'

--ilk karakteri 's', 'a' veya 'y' olan "kelime" değerlerini çağırın.
select * from kelimeler where kelime ~* '^[say](.*)' --^ baslangıc degerini temsil eder

--son karakteri 'm', 'a' veya 'f' olan "kelime" değerlerini çağırın.
select * from kelimeler where kelime ~* '(.*)[maf]$'

--İlk harfi h, son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tüm bilgilerini sorgulayalım.
select * from kelimeler where kelime ~* '[h|H][a|i][t|T]'
--regex ile
select * from kelimeler where kelime ~ '^[hH][a|i][tT]$'

--İlk harfi 'b' dan ‘s' ye bir karakter olan ve ikinci harfi herhangi bir karakter olup üçüncü harfi ‘l' olan “kelime" değerlerini çağırın.
select * from kelimeler where kelime similar to '([b-s]_l%)'
select * from kelimeler where kelime ~* '[b-s][][l](.*)'

--içerisinde en az 2 adet oo barıdıran kelimelerin tüm bilgilerini listeleyiniz.
--regex
select * from kelimeler where kelime ~* '[o][o]'
--similar to
select * from kelimeler where kelime similar to '%[o][o]%'
select * from kelimeler where kelime similar to '%[o]{4}%'

select * from kelimeler where kelime similar to '%[o][o][o][o]%'

--'a', 's' yada 'y' ile başlayan VE 'm' yada 'f' ile biten "kelime" değerlerini çağırın.
select * from kelimeler where kelime ~* '[a|s|y](.*)[m]'
