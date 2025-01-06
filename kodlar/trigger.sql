--Aþaðýdaki trigger, yeni bir hasta eklerken, kullanýcýnýn rolünün doðru olup olmadýðýný kontrol eder.
--Eðer eklenen kullanýcýnýn rolü "Hasta" deðilse, iþlemi iptal eder ve bir hata mesajý döner.
--saðlýk profesyoneli veya hasta yakýný için de ayrý trigger'lar yazýlabilir.

CREATE TRIGGER TRG_ValidateHastaRole
ON SaglikSistemi.Hasta
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Eklenen kullanýcýnýn rolünü kontrol et
    IF EXISTS (
        SELECT 1
        FROM Inserted I
        JOIN KullaniciYonetimi.Kullanýcýlar K
        ON I.Kullanýcý_ID = K.Kullanýcý_ID
        WHERE K.Rol <> 'Hasta'
    )
    BEGIN
        -- Ýþlemi iptal et ve hata döndür
        ROLLBACK TRANSACTION;
        THROW 50000, 'Eklenen kullanýcý hasta rolüne sahip olmalýdýr.', 1;
    END
END;

-- saðlýk profesyoneli olan bir kullanýcý oluþturduk
INSERT INTO KullaniciYonetimi.Kullanýcýlar (Rol, Ýsim, Soyisim, Eposta, Þifre)
VALUES ('Saðlýk Profesyoneli', 'Mehmet', 'Kaya', 'mehmet@example.com', 'sifre456');

-- bu saðlýk profesyonelini Hasta tablosuna eklemeye çalýþtýðýmýzda hata alýrýz
INSERT INTO SaglikSistemi.Hasta (Kullanýcý_ID, Cinsiyet, Doðum_Tarihi)
VALUES (10, 'Erkek', '1995-05-15'); -- Bu iþlem hata verecek ve rollback yapýlacaktýr.




