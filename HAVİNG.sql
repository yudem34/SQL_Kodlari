/*
-- GROUP BY -- HAVİNG --
HAVING ifadesinin işlevi WHERE ifadesininkine çok benziyor. Ancak kümeleme fonksiyonları ile
WHERE ifadesi birlikte kullanılmadığında HAVING ifadesine ihtiyac duyulmuştur
GROUP BY ile kullanılır gruplamadan sonraki şart için group by dan sonra HAVING kullanılır
*/

--Maaş ortalaması 3000’den fazla olan ülkelerdeki erkek çalışanların maaş ortalaması.
select ulke,round(avg(maas),2) from personel
where cinsiyet = 'E'
group by ulke
having avg(maas) >3000

select ulke,round(avg(maas),2)as maas_ortalamasi from personel
where cinsiyet='E'and maas>3000
group by ulke
