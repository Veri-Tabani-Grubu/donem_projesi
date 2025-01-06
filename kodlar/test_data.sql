-- Kullanýcýlar tablosundaki tüm kayýtlarý görüntüle
SELECT * FROM KullaniciYonetimi.Kullanýcýlar;

-- Belirli bir kullanýcýyý test et (örneðin Ahmet Yýlmaz)
SELECT * FROM KullaniciYonetimi.Kullanýcýlar
WHERE Ýsim = 'Ahmet' AND Soyisim = 'Yýlmaz';

-- Toplam kullanýcý sayýsýný kontrol et
SELECT COUNT(*) AS Toplam_Kullanýcýlar FROM KullaniciYonetimi.Kullanýcýlar;


      -------- ======Hasta tablosundaki tüm kayýtlarý görüntüle=====------
SELECT * FROM SaglikSistemi.Hasta;

SELECT 
    H.Hasta_ID,
	K.Kullanýcý_ID,
    K.Ýsim AS Hasta_Adý,
    K.Soyisim AS Hasta_Soyadý,
    K.Eposta AS Hasta_Eposta,
    H.Cinsiyet,
    H.Doðum_Tarihi,
    H.Kronik_Hastalýk,
    H.Teþhis_Tarihi,
    H.Alerjiler
FROM 
    SaglikSistemi.Hasta H
JOIN 
    KullaniciYonetimi.Kullanýcýlar K
ON 
    H.Kullanýcý_ID = K.Kullanýcý_ID;

-- Belirli bir hastayý test et 
SELECT * FROM SaglikSistemi.Hasta
WHERE Kullanýcý_ID = 2;

-- Toplam hasta sayýsýný kontrol et
SELECT COUNT(*) AS Toplam_Hastalar FROM SaglikSistemi.Hasta;


-----------========= Hasta Yakýný tablosundaki tüm kayýtlarý görüntüle========------------
SELECT * FROM KullaniciYonetimi.Hasta_Yakýný;

SELECT 
    HY.Yakýn_ID,
    H.Hasta_ID,
    HastaK.Ýsim AS Hasta_Adý,
    HastaK.Soyisim AS Hasta_Soyadý,
    YakýnK.Ýsim AS Yakýn_Adý,
    YakýnK.Soyisim AS Yakýn_Soyadý,
    HY.Yakýnlýk_Durumu
FROM 
    KullaniciYonetimi.Hasta_Yakýný HY
JOIN 
    SaglikSistemi.Hasta H
ON 
    HY.Hasta_ID = H.Hasta_ID
JOIN 
    KullaniciYonetimi.Kullanýcýlar HastaK
ON 
    H.Kullanýcý_ID = HastaK.Kullanýcý_ID
JOIN 
    KullaniciYonetimi.Kullanýcýlar YakýnK
ON 
    HY.Kullanýcý_ID = YakýnK.Kullanýcý_ID;

-- Belirli bir hasta yakýný test et (örneðin, Hasta_ID 1 ve Kullanýcý_ID 4 olan)
SELECT * FROM KullaniciYonetimi.Hasta_Yakýný
WHERE Hasta_ID = 1 AND Kullanýcý_ID = 4;

-- Toplam hasta yakýný sayýsýný kontrol et
SELECT COUNT(*) AS Toplam_Hasta_Yakýnlarý FROM KullaniciYonetimi.Hasta_Yakýný;


     -------- ======Saðlýk Profesyoneli tablosundaki tüm kayýtlarý görüntüle====------
SELECT * FROM KullaniciYonetimi.Saðlýk_Profesyoneli;

SELECT 
    SPH.Saðlýk_Prof_Hasta_ID as Takip_ID,
    SP.Saðlýk_Prof_ID,
    SPK.Ýsim AS Saðlýk_Profesyoneli_Adý,
    SPK.Soyisim AS Saðlýk_Profesyoneli_Soyadý,
    H.Hasta_ID,
    HastaK.Ýsim AS Hasta_Adý,
    HastaK.Soyisim AS Hasta_Soyadý,
    SPH.Tarih
