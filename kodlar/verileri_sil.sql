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

-- 7. Hasta tablosunu temizle
DELETE FROM SaglikSistemi.Hasta;

-- 8. Hasta_Yak�n� tablosunu temizle
DELETE FROM KullaniciYonetimi.Hasta_Yak�n�;

-- 9. Kullan�c�lar tablosunu temizle
DELETE FROM KullaniciYonetimi.Kullan�c�lar;


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

