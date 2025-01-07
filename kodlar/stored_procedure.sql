--Amaç
--Hastanýn ilaç kullanýmýný kaydetmek (baþlangýç ve bitiþ tarihleri ile birlikte).
--Oluþan kullaným için bildirimler oluþturmak (her gün için bildirim eklemek).
--Hatalý bir iþlemde tüm deðiþiklikleri geri almak (rollback).

---Hem ilaç kullanýmý hem de bildirim ekleme iþlemleri tek bir iþlemde yürütülür. Hata durumunda tüm deðiþiklikler geri alýnýr.
--- Ýþlemler modüler hale getirilir ve parametrelerle esnek bir yapý saðlanýr.
---Ýþlemin baþarýlý veya baþarýsýz olmasýna göre deðiþikliklerin durumu net bir þekilde yönetilir.

--DROP PROCEDURE AddMedicationAndNotification; --sql serverda bir procedureu silmeye yarayan komuttur.

CREATE PROCEDURE AddMedicationAndNotification 
    @HastaID INT,
    @IlacID INT,
    @BaslangicTarihi DATE,
    @BitisTarihi DATE,
    @KullanimSikligi NVARCHAR(50),
    @BildirimTarihi DATE
AS
BEGIN
    BEGIN TRY
        -- Tarih kontrolü
        IF @BaslangicTarihi > @BitisTarihi
        BEGIN
            THROW 50001, 'Baþlangýç tarihi bitiþ tarihinden sonra olamaz.', 1;
        END;

        -- Ýþlem baþlat
        BEGIN TRANSACTION;

        -- Ýlaç kullanýmý ekle
        INSERT INTO SaglikSistemi.Ýlaç_Kullanýmý 
            (Hasta_ID, Ýlaç_ID, Baþlangýç_Tarihi, Bitiþ_Tarihi, Kullaným_Sýklýðý, Son_Kullaným_Tarihi)
        VALUES (@HastaID, @IlacID, @BaslangicTarihi, @BitisTarihi, @KullanimSikligi, NULL);

        -- Yeni eklenen Kullaným_ID'yi al
        DECLARE @YeniKullanimID INT = SCOPE_IDENTITY();

        -- Takvim_Bildirimler tablosuna ekle
        INSERT INTO SaglikSistemi.Takvim_Bildirimler 
            ( Kullaným_Tarihi, Kullaným_Saati, Durum_ID)
        VALUES ( @BildirimTarihi, '08:00:00', 2);

        -- Yeni eklenen Bildirim_ID'yi al
        DECLARE @YeniBildirimID INT = SCOPE_IDENTITY();

        -- Ýlaç_Kullanýmý_Bildirim tablosuna ekle
        INSERT INTO SaglikSistemi.Ýlaç_Kullanýmý_Bildirim 
            (Kullaným_ID, Bildirim_ID)
        VALUES (@YeniKullanimID, @YeniBildirimID);

        -- Ýþlemi tamamla
        COMMIT TRANSACTION;

        PRINT 'Baþarýlý: Ýlaç kullanýmý ve bildirim eklendi.';
    END TRY
    BEGIN CATCH
        -- Ýþlem durumu kontrol et
        IF XACT_STATE() <> 0
        BEGIN
            ROLLBACK TRANSACTION;
        END;

        PRINT 'Hata: Ýþlem sýrasýnda bir hata oluþtu. Tüm deðiþiklikler geri alýndý.';
        PRINT ERROR_MESSAGE();
    END CATCH
END;


---baþarýlý senaryodur. çünkü procedure çalýþtýrýlmaya baþlandýðý anda baþ ve bit. tarihleri kontrol edilir
---baþ.tar<bit. tar. olduðundan hasta ile ilgili bilgiler ilaç kullanýmý, takvim bildirimler ve Ýlaç_Kullanýmý_Bildirimi
---tablolarina baþarýlý bir þekilde eklenir. 
EXEC AddMedicationAndNotification 
    @HastaID = 2,
    @IlacID = 2,
    @BaslangicTarihi = '2025-01-01',
    @BitisTarihi = '2025-03-01',
    @KullanimSikligi = 'Günde 3 kez',
    @BildirimTarihi = '2025-01-02';


---hatalý bir senaryodur.
---baþ tar>bit. tar. olduðundan procedure çalýþmaz hata verir. rollback ile iþlem geri alýnýr.
EXEC AddMedicationAndNotification 
    @HastaID = 1,
    @IlacID = 1,
    @BaslangicTarihi = '2025-01-01',
    @BitisTarihi = '2024-12-31', -- Hatalý
    @KullanimSikligi = 'Günde 3 kez',
    @BildirimTarihi = '2025-01-02';