FROM 
    SaglikSistemi.Saglik_Profesyoneli_Hasta SPH
JOIN 
    KullaniciYonetimi.Saðlýk_Profesyoneli SP
ON 
    SPH.Saðlýk_Prof_ID = SP.Saðlýk_Prof_ID
JOIN 
    KullaniciYonetimi.Kullanýcýlar SPK
ON 
    SP.Kullanýcý_ID = SPK.Kullanýcý_ID
JOIN 
    SaglikSistemi.Hasta H
ON 
    SPH.Hasta_ID = H.Hasta_ID
JOIN 
    KullaniciYonetimi.Kullanýcýlar HastaK
ON 
    H.Kullanýcý_ID = HastaK.Kullanýcý_ID;

-- Belirli bir saðlýk profesyonelini test et (örneðin Uzmanlýk Alaný Kardiyoloji olan)
SELECT * FROM KullaniciYonetimi.Saðlýk_Profesyoneli
WHERE Uzmanlýk_Alaný = 'Kardiyoloji';

-- Toplam saðlýk profesyoneli sayýsýný kontrol et
SELECT COUNT(*) AS Toplam_Saðlýk_Profesyonelleri FROM KullaniciYonetimi.Saðlýk_Profesyoneli;


------------========= Ýlaçlar tablosundaki tüm kayýtlarý görüntüle==========---------
SELECT * FROM SaglikSistemi.Ýlaçlar;

-- Belirli bir ilacý test et (örneðin Parol)
SELECT * FROM SaglikSistemi.Ýlaçlar
WHERE Ýlaç_Adý = 'Parol';

-- Toplam ilaç sayýsýný kontrol et
SELECT COUNT(*) AS Toplam_Ýlaçlar FROM SaglikSistemi.Ýlaçlar;


     ----------------=========== Ýlaç Kullanýmý tablosundaki tüm kayýtlarý görüntüle========-----------
SELECT * FROM SaglikSistemi.Ýlaç_Kullanýmý;

SELECT 
    IK.Kullaným_ID,
    H.Hasta_ID,
    K.Ýsim AS Hasta_Adý,
    K.Soyisim AS Hasta_Soyadý,
	I.Ýlaç_ID,
    I.Ýlaç_Adý,
    IK.Baþlangýç_Tarihi,
    IK.Bitiþ_Tarihi,
    IK.Kullaným_Sýklýðý,
    IK.Son_Kullaným_Tarihi
FROM 
    SaglikSistemi.Ýlaç_Kullanýmý IK
JOIN 
    SaglikSistemi.Hasta H
ON 
    IK.Hasta_ID = H.Hasta_ID
JOIN 
    KullaniciYonetimi.Kullanýcýlar K
ON 
    H.Kullanýcý_ID = K.Kullanýcý_ID
JOIN 
    SaglikSistemi.Ýlaçlar I
ON 
    IK.Ýlaç_ID = I.Ýlaç_ID;

-- Belirli bir ilaç kullanýmýný test et (örneðin Hasta_ID 1 ve Ýlaç_ID 1 olan)
SELECT * FROM SaglikSistemi.Ýlaç_Kullanýmý
WHERE Hasta_ID = 1 AND Ýlaç_ID = 1;

-- Toplam ilaç kullanýmý sayýsýný kontrol et
SELECT COUNT(*) AS Toplam_Ýlaç_Kullanýmlarý FROM SaglikSistemi.Ýlaç_Kullanýmý;


       ----------========= Saðlýk Profesyoneli-Hasta tablosundaki tüm kayýtlarý görüntüle=====-------
SELECT * FROM SaglikSistemi.Saglik_Profesyoneli_Hasta;

SELECT 
    SPH.Saðlýk_Prof_Hasta_ID AS ID,
    SP.Saðlýk_Prof_ID AS Doktor_ID,
    DoktorK.Ýsim AS Doktor_Adý,
    DoktorK.Soyisim AS Doktor_Soyadý,
    H.Hasta_ID AS Hasta_ID,
    HastaK.Ýsim AS Hasta_Adý,
    HastaK.Soyisim AS Hasta_Soyadý,
    SPH.Tarih AS Görüþme_Tarihi
