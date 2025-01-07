--Tablolar� silerken, ili�kisel veritabanlar�nda yabanc� anahtar ba��ml�l�klar� nedeniyle bir tablonun
--ba�ka bir tabloya ba��ml� oldu�unu g�z �n�nde bulundurarak bir s�ralama yap�lmal�d�r.
--Tablolar, en az ba��ml� olanlardan (yabanc� anahtara sahip olmayanlar) ba�layarak silinmelidir.

delete from SaglikSistemi.�la�_Kullan�m�_Bildirim;

-- 1. Takvim_Bildirimler tablosunu temizle
DELETE FROM SaglikSistemi.Takvim_Bildirimler;

-- 2. Bildirim_Durum tablosunu temizle
DELETE FROM SaglikSistemi.Bildirim_Durum;

-- 3. �la�_Kullan�m� tablosunu temizle
DELETE FROM SaglikSistemi.�la�_Kullan�m�;

-- 4. �la�lar tablosunu temizle
DELETE FROM SaglikSistemi.�la�lar;

-- 5. Saglik_Profesyoneli_Hasta tablosunu temizle
DELETE FROM SaglikSistemi.Saglik_Profesyoneli_Hasta;

-- 6. Sa�l�k_Profesyoneli tablosunu temizle
DELETE FROM KullaniciYonetimi.Sa�l�k_Profesyoneli;

-- 8. Hasta_Yak�n� tablosunu temizle
DELETE FROM KullaniciYonetimi.Hasta_Yak�n�;

-- 7. Hasta tablosunu temizle
DELETE FROM SaglikSistemi.Hasta;

-- 9. Kullan�c�lar tablosunu temizle
DELETE FROM KullaniciYonetimi.Kullan�c�lar;

---tablolardaki verileri silsek bile idler s�f�rlanmaz.
---�ak��ma olmamas� i�in �nemlidir. fakat kontrol alt�nda ise id ler �u �ekilde s�f�rlanabilir:

-- Kullan�c�lar tablosunun ID'sini s�f�rla
DBCC CHECKIDENT ('KullaniciYonetimi.Kullan�c�lar', RESEED, 0);

-- Hasta tablosunun ID'sini s�f�rla
DBCC CHECKIDENT ('SaglikSistemi.Hasta', RESEED, 0);

-- Hasta Yak�n� tablosunun ID'sini s�f�rla
DBCC CHECKIDENT ('KullaniciYonetimi.Hasta_Yak�n�', RESEED, 0);

-- Sa�l�k Profesyoneli tablosunun ID'sini s�f�rla
DBCC CHECKIDENT ('KullaniciYonetimi.Sa�l�k_Profesyoneli', RESEED, 0);

-- �la�lar tablosunun ID'sini s�f�rla
DBCC CHECKIDENT ('SaglikSistemi.�la�lar', RESEED, 0);

-- �la� Kullan�m� tablosunun ID'sini s�f�rla
DBCC CHECKIDENT ('SaglikSistemi.�la�_Kullan�m�', RESEED, 0);

-- Takvim Bildirimler tablosunun ID'sini s�f�rla
DBCC CHECKIDENT ('SaglikSistemi.Takvim_Bildirimler', RESEED, 0);

-- Bildirim Durum tablosunun ID'sini s�f�rla
DBCC CHECKIDENT ('SaglikSistemi.Bildirim_Durum', RESEED, 0);

-- Sa�l�k Profesyoneli Hasta tablosunun ID'sini s�f�rla
DBCC CHECKIDENT ('SaglikSistemi.Saglik_Profesyoneli_Hasta', RESEED, 0);

DBCC CHECKIDENT ('SaglikSistemi.�la�_Kullan�m�_Bildirim', RESEED, 0);

---tablolar komple bu �ekilde silinir:
---yine hiyerar�iye dikkat edilerek yap�l�r bu i�lem de.

-- Ara tablodan ba�l�yoruz
DROP TABLE IF EXISTS SaglikSistemi.�la�_Kullan�m�_Bildirim;

-- Daha sonra ba��ml�l��� olan di�er tablolar� siliyoruz
DROP TABLE IF EXISTS SaglikSistemi.Takvim_Bildirimler;
DROP TABLE IF EXISTS SaglikSistemi.Bildirim_Durum;

-- Sa�l�k sistemine ba�l� tablolar
DROP TABLE IF EXISTS SaglikSistemi.Saglik_Profesyoneli_Hasta;
DROP TABLE IF EXISTS SaglikSistemi.�la�_Kullan�m�;
DROP TABLE IF EXISTS SaglikSistemi.�la�lar;

-- Kullan�c� y�netimi ile ili�kili tablolar
DROP TABLE IF EXISTS KullaniciYonetimi.Hasta_Yak�n�;
DROP TABLE IF EXISTS KullaniciYonetimi.Sa�l�k_Profesyoneli;

-- Hasta ve kullan�c� tablosu en son silinir
DROP TABLE IF EXISTS SaglikSistemi.Hasta;
DROP TABLE IF EXISTS KullaniciYonetimi.Kullan�c�lar;
