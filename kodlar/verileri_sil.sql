-- 1. Takvim_Bildirimler tablosunu temizle
DELETE FROM SaglikSistemi.Takvim_Bildirimler;

-- 2. Bildirim_Durum tablosunu temizle
DELETE FROM SaglikSistemi.Bildirim_Durum;

-- 3. Ýlaç_Kullanýmý tablosunu temizle
DELETE FROM SaglikSistemi.Ýlaç_Kullanýmý;

-- 4. Ýlaçlar tablosunu temizle
DELETE FROM SaglikSistemi.Ýlaçlar;

-- 5. Saglik_Profesyoneli_Hasta tablosunu temizle
DELETE FROM SaglikSistemi.Saglik_Profesyoneli_Hasta;

-- 6. Saðlýk_Profesyoneli tablosunu temizle
DELETE FROM KullaniciYonetimi.Saðlýk_Profesyoneli;

-- 7. Hasta tablosunu temizle
DELETE FROM SaglikSistemi.Hasta;

-- 8. Hasta_Yakýný tablosunu temizle
DELETE FROM KullaniciYonetimi.Hasta_Yakýný;

-- 9. Kullanýcýlar tablosunu temizle
DELETE FROM KullaniciYonetimi.Kullanýcýlar;


-- Kullanýcýlar tablosunun ID'sini sýfýrla
DBCC CHECKIDENT ('KullaniciYonetimi.Kullanýcýlar', RESEED, 0);

-- Hasta tablosunun ID'sini sýfýrla
DBCC CHECKIDENT ('SaglikSistemi.Hasta', RESEED, 0);

-- Hasta Yakýný tablosunun ID'sini sýfýrla
DBCC CHECKIDENT ('KullaniciYonetimi.Hasta_Yakýný', RESEED, 0);

-- Saðlýk Profesyoneli tablosunun ID'sini sýfýrla
DBCC CHECKIDENT ('KullaniciYonetimi.Saðlýk_Profesyoneli', RESEED, 0);

-- Ýlaçlar tablosunun ID'sini sýfýrla
DBCC CHECKIDENT ('SaglikSistemi.Ýlaçlar', RESEED, 0);

-- Ýlaç Kullanýmý tablosunun ID'sini sýfýrla
DBCC CHECKIDENT ('SaglikSistemi.Ýlaç_Kullanýmý', RESEED, 0);

-- Takvim Bildirimler tablosunun ID'sini sýfýrla
DBCC CHECKIDENT ('SaglikSistemi.Takvim_Bildirimler', RESEED, 0);

-- Bildirim Durum tablosunun ID'sini sýfýrla
DBCC CHECKIDENT ('SaglikSistemi.Bildirim_Durum', RESEED, 0);

-- Saðlýk Profesyoneli Hasta tablosunun ID'sini sýfýrla
DBCC CHECKIDENT ('SaglikSistemi.Saglik_Profesyoneli_Hasta', RESEED, 0);