FROM 
    SaglikSistemi.Saglik_Profesyoneli_Hasta SPH
JOIN 
    KullaniciYonetimi.Saðlýk_Profesyoneli SP
ON 
    SPH.Saðlýk_Prof_ID = SP.Saðlýk_Prof_ID
JOIN 
    KullaniciYonetimi.Kullanýcýlar DoktorK
ON 
    SP.Kullanýcý_ID = DoktorK.Kullanýcý_ID
JOIN 
    SaglikSistemi.Hasta H
ON 
    SPH.Hasta_ID = H.Hasta_ID
JOIN 
    KullaniciYonetimi.Kullanýcýlar HastaK
ON 
    H.Kullanýcý_ID = HastaK.Kullanýcý_ID;

-- Belirli bir iliþkiyi test et (örneðin Saðlýk_Prof_ID 1 ve Hasta_ID 1 olan)
SELECT * FROM SaglikSistemi.Saglik_Profesyoneli_Hasta
WHERE Saðlýk_Prof_ID = 1 AND Hasta_ID = 1;

-- Toplam iliþki sayýsýný kontrol et
SELECT COUNT(*) AS Toplam_Ýliþkiler FROM SaglikSistemi.Saglik_Profesyoneli_Hasta;


   ----------==========Bildirim Durum tablosundaki tüm kayýtlarý görüntüle========-----
SELECT * FROM SaglikSistemi.Bildirim_Durum;

-- Belirli bir bildirim durumunu test et (örneðin Tamamlandý)
SELECT * FROM SaglikSistemi.Bildirim_Durum
WHERE Bildirim_Durumu = 'Tamamlandý';

-- Toplam bildirim durumu sayýsýný kontrol et
SELECT COUNT(*) AS Toplam_Bildirim_Durumlarý FROM SaglikSistemi.Bildirim_Durum;


 ---------========== Takvim Bildirimler tablosundaki tüm kayýtlarý görüntüle=======--------
SELECT * FROM SaglikSistemi.Takvim_Bildirimler;

SELECT 
    TB.Bildirim_ID AS Bildirim_ID,
    TB.Kullaným_Tarihi AS Kullaným_Tarihi,
    TB.Kullaným_Saati AS Kullaným_Saati,
    TB.Durum_ID AS Durum_ID,
    BD.Bildirim_Durumu AS Durum_Bilgisi,
    IK.Hasta_ID AS Hasta_ID,
    K.Ýsim AS Hasta_Adý,
    K.Soyisim AS Hasta_Soyadý,
    IK.Ýlaç_ID AS Ýlaç_ID,
    I.Ýlaç_Adý AS Ýlaç_Adý
FROM 
    SaglikSistemi.Takvim_Bildirimler TB
JOIN 
    SaglikSistemi.Ýlaç_Kullanýmý IK
ON 
    TB.Kullaným_ID = IK.Kullaným_ID
JOIN 
    SaglikSistemi.Hasta H
ON 
    IK.Hasta_ID = H.Hasta_ID
JOIN 
    KullaniciYonetimi.Kullanýcýlar K
ON 
    H.Kullanýcý_ID = K.Kullanýcý_ID
JOIN 
    SaglikSistemi.Ýlaçlar I
ON 
    IK.Ýlaç_ID = I.Ýlaç_ID
LEFT JOIN 
    SaglikSistemi.Bildirim_Durum BD
ON 
    TB.Durum_ID = BD.Durum_ID;

-- Belirli bir bildirimi test et (örneðin Kullaným_ID 1 ve Tarih 2023-01-02 olan)
SELECT * FROM SaglikSistemi.Takvim_Bildirimler
WHERE Kullaným_ID = 1 AND Kullaným_Tarihi = '2023-01-02';

-- Toplam takvim bildirimi sayýsýný kontrol et
SELECT COUNT(*) AS Toplam_Takvim_Bildirimleri FROM SaglikSistemi.Takvim_Bildirimler;
