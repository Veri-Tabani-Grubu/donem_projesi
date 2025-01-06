

--Amaç
--Hastanýn ilaç kullanýmýný kaydetmek (baþlangýç ve bitiþ tarihleri ile birlikte).
--Oluþan kullaným için bildirimler oluþturmak (her gün için bildirim eklemek).
--Hatalý bir iþlemde tüm deðiþiklikleri geri almak (rollback).

---Hem ilaç kullanýmý hem de bildirim ekleme iþlemleri tek bir iþlemde yürütülür. Hata durumunda tüm deðiþiklikler geri alýnýr.
--- Ýþlemler modüler hale getirilir ve parametrelerle esnek bir yapý saðlanýr.
---Ýþlemin baþarýlý veya baþarýsýz olmasýna göre deðiþikliklerin durumu net bir þekilde yönetilir.

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
        BEGIN TRANSACTION;

        -- Ýlaç kullanýmý ekle
        INSERT INTO SaglikSistemi.Ýlaç_Kullanýmý (Hasta_ID, Ýlaç_ID, Baþlangýç_Tarihi, Bitiþ_Tarihi, Kullaným_Sýklýðý, Son_Kullaným_Tarihi)
        VALUES (@HastaID, @IlacID, @BaslangicTarihi, @BitisTarihi, @KullanimSikligi, NULL);

        -- Yeni eklenen Kullaným_ID'yi al
        DECLARE @YeniKullanimID INT = SCOPE_IDENTITY();

        -- Bildirim ekle
        INSERT INTO SaglikSistemi.Takvim_Bildirimler (Kullaným_ID, Kullaným_Tarihi, Kullaným_Saati, Durum_ID)
        VALUES (@YeniKullanimID, @BildirimTarihi, '08:00:00', 2);

        COMMIT TRANSACTION;
        PRINT 'Baþarýlý: Ýlaç kullanýmý ve bildirim eklendi.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Hata: Ýþlem sýrasýnda bir hata oluþtu. Tüm deðiþiklikler geri alýndý.';
        PRINT ERROR_MESSAGE();
    END CATCH
END;

--- baþlangýç tarihi bitiþ tarihinden önce olduðu için sorun olmaz.
----baþarýlý senaryodur.
EXEC AddMedicationAndNotification 
    @HastaID = 1,
    @IlacID = 1,
    @BaslangicTarihi = '2025-01-01',
    @BitisTarihi = '2025-03-01',
    @KullanimSikligi = 'Günde 3 kez',
    @BildirimTarihi = '2025-01-02';

----baþlangýç tarihi bitiþ tarihinden sonra olduðu için hata verir
----iþlem geri alýnýr
EXEC AddMedicationAndNotification 
    @HastaID = 1,
    @IlacID = 1,
    @BaslangicTarihi = '2025-01-01',
    @BitisTarihi = '2024-12-31', -- Baþlangýç tarihi, bitiþ tarihinden sonra
    @KullanimSikligi = 'Günde 3 kez',
    @BildirimTarihi = '2025-01-02';
