

--Ama�
--Hastan�n ila� kullan�m�n� kaydetmek (ba�lang�� ve biti� tarihleri ile birlikte).
--Olu�an kullan�m i�in bildirimler olu�turmak (her g�n i�in bildirim eklemek).
--Hatal� bir i�lemde t�m de�i�iklikleri geri almak (rollback).

---Hem ila� kullan�m� hem de bildirim ekleme i�lemleri tek bir i�lemde y�r�t�l�r. Hata durumunda t�m de�i�iklikler geri al�n�r.
--- ��lemler mod�ler hale getirilir ve parametrelerle esnek bir yap� sa�lan�r.
---��lemin ba�ar�l� veya ba�ar�s�z olmas�na g�re de�i�ikliklerin durumu net bir �ekilde y�netilir.

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

        -- �la� kullan�m� ekle
        INSERT INTO SaglikSistemi.�la�_Kullan�m� (Hasta_ID, �la�_ID, Ba�lang��_Tarihi, Biti�_Tarihi, Kullan�m_S�kl���, Son_Kullan�m_Tarihi)
        VALUES (@HastaID, @IlacID, @BaslangicTarihi, @BitisTarihi, @KullanimSikligi, NULL);

        -- Yeni eklenen Kullan�m_ID'yi al
        DECLARE @YeniKullanimID INT = SCOPE_IDENTITY();

        -- Bildirim ekle
        INSERT INTO SaglikSistemi.Takvim_Bildirimler (Kullan�m_ID, Kullan�m_Tarihi, Kullan�m_Saati, Durum_ID)
        VALUES (@YeniKullanimID, @BildirimTarihi, '08:00:00', 2);

        COMMIT TRANSACTION;
        PRINT 'Ba�ar�l�: �la� kullan�m� ve bildirim eklendi.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Hata: ��lem s�ras�nda bir hata olu�tu. T�m de�i�iklikler geri al�nd�.';
        PRINT ERROR_MESSAGE();
    END CATCH
END;

--- ba�lang�� tarihi biti� tarihinden �nce oldu�u i�in sorun olmaz.
----ba�ar�l� senaryodur.
EXEC AddMedicationAndNotification 
    @HastaID = 1,
    @IlacID = 1,
    @BaslangicTarihi = '2025-01-01',
    @BitisTarihi = '2025-03-01',
    @KullanimSikligi = 'G�nde 3 kez',
    @BildirimTarihi = '2025-01-02';

----ba�lang�� tarihi biti� tarihinden sonra oldu�u i�in hata verir
----i�lem geri al�n�r
EXEC AddMedicationAndNotification 
    @HastaID = 1,
    @IlacID = 1,
    @BaslangicTarihi = '2025-01-01',
    @BitisTarihi = '2024-12-31', -- Ba�lang�� tarihi, biti� tarihinden sonra
    @KullanimSikligi = 'G�nde 3 kez',
    @BildirimTarihi = '2025-01-02';
