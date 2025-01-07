--A�a��daki trigger, yeni bir hasta eklerken, kullan�c�n�n rol�n�n do�ru olup olmad���n� kontrol eder.
--E�er eklenen kullan�c�n�n rol� "Hasta" de�ilse, i�lemi iptal eder ve bir hata mesaj� d�ner.
--sa�l�k profesyoneli veya hasta yak�n� i�in de ayr� trigger'lar yaz�labilir.


--DROP TRIGGER SaglikSistemi.TRG_ValidateHastaRole; --triggeri siler

--bu komutu �al��t�rd���m�zda bir �ey d�nd�rmezse trigger silinmi� demektir
--SELECT name 
--FROM sys.triggers
--WHERE name = 'TRG_ValidateHastaRole';


CREATE TRIGGER TRG_ValidateHastaRole
ON SaglikSistemi.Hasta
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Eklenen kullan�c�n�n rol�n� kontrol et
    IF EXISTS (
        SELECT 1
        FROM Inserted I
        JOIN KullaniciYonetimi.Kullan�c�lar K
        ON I.Kullan�c�_ID = K.Kullan�c�_ID
        WHERE K.Rol <> 'Hasta'
    )
    BEGIN
        -- ��lemi iptal et ve hata d�nd�r
        ROLLBACK TRANSACTION;
        THROW 50000, 'Eklenen kullan�c� hasta rol�ne sahip olmal�d�r.', 1;
    END
END;

-- sa�l�k profesyoneli olan bir kullan�c� olu�turduk
INSERT INTO KullaniciYonetimi.Kullan�c�lar (Rol, �sim, Soyisim, Eposta, �ifre)
VALUES ('Sa�l�k Profesyoneli', 'Mehmet', 'Kaya', 'mehmet@example.com', 'sifre456');

-- bu sa�l�k profesyonelini Hasta tablosuna eklemeye �al��t���m�zda hata al�r�z
INSERT INTO SaglikSistemi.Hasta (Kullan�c�_ID, Cinsiyet, Do�um_Tarihi)
VALUES (1, 'Erkek', '1995-05-15'); -- Bu i�lem hata verecek ve rollback yap�lacakt�r.




